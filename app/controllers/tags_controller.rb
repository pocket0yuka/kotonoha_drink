# frozen_string_literal: true

# タグのコントローラ
class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tag = Tag.ransack(params[:q])
    @tags = @tag.result
  end

  def search
    @tags = Tag.where('name like ?', "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
