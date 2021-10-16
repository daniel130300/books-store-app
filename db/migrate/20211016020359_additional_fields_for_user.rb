class AdditionalFieldsForUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :fullname, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :birth_date, :date
  end
end
