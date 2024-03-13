require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
  let(:article) { create(:article) }

  it 'returns a success response' do
    get :show, params: { id: article.id }
    expect(response).to be_successful
  end

  it 'returns a 404 response if article not found' do
    non_existent_id = 'non_existent_id'
    get :show, params: { id: non_existent_id }
    expect(response).to have_http_status(404)
  end
end

  describe 'POST #create' do
  let(:valid_attributes) { attributes_for(:article) }
  let(:invalid_attributes) { { title: nil, body: nil, author: nil } }

  context 'with valid params' do
    it 'creates a new article' do
      expect {
        post :create, params: { article: valid_attributes }
      }.to change(Article, :count).by(1)
    end

    it 'renders a JSON response with the new article' do
      post :create, params: { article: valid_attributes }
      expect(response).to have_http_status(200)
    end
  end

  context 'with invalid params' do
    it 'renders a JSON response with errors' do
      post :create, params: { article: invalid_attributes }
      expect(response).to have_http_status(422)
    end
  end
end

describe 'PUT #update' do
let(:article) { create(:article) }

context 'with valid params' do
  let(:valid_params) { { title: 'Updated Title', body: 'Updated Body', author: 'Updated Author' } }

  it 'updates the article' do
    put :update, params: { id: article.id, article: valid_params }
    expect(response).to have_http_status(:success)
    expect(article.reload.title).to eq 'Updated Title'
    expect(article.reload.body).to eq 'Updated Body'
    expect(article.reload.author).to eq 'Updated Author'
  end
end

context 'with invalid params' do
  let(:invalid_params) { { title: '', body: '', author: '' } }

  it 'returns an error' do
    put :update, params: { id: article.id, article: invalid_params }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(JSON.parse(response.body)).to include('error' => 'Error updating article')
  end
end

context 'when article not found' do
  it 'returns a not found error' do
    put :update, params: { id: 'invalid_id', article: { title: 'Updated Title' } }
    expect(response).to have_http_status(:not_found)
    expect(JSON.parse(response.body)).to include('error' => 'Article not found')
  end
end
end

  describe 'DELETE #destroy' do
    let!(:article) { create(:article) }

    it 'destroys the requested article' do
      expect {
        delete :destroy, params: { id: article.id }
      }.to change(Article, :count).by(-1)
    end

    it 'renders a JSON response with the success message' do
      delete :destroy, params: { id: article.id }
      expect(response).to have_http_status(200)
    end

    it 'returns a 404 response if article not found' do
      delete :destroy, params: { id: 'non_existent_id' }
      expect(response).to have_http_status(404)
    end
  end
end
