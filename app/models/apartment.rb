# == Schema Information
#
# Table name: apartments
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  description            :text
#  price                  :float
#  bathrooms              :float
#  bedrooms               :float
#  average_overall_rating :float
#  created_at             :datetime
#  updated_at             :datetime
#  user_id                :integer
#  street_address         :string(255)
#  apartment_number       :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip                    :integer
#  photo_file_name        :string(255)
#  photo_content_type     :string(255)
#  photo_file_size        :integer
#  photo_updated_at       :datetime
#

class Apartment < ActiveRecord::Base
	has_many :reviews
	belongs_to :user, class_name: 'User', foreign_key: 'user_id'
	has_attached_file :photo, styles: {thumb: "75x75>", small: "200x200>"}
	#validates_attachment :photo, content_type: { content_type: ["photo/jpg", "photo/jpeg", "photo/png"] }
	do_not_validate_attachment_file_type :photo
	make_flaggable

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

	def self.addApt(params)
		street_address = params[:street_address]
		apartment_number = params[:apartment_number]
		if self.where('street_address = ? AND apartment_number = ?', street_address, apartment_number).empty?
			apartment = new(params)
			apartment.save
			return apartment
		end
	end 

	#update the description for this apartment record and then returns FORBIDDEN if
	#the updates are not valid; otherwise returns 1 for success
	def update(user_id, title, street_address, apartment_number, city, state, zip, description, price, bedrooms, bathrooms)
		valid = self.update_attributes(user_id: user_id, title: title, street_address: street_address, apartment_number: apartment_number, city: city, state: state, zip: zip, description: description, price: price, bedrooms: bedrooms, bathrooms:bathrooms)
		return self if valid
		FORBIDDEN
	end

	def updateApt(params)
		valid = self.update_attributes(params)
		return self if valid
		FORBIDDEN
	end

  searchable do
    text :title, :street_address, :apartment_number, :city, :state, :zip

    float :price
    float :bathrooms
    float :bedrooms
    float :average_overall_rating
  end

	def delete()
		self.destroy
	end

	#pass in a price, return it in float format
	def self.parsePrice(p)
		p = p.to_s
		p = p.gsub(/[$,_]/,'').to_f
		return p
	end
end
