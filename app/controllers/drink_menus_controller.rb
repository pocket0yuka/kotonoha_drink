# frozen_string_literal: true

# ドリンクメニュー表のコントローラ
class DrinkMenusController < ApplicationController
  def index
    @categories = Drink.select(:category).distinct.order(:category).page(params[:page]).per(1)
    @drinks = Drink.where(category: @categories.first.category).order(:display_order)
  end
end
