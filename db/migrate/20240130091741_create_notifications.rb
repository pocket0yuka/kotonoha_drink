class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
  end
end
