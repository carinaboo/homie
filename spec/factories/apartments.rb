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

FactoryGirl.define do 
	factory :apartment do |f|
		f.title "Title"
		f.street_address "2137 Parker St"
		f.apartment_number "10"
		f.city "Berkeley"
		f.state "California"
		f.zip "94704"
		f.description "home"
		f.price 450.50
		f.bedrooms 5
		f.bathrooms 2.5
		f.user_id 1
	end
end
