class RenameAddressTableToAddresses < ActiveRecord::Migration[6.1]
  def change
    rename_table :address, :addresses
  end
end
