# frozen_string_literal: true

# Application helper
module ApplicationHelper
  def default_meta_tags
    {
      site: '言の葉ドリンク',
      title: 'ドリンク言葉生成アプリ',
      reverse: true,
      charset: 'utf-8',
      description: 'ドリンク名からドリンク言葉を生成、ドリンクを提案します',
      keywords: 'ドリンク,ドリンク言葉',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp2.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('ogp2.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
