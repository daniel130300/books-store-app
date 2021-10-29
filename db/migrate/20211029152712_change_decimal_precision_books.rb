class ChangeDecimalPrecisionBooks < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :purchase_price, :decimal, precision: 7, scale: 2
    change_column :books, :sale_price, :decimal, precision: 7, scale: 2
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
