# frozen_string_literal: true

# (story)文章で注文を記載するフォームのバリデーション内容
class StoryForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :story

  validates :story, presence: true, length: { maximum: 60 }
end
