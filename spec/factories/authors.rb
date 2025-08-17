FactoryBot.define do
  factory :author, aliases: ["john_doe"] do
    first_name { "John" }
    last_name { "Doe" }
  end
end
