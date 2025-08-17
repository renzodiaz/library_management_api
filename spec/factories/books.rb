FactoryBot.define do
  factory :book do
    title { "My first book" }
    genre { "novel" }
    isbn { "123456" }
    total_copies { 1000 }
    author
  end
end
