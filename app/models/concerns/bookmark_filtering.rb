#ブックマークのフィルタリングのロジック内容
module BookmarkFiltering
  extend ActiveSupport::Concern

  included do
    scope :search, ->(keyword) {
      where("generated_drink LIKE ? OR generated_word LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
    }

    scope :order_by, ->(order) {
      case order
      when 'created_at_desc'
        order(created_at: :desc)
      when 'created_at_asc'
        order(created_at: :asc)
      when 'alphabetical'
        order('generated_drink ASC')
      when 'is_original'
        order(is_original: :desc)
      else
        order(created_at: :desc) # デフォルトの並び順
      end
    }
  end
end
