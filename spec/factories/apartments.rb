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