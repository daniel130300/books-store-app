class RenameQuantityToStockBooks < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :quantity, :stock
  end
end
