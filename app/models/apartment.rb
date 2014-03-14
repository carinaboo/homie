class Apartment < ActiveRecord::Base
	has_many :reviews
	belongs_to :user

	validates :title, :address, :description, :price, :bedrooms, :bathrooms, presence: true
	validates :address, uniqueness: true

  	FORBIDDEN = 403

	def self.add(user_id, title, address, desc, price, bedrooms, bathrooms)
		addr = self.find_by_address(address)
		if addr != nil || address = addr.address
			#ERROR
		elsif title == nil || address == nill || desc == nill || price == nill || bedrooms == nill || bathrooms == nill
			#ERROR
		else
			apt = self.new(title: title, address: address, description: desc, price: price, bedrooms: bedrooms, bathrooms:bathrooms)
			#SUCCESS
	end

	def self.updateDescription(user_id, title, address, desc, price, bederooms, bathrooms)
		addr = self.find_by_address(address)
		if addr == nil
			#ERROR
		elsif title == nil || address == nill || desc == nill || price == nill || bedrooms == nill || bathrooms == nill
			#ERROR
		else
			apt = self.new(title: title, address: address, description: desc, price: price, bedrooms: bedrooms, bathrooms:bathrooms)
			#SUCCESS
	end

	def self.search(search)
		if search
			find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		else
			find(:all)
		end
	end
end
