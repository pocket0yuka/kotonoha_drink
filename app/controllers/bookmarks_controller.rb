class BookmarksController < ApplicationController
  #ユーザーが(createとnewのみ)ログインしていることを確認
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[show edit update destroy]

  # ユーザーの生成結果を一覧表示(並び替え、検索あり、モデル参照)
  def index
    @bookmarks = current_user.bookmarks.includes(:user).search(params[:search]).order_by(params[:order])
  end

  def show
  end

  def edit
  end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to bookmark_path, notice: 'ブックマークを更新しました。'
    else
      render :edit, alert: 'ブックマークの更新に失敗しました。'
    end
  end

  #フォームから送信されたデータを使用して新しいレコードを作成
  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    # フォームから保存したものはis_originalとする。パラメータが含まれていない場合、APIからのレスポンスとして扱う
    @bookmark.is_original = bookmark_params[:is_original].present? ? bookmark_params[:is_original] : false
    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new, alert: 'ブックマークの保存に失敗しました。'
    end
  end

  def destroy
    if @bookmark.destroy
      redirect_to bookmarks_path, notice: 'ブックマークを削除しました。'
    else
      redirect_to bookmarks_path, alert: 'ブックマークの削除に失敗しました。'
    end
  end

  private

  def set_bookmark
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:generated_drink, :generated_word, :generated_info, :image, :memo, :is_original)
  end
end
