class CreateGeneratedresults < ActiveRecord::Migration[7.0]
  def change
    create_table :generatedresults do |t|
      t.references :user, null: false, foreign_key: true

      t.string :generated_drink
      t.string :generated_word
      t.string :generated_info
      t.string :image_url
      t.boolean :is_original

      t.timestamps
    end
  end
end
