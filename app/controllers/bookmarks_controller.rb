# frozen_string_literal: true

# ブックマークコントローラー
class BookmarksController < ApplicationController
  # ユーザーが(createとnewのみ)ログインしていることを確認
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[show edit update destroy]

  # ユーザーの生成結果を一覧表示(並び替え、検索あり、モデル参照)
  def index
    @bookmarks = current_user.bookmarks.includes(:user).search(params[:search]).order_by(params[:order])
  end

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
  end

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    # フォームから保存したものはis_originalとする。パラメータが含まれていない場合、APIからのレスポンスとして扱う
    @bookmark.is_original = bookmark_params[:is_original] == 'true'

    if @bookmark.is_original
      original_bookmark
    else
      generated_bookmark
    end
  end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to bookmark_path
    else
      render :edit
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  private

  # ユーザー自身でドリンク言葉を作る場合(is_original = true)
  def original_bookmark
    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new
    end
  end

  # aiによる生成結果をブックマークする場合(is_original = false)
  def generated_bookmark
    base64_image = params[:bookmark][:image] # フォームから送信されたBase64画像データ
    filename = "bookmark_#{Time.zone.now.to_i}" # 任意のファイル名
    @bookmark.download_image(base64_image, filename) if base64_image.present?

    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new
    end
  end

  def set_bookmark
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:generated_drink, :generated_word, :generated_info, :image, :image_cache, :memo,
                                     :is_original)
  end
end
