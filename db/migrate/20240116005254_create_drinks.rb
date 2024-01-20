class CreateDrinks < ActiveRecord::Migration[7.0]
  def change
    create_table :drinks do |t|
      t.string :name, null: false
      t.string :category
      t.integer :display_order

      t.timestamps
    end
  end
end
