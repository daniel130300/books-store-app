class Create < ActiveRecord::Migration[6.1]
  def change
    create_table :address do |t|
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state_or_province
      t.string :postal_code
      t.string :telephone
    end
  end
end
