class CreatePosttags < ActiveRecord::Migration[7.0]
  def change
    create_table :posttags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
