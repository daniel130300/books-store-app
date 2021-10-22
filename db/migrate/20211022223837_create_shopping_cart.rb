class CreateShoppingCart < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_carts do |t|
      t.belongs_to :book
      t.belongs_to :user
      t.decimal :price
      t.integer :quantity
      t.timestamps
    end
  end
end
