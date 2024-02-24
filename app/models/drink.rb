# frozen_string_literal: true

# ドリンクメニュー表のドリンクに関するモデル
class Drink < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  paginates_per 20

  enum category: {
    cafe: 0,
    coffee: 1,
    soft_drink: 2,
    tea: 3,
    non_alcoholic_cocktail: 4,
    cocktail: 5,
    whiskey: 6,
    sake: 7,
    wine: 8,
    beer: 9
  }
end
