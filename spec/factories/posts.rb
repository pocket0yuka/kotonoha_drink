FactoryBot.define do
  factory :post do
    user
    body { "ドリンク投稿" }
    visibility { 0 }
  end
end
