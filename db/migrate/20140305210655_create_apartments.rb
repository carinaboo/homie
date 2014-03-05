class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :title
      t.string :address
      t.text :description
      t.float :price
      t.float :bathrooms
      t.float :bedrooms
      t.float :average_overall_rating
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
