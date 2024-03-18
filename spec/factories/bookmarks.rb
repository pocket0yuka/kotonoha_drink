FactoryBot.define do
  factory :bookmark do
    user
    generated_drink { "ドリンク" }
    generated_word { "言の葉ドリンク" }
    generated_info { "言の葉ドリンク情報" }
    image { "test_image" }
    image_cache { "test_image" }
    memo { "ドリンクメモ" }
    is_original { false }
  end
end
