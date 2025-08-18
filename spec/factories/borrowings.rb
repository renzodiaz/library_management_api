FactoryBot.define do
  factory :borrowing do
    user
    book
    borrowed_at { Time.current }
    due_date { nil }
    returned_at { nil }
  end
end
