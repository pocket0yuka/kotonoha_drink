# (ソーシャルシェア兼)みんなが作ったドリンク言葉一覧
class SocialsharingsController < ApplicationController
  def show
    @socialsharing = Socialsharing.find(params[:id])
  end

  def index
    @socialsharings = Socialsharing.all.order(created_at: :desc)
  end

  def create
    @socialsharing = Socialsharing.new(socialsharing_params)
    if @socialsharing.save
      redirect_to socialsharings_path
    else
      render :new
    end

  end

  private

  def socialsharing_params
    params.require(:socialsharing).permit(:generated_drink, :generated_word, :generated_info, :image)
  end
end
