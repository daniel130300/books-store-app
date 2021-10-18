class CreateBookAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :book_authors do |t|
      t.references :books, null: false, foreign_key: true
      t.references :authors, null: false, foreign_key: true
    end
  end
end
