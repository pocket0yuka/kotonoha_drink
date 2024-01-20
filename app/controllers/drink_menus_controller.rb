class DrinkMenusController < ApplicationController
  def index
    @categories = Drink.all.group_by(&:category)
  end
end
