class AddStreetAddressAndApartmentNumberAndCityAndStateAndZipToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :street_address, :string
    add_column :apartments, :apartment_number, :string
    add_column :apartments, :city, :string
    add_column :apartments, :state, :string
    add_column :apartments, :zip, :integer
  end
end
