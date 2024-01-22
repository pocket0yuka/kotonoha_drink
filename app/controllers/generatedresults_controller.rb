class GeneratedresultsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :initialize_service

  #storyフォーム作成
  def new
    @story_form = StoryForm.new
  end

  #storyフォームの入力をバリデーション処理する
  def create
    @story_form = StoryForm.new(story_form_params)
    if @story_form.valid?
      request_story(@story_form.story)
    else
      render :new
    end
  end

  def show
    if params[:keyword].present?
      request_keyword(params[:keyword])
    elsif story_params_present?
      request_story(params[:story])
    else
      set_default_results
    end
  end

  private

  #storyフォームのバリデーション適用パラメータを渡す
  def story_form_params
    params.require(:story_form).permit(:story)
  end

  #サービスの初期化
  def initialize_service
    @service = OpenAiService.new
  end

  #キーワードでリクエスト
  def request_keyword(keyword)
    @generated_results = @service.generate_drink_words(keyword)
    #generate_image_url if @generated_results.present?
    check_api_response
  end

  # ドリンク名から画像のURLを取得
  #def generate_image_url
    #@image_url = @service.generate_image_url(@generated_results[:first_candidate][:drink_name])
  #end

  #storyパラメータでリクエスト
  def request_story(story)
    @generated_results = @service.generate_drink_words(story)
    check_api_response
  end

  #レスポンスに問題があった場合の処理
  def check_api_response
    if @generated_results.nil? #|| @image_url.nil?
      flash[:alert] = 'ドリンクの情報または画像を取得できませんでした。'
      redirect_to generatedresults_path # パスにリダイレクト
    end
  end

  #何もリクエストがなかった場合の処理
  def set_default_results
    @generated_results = nil
    #@image_url = nil
  end

  #storyパラメータの有無
  def story_params_present?
    params[:story].present?
  end

  #レスポンスのパラメータを許可
  def generatedresult_params
    params.require(:generatedresult).permit(:generated_drink, :generated_word, :generated_info, :image_url)
  end
end
