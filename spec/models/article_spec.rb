# spec/models/article_spec.rb

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(5).is_at_most(100) }

    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(10) }

    it { should validate_presence_of(:author) }
    it { should validate_length_of(:author).is_at_least(3).is_at_most(50) }
  end
end
