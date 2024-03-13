# spec/factories/articles.rb
# FactoryBot.define do
#     factory :article do
#       title { "Example Title" }
#       body { "Lorem ipsum dolor sit amet" }
#       author { "John Doe" }
#     end
#   end

require 'faker'

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.paragraph(sentence_count: 3) }
    author { Faker::Name.name }
  end
end


  def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
  end
  