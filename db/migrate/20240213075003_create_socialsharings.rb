class CreateSocialsharings < ActiveRecord::Migration[7.0]
  def change
    create_table :socialsharings do |t|

      t.string :generated_drink
      t.string :generated_word
      t.text :generated_info
      t.string :image
      
      t.timestamps
    end
  end
end
