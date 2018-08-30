FactoryBot.define do
  factory :item do
    association :user
    association :list
    name {"Test Item"}
    status {false}
  end
end
