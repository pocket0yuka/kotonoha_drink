FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user
    association :visited, factory: :user
    association :post
    action { "いいね" }
    checked { false }
  end
end
