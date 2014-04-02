class RemoveAddressFromApartments < ActiveRecord::Migration
  def change
    remove_column :apartments, :address, :string
  end
end
