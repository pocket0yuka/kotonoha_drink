class AddAvatarAndFavoriteDrinkToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avatar, :string
    add_column :users, :favorite_drink, :string
  end
end
