class ChangeBookAuthors < ActiveRecord::Migration[6.1]
  def change
    rename_column :book_authors, :books_id, :book_id
    rename_column :book_authors, :authors_id, :author_id
  end
end
