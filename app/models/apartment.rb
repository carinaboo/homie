class Apartment < ActiveRecord::Base
	has_many :reviews
	belongs_to :user, class_name: 'User', foreign_key: 'user_id'

	validates :user_id, :title, :address, :description, :price, :bedrooms, :bathrooms, presence: true
	validates :address, uniqueness: true

	SUCCESS = 1
  	FORBIDDEN = 403

  	#adds a new apartment to the database and returns errorCode if not valid.
	def self.add(user_id, title, address, desc, price, bedrooms, bathrooms)
		apt = new(user_id: user_id, title: title, address: address, description: desc, price: price, bedrooms: bedrooms, bathrooms:bathrooms)
		return apt if apt.save
		FORBIDDEN
	end

	#update the description for this apartment record and then returns FORBIDDEN if
	#the updates are not valid; otherwise returns 1 for success
	def updateDescription(user_id, title, address, desc, price, bedrooms, bathrooms)
		valid = self.update_attributes(user_id: user_id, title: title, address: address, description: desc, price: price, bedrooms: bedrooms, bathrooms:bathrooms)
		return SUCCESS if valid
		FORBIDDEN
	end

	#search for apartments by address and returns an array of apartments at that location. 
	def self.search(search)
		if search
			# for now blank search returns all results to make it easier for dev testing
			# change to show nothing later
			find(:all, :conditions => ['address LIKE ?', "%#{search}%"])
			# Apartment.where("address LIKE ?", search)
		else
			return []
			# find(:all)
		end
	end
end