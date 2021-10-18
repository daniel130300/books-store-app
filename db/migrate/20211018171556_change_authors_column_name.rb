class ChangeAuthorsColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :authors, :author_full_name, :full_name
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
