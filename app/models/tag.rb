class Tag < ApplicationRecord
  has_many :posttags, dependent: :destroy
end
