# app/models/article.rb

class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 5, maximum: 100 }
    validates :body, presence: true, length: { minimum: 10 }
    validates :author, presence: true, length: { minimum: 3, maximum: 50 }
  end
  