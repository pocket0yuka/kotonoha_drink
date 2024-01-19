class BookmarksController < ApplicationController
  #ユーザーが(createとnewのみ)ログインしていることを確認
  before_action :authenticate_user!, only: %i[index show create destroy ]
  before_action :set_bookmark, only: %i[show destroy]

  # ユーザーの生成結果を一覧表示
  def index
    @bookmarks = current_user.bookmarks
  end

  def show
  end

  #フォームから送信されたデータを使用して新しいレコードを作成
  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    if @bookmark.save
      redirect_to bookmarks_path, notice: 'ブックマークを保存しました。'
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
    params.require(:bookmark).permit(:generated_drink, :generated_word, :generated_info, :image_url, :memo, :is_original)
  end
end
