FactoryGirl.define do 
	factory :review do |f|
		f.review "This place is great"
		f.overall_rating 5
	end
end