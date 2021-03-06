Feature: User

Background: Sign in User
	Given I am on the home page
  	When I follow "Sign Up"
  	When I attach a "small" image to "user_photo" 
  	When I fill in "user_username" with "Carina Boo"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_password" with "1234567890"
  	When I fill in "user_password_confirmation" with "1234567890"
  	When I press "Sign up"
  	Then I should see "Welcome"
  	And I should see "Profile"

Scenario: Add user
	Given I am on the home page
	When I follow "Sign out"
	When I follow "Sign Up"
	Then I should see "Upload picture"
	
Scenario: Access user profile
	Given I am on the home page
	When I follow "Profile"
	Then I should see "Carina Boo"
	And I should see "Edit profile"

Scenario: Add photo to user profile
	Given I am on the home page
	When I follow "Edit profile"
	Then I should see "Upload picture"

Scenario: Edit user profile
	Given I am on the home page
	When I follow "Edit profile"
	When I attach a "small" image to "user_photo" 
	When I fill in "user_username" with "Boo, Carina"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_current_password" with "1234567890"
	When I press "Update"
	Then I should see "Welcome"

Scenario: Edit user password and password
	Given I am on the home page
	When I follow "Edit profile"
	When I fill in "user_username" with "Boo, Carina"
  	When I fill in "user_email" with "cboo1@berkeley.edu"
  	When I fill in "user_password" with "123456789"
  	When I fill in "user_password_confirmation" with "123456789"
  	When I fill in "user_current_password" with "1234567890"
  	When I press "Update"
  	When I follow "Sign out"
  	When I follow "Log In"
  	When I fill in "user_email" with "cboo1@berkeley.edu"
  	When I fill in "user_password" with "123456789"
  	When I press "Sign in"
  	Then I should see "Boo, Carina"

Scenario: Edit user password unsuccessfully
	Given I am on the home page
	When I follow "Edit profile"
	When I fill in "user_username" with "Boo, Carina"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_password" with "123456789"
  	When I fill in "user_password_confirmation" with "1234567890"
  	When I fill in "user_current_password" with "1234567890"
  	When I press "Update"
  	Then I should see "error"

Scenario: Invalid edits to user profile
	Given I am on the home page
	When I follow "Edit profile"
	When I fill in "user_username" with "Carina Boo"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_current_password" with "123456789"
	When I press "Update"
	Then I should see "error"



