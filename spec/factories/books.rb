FactoryBot.define do
  factory :book do
    title { "My first book" }
    genre { "novel" }
    isbn { "123456" }
    total_copies { 1000 }
    author
  end

  factory :book_2, class: Book do
    title { "My second book" }
    genre { "comic" }
    isbn { "654321" }
    total_copies { 1000 }
    author
  end

  factory :book_3, class: Book do
    title { "My third book" }
    genre { "drama" }
    isbn { "321654" }
    total_copies { 1000 }
    author
  end
end
