FactoryGirl.define do 
	factory :user do 
		email "email@email.com"
		username "user"
		encrypted_password "pass"
	end
end