class AddImageToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :image, :string
    add_column :posts, :image_cache, :string
    add_column :posts, :drink_word, :string

  end
end
