class ScreateSaleBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, references: :users, foreign_key: {to_table: :users}
      t.decimal :sale_tax, precision: 2
      t.timestamps
    end
  end
end
