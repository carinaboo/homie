Feature: User
  
  Background: Sign in user
  	Given I am on the home page
  	When I follow "Sign Up"
  	When I fill in "user_username" with "Carina Boo"
  	When I fill in "user_email" with "cboo@berkeley.edu"
  	When I fill in "user_password" with "1234567890"
  	When I fill in "user_password_confirmation" with "1234567890"
  	When I press "Sign up"
  	Then I should see "Welcome"

  Scenario: Sign up when already signed in
    Given I am on the home page
    Then I should not see "Sign Up"

  Scenario: Search
  	Given I am on the home page
    When I press "Search"
    Then I should see "Search results"

