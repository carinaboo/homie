FactoryGirl.define do 
	factory :user do |f|
		f.email "email@email.com"
		f.username "user"
		f.encrypted_password "pass"
	end
end