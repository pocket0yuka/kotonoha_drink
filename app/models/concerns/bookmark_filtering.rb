# frozen_string_literal: true

# ブックマークのフィルタリングのロジック内容
module BookmarkFiltering
  extend ActiveSupport::Concern

  included do
    scope :search, lambda { |keyword|
      if keyword.present?
        like_keyword = "%#{keyword}%"
        where('generated_drink LIKE :keyword OR generated_word LIKE :keyword OR generated_info LIKE :keyword OR memo LIKE :keyword', keyword: like_keyword)
      end
    }

    scope :order_by, lambda { |order|
      case order
      when 'created_at_desc'
        order(created_at: :desc)
      when 'created_at_asc'
        order(created_at: :asc)
      when 'alphabetical'
        order('generated_drink ASC')
      when 'is_original'
        order(is_original: :desc)
      end || order(created_at: :desc)
      # デフォルトの並び順
    }
  end
end
