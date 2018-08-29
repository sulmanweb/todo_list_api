FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "Sulman Baig #{n}"}
    sequence(:email) {|n| "sulmanweb#{n}@gmail.com"}
    password {"abcd@1234"}
  end
end
