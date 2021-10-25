class ChangeSalesColumns < ActiveRecord::Migration[6.1]
  def change
    change_column :sales, :sale_tax, :decimal, :precision => 3
    add_column :sales, :address, :string
  end
end
