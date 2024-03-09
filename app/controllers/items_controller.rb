class ItemsController < ApplicationController
  def search
    if params[:keyword]
      search_keyword = params[:keyword] + " プレゼント"
      @items = RakutenWebService::Ichiba::Item.search(keyword: search_keyword)

      # 商品が見つからなかった場合のメッセージを設定
      if @items.count == 0
        flash.now[:alert] = "該当する商品が見つかりませんでした。"
      end
    end
  end
end
