Feature: User

Background: Sign in User
	Given I am on the home page
  	When I follow "Sign Up"
  	When I fill in "user_username" with "Carina Boo"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_password" with "1234567890"
  	When I fill in "user_password_confirmation" with "1234567890"
  	When I press "Sign up"
  	Then I should see "Welcome"
  	And I should see "Profile"

Scenario: Access user profile
	Given I am on the home page
	When I follow "Profile"
	Then I should see "Carina Boo"
	And I should see "Edit profile"

Scenario: Edit user profile
	Given I am on the home page
	When I follow "Edit profile"
	When I fill in "user_username" with "Carina Boo"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_current_password" with "1234567890"
	When I press "Update"
	Then I should see "You updated your account successfully"

Scenario: Invalid edits to user profile
	Given I am on the home page
	When I follow "Edit profile"
	When I fill in "user_username" with "Carina Boo"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_current_password" with "123456789"
	When I press "Update"
	Then I should see "error"