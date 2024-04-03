# frozen_string_literal: true

# (ソーシャルシェア兼)みんなが作ったドリンク言葉一覧
class SocialsharingsController < ApplicationController
  def index
    @socialsharings = Socialsharing.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @socialsharing = Socialsharing.find(params[:id])
  end

  def create
    @socialsharing = Socialsharing.new(socialsharing_params)
    image_data
    if @socialsharing.save
      redirect_to socialsharing_path(@socialsharing)
    else
      render :new
    end
  end

  private

  def image_data
    base64_image = params[:socialsharing][:image] # フォームから送信されたBase64画像データ
    filename = "socialsharing_#{Time.zone.now.to_i}" # 任意のファイル名
    @socialsharing.download_image(base64_image, filename) if base64_image.present?
  end

  def socialsharing_params
    params.require(:socialsharing).permit(:generated_drink, :generated_word, :generated_info, :image)
  end
end
