# == Schema Information
#
# Table name: apartments
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  address                :string(255)
#  description            :text
#  price                  :float
#  bathrooms              :float
#  bedrooms               :float
#  average_overall_rating :float
#  created_at             :datetime
#  updated_at             :datetime
#  user_id                :integer
#

class Apartment < ActiveRecord::Base
	has_many :reviews
	belongs_to :user, class_name: 'User', foreign_key: 'user_id'

	validates :user_id, :street_address, :title, :city, :state, :zip, :description, :bedrooms, :bathrooms, presence: true
	#validates :street_address, presence: true, uniqueness: { case_sensitive: false }
	validates :price, presence: true, numericality: { greater_than: 0}

	SUCCESS = 1
  	FORBIDDEN = 403

  	#adds a new apartment to the database and returns errorCode if not valid.
	def self.add(user_id, title, street_address, apartment_number, city, state, zip, description, price, bedrooms, bathrooms)
		if self.where('street_address = ? AND apartment_number = ?', street_address, apartment_number).empty?
			apartment = new(user_id: user_id, title: title, street_address: street_address, apartment_number: apartment_number, city: city, state: state, zip: zip, description: description, price: price, bedrooms: bedrooms, bathrooms:bathrooms)
			apartment.save
			return apartment
		end
		#apartment.errors.messages
		#FORBIDDEN
	end

	#update the description for this apartment record and then returns FORBIDDEN if
	#the updates are not valid; otherwise returns 1 for success
	def update(user_id, title, street_address, apartment_number, city, state, zip, description, price, bedrooms, bathrooms)
		valid = self.update_attributes(user_id: user_id, title: title, street_address: street_address, apartment_number: apartment_number, city: city, state: state, zip: zip, description: description, price: price, bedrooms: bedrooms, bathrooms:bathrooms)
		return self if valid
		FORBIDDEN
	end

	#search for apartments by address and returns an array of apartments at that location. 
	def self.search(search, sort, min_price, max_price, min_rating, min_bedrooms, max_bedrooms, min_bathrooms, max_bathrooms)
		if search
			# for now blank search returns all results to make it easier for dev testing
			# change to show nothing later
			
			if sort == "Ratings: low to high"
				sorting = 'average_overall_rating asc'
			elsif sort == "Ratings: high to low"
				sorting = 'average_overall_rating desc'
			elsif sort == "Price: low to high"
				sorting = 'price asc'
			elsif sort == "Price: high to low"
				sorting = 'price desc'
			else # default sort from highest to lowest rating
				sorting = 'average_overall_rating desc'
			end

			# find(:all, :conditions => ['address LIKE ?', "%#{search}%"], :order =>  sorting)
			Apartment.where('(title LIKE ? OR street_address LIKE ? OR apartment_number LIKE ? OR city LIKE ? OR state LIKE ? OR zip LIKE ?) AND (price >= ? AND price <= ? AND (average_overall_rating >= ? OR average_overall_rating IS ?) AND bedrooms >= ? AND bedrooms <= ? AND bathrooms >= ? AND bathrooms <= ?)',
				"%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", min_price.presence || 0, max_price.presence || Apartment.maximum("price"),
				min_rating.presence || 0, min_rating.presence || nil,
				min_bedrooms.presence || 0, max_bedrooms.presence || Apartment.maximum("bedrooms"), 
				min_bathrooms.presence || 0, max_bathrooms.presence || Apartment.maximum("bathrooms")).order(sorting)
		else
			return []
			# find(:all)
		end
	end

	def self.delete(street_address, apartment_number)
		self.where('street_address = ? AND apartment_number = ?', street_address, apartment_number).first.destroy
	end
end
