# frozen_string_literal: true

# postとtagの中間テーブル
class Posttag < ApplicationRecord
  belongs_to :tag
  belongs_to :post
end
