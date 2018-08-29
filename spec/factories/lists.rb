FactoryBot.define do
  factory :list do
    association :user
    name {"Test List"}
  end
end
