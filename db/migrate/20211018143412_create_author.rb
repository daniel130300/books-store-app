class CreateAuthor < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :author_full_name
    end
  end
end
