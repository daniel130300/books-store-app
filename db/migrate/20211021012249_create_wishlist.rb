class CreateWishlist < ActiveRecord::Migration[6.1]
  def change
    create_table :wishlists do |t|
      t.belongs_to :user
      t.belongs_to :book
      t.timestamps
    end
  end
end
