class CreateBook < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :image_link
      t.integer :average_rating
      t.string :publisher
      t.date :published_date
      t.string :preview_link
      t.integer :quantity
      t.decimal :purchase_price
      t.decimal :sale_price
    end
  end
end
