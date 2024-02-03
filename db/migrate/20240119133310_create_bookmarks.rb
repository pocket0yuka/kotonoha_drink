class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true

      t.string :generated_drink
      t.string :generated_word
      t.text :generated_info
      t.string :image #アップロード用
      t.string :image_url #api画像保存用
      t.string :image_cache
      t.text :memo
      t.boolean :is_original

      t.timestamps
    end
  end
end
