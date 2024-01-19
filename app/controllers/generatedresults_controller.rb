class GeneratedresultsController < ApplicationController

  def show
    if params[:keyword].present?
      service = OpenAiService.new
      # ドリンクの情報を取得
      @generated_results = service.generate_drink_words(params[:keyword])
      # ドリンク名から画像のURLを取得
      #@image_url = service.generate_image_url(@generated_results[:drink_name]) if @generated_results.present?
    else
      @generated_results = nil
      #@image_url = nil
    end
  end

  private

  def generatedresult_params
    params.require(:generatedresult).permit(:generated_drink, :generated_word, :generated_info, :image_url)
  end
end