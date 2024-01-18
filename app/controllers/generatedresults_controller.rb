class GeneratedresultsController < ApplicationController
  #ユーザーが(createとnewのみ)ログインしていることを確認
  before_action :authenticate_user!, only: %i[new create]

  #フォームから送信されたデータを使用して新しいレコードを作成
  def create
    @generated_result = current_user.generatedresults.new(generatedresult_params)
    if @generated_result.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    if params[:keyword].present?
      service = OpenAiService.new
      # ドリンクの情報を取得
      @generated_results = service.generate_drink_words(params[:keyword])
      # ドリンク名から画像のURLを取得
      @image_url = service.generate_image_url(@generated_results[:drink_name]) if @generated_results.present?
    else
      @generated_results = nil
      @image_url = nil
    end
  end

  private

  def generatedresult_params
    params.require(:generatedresult).permit(:generated_drink, :generated_word, :generated_info, :image_url)
  end
end
