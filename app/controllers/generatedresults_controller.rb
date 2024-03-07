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

  # API接続回数の確認と制限
  def check_api_limit
    # 空文字または空白のみでないことを確認
    return if story.blank? || keyword.blank?

    # ログインしている場合はユーザーID、していない場合はセッションIDを使用
    date = Time.current.to_date.to_s
    user_or_session = user_signed_in? ? "user:#{current_user.id}" : "session:#{session.id}"
    key = "#{user_or_session}:api_count:#{date}"
    count = $redis.get(key).to_i # 現在のカウントを取得、未設定なら0

    if count >= 3
      # Redisからキーの残りTTL(生存時間)を取得
      ttl = $redis.ttl(key)
      # 秒数を時間、分、秒に変換
      hours = ttl.divmod(3600)[0]
      minutes = ttl.divmod(3600)[1].divmod(60)[0]
      seconds = ttl.divmod(3600)[1].divmod(60)[1]
      # フラッシュメッセージに残り時間を含める
      flash[:alert] = "本日のドリンク生成の上限に達しました。次に利用可能になるまであと #{hours}時間#{minutes}分#{seconds}秒です。"
      redirect_to root_path
    else
      # カウントを1増やし、その日の終わりまで有効期限を設定
      now = Time.current
      end_of_day = now.end_of_day
      seconds_until_end_of_day = (end_of_day - now).to_i

      $redis.set(key, count + 1, ex: seconds_until_end_of_day)
    end
  end
end
