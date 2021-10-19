class AddRelatioToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :user, foreign_key: true
    #Ex:- add_index("admin_users", "username")
  end
end
