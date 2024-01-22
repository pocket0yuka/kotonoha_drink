class StoryForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :story

  validates :story, presence: true, length: { maximum: 60 }
end
