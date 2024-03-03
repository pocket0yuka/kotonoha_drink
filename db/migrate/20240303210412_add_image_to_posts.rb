class AddImageToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :image, :string
    add_column :posts, :image_cache, :string

  end
end
