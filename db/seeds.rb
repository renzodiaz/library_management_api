require 'faker'

# Genrate API KEY
ApiKey.create(app_name: "Vue")

# Generate authors
author1 = Author.create!(
  first_name: Faker::Artist.name,
  last_name: Faker::Artist.name
)

author2 = Author.create!(
  first_name: Faker::Artist.name,
  last_name: Faker::Artist.name
)

author3 = Author.create!(
  first_name: Faker::Artist.name,
  last_name: Faker::Artist.name
)

(5).times do
  Book.create!(
    title: Faker::Book.title,
    genre: Faker::Book.genre,
    isbn: Faker::Bank.account_number,
    total_copies: Faker::Number.between(from: 1, to: 10),
    author: author1
  )
end

(5).times do
  Book.create!(
    title: Faker::Book.title,
    genre: Faker::Book.genre,
    isbn: Faker::Bank.account_number,
    total_copies: Faker::Number.between(from: 1, to: 10),
    author: author2
  )
end

(5).times do
  Book.create!(
    title: Faker::Book.title,
    genre: Faker::Book.genre,
    isbn: Faker::Bank.account_number,
    total_copies: Faker::Number.between(from: 1, to: 10),
    author: author3
  )
end
