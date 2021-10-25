class DropSaleBooks < ActiveRecord::Migration[6.1]
  def change
    drop_table :sale_books
  end
end
