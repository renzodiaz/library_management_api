FactoryBot.define do
  factory :api_key do
    app_name { "Vue app" }
    key { "randomKey" }
    active { true }
  end
end
