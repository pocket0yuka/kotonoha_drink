class DrinkwordsController < ApplicationController
  def show
    service = OpenAiService.new
    # ドリンクの情報を取得
    @generated_results = service.generate_drink_words(params[:keyword])
    # ドリンク名から画像のURLを取得
    @image_url = service.generate_image_url(@generated_results[:drink_name])
  end
end