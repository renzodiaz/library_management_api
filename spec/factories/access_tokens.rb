FactoryBot.define do
  factory :access_token do
    token_digest { nil }
    user
    api_key
    accessed_at { "2025-08-18 08:12:13" }
  end
end
