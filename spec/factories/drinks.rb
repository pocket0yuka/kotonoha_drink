FactoryBot.define do
  factory :drink do
    name { "ドリンク" }
    word { "ドリンク言葉" }
    info { "ドリンク情報" }
    image { "0_0.png" }
    category { :cafe  }
    display_order { "1" }
  end
end
