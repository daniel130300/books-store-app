class ChangeTaxColumnInSales < ActiveRecord::Migration[6.1]
  def change
    change_column :sales, :sale_tax, :decimal, :precision => 3, :scale => 2
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
