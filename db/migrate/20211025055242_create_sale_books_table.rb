class CreateSaleBooksTable < ActiveRecord::Migration[6.1]
  def change
    create_table :sale_books do |t|
      t.belongs_to :sale
      t.belongs_to :book
      t.integer :quantity
      t.decimal :price, precision: 7, scale: 2
      t.boolean :view_flag, default: false
    end
  end
end
