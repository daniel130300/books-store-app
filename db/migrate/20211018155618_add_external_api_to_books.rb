class AddExternalApiToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :external_id, :string
  end
end
