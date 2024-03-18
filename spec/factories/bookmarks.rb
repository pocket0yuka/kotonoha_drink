FactoryBot.define do
  factory :bookmark do
    user
    generated_drink { "ドリンク" }
    generated_word { "言の葉ドリンク" }
    generated_info { "言の葉ドリンク情報" }
    image { "0_0.png" }
    image_cache { "0_0.png" }
    memo { "ドリンクメモ" }
    is_original { false }
  end
end
