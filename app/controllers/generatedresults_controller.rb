# frozen_string_literal: true

# ドリンク言葉生成機能のコントローラ(apiリクエストとレスポンスを操作)
class GeneratedresultsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :initialize_service

  def show
    if params[:keyword].present?
      request_keyword(params[:keyword])
    elsif story_params_present?
      request_story(params[:story_form][:story])
    else
      @generated_results = nil
      @image = nil
    end
  end

  # storyフォーム作成
  def new
    @story_form = StoryForm.new
  end

  # storyフォームの入力をバリデーション処理する
  def create
    @story_form = StoryForm.new(story_form_params)
    if @story_form.valid?
      request_story(@story_form.story)
    else
      render :new
    end
  end

  private

  # storyフォームのバリデーション適用パラメータを渡す
  def story_form_params
    params.require(:story_form).permit(:story)
  end

  # サービスの初期化
  def initialize_service
    @service = OpenAiService.new
  end

  # キーワードでリクエスト
  def request_keyword(keyword)
    @generated_results = @service.generate_drink_words(keyword)
    generate_image if @generated_results.present?
    check_api_response
  end

  # ドリンク名から画像のURLを取得
  def generate_image
    @image = @service.generate_image(@generated_results[:drink_name])
  end

  # storyパラメータでリクエスト
  def request_story(story)
    @generated_results = @service.generate_story_drink_words(story)
    generate_image if @generated_results.present?
    check_api_response
  end

  # レスポンスに問題があった場合の処理
  def check_api_response
    return unless @generated_results.nil? || @image.nil?

    flash[:alert] = 'ドリンクの情報または画像を取得できませんでした。'
    redirect_to generatedresults_path # パスにリダイレクト
  end

  # storyパラメータの有無
  def story_params_present?
    params[:story_form].present? && params[:story_form][:story].present?
  end
end
