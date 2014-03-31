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

FactoryGirl.define do 
	factory :apartment do |f|
		f.title "Title"
		f.address "2137 Parker St."
		f.description "home"
		f.price 450.50
		f.bedrooms 5
		f.bathrooms 2.5
		f.user_id 1
	end
end
