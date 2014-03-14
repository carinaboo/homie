class AddApartmentIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :apartment_id, :integer
  end
end
