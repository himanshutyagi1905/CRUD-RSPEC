class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: 200
    else
      render json: { error: 'Article Not Found' }, status: 404
    end
  end
  def create
    article = Article.new(arti_params)
    if article.save
      render json: article, status: :ok
    else 
      render json: { error: "Error Creating.." }, status: :unprocessable_entity
    end
  end
  

  def update
    article = Article.find_by(id: params[:id])
    if article
      if article.update(arti_params)
        render json: article, status: 200
      else
        render json: { error: 'Error updating article' }, status: 422
      end
    else
      render json: { error: 'Article not found' }, status: 404
    end
  end
  

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: "Article deleted"
    else
      render json: { error: 'Article not found' }, status: :not_found
    end
  end

  private
  def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
  end
end
