Feature: User
  
  Background: Sign in user and Create Apartment
  	Given logged in
  	Given apartment created
  	Given apartment created by different user

  Scenario: Sign up when already signed in
    Given I am on the home page
    Then I should not see "Sign Up"

  Scenario: Search
  	Given I am on the home page
    When I press "Search"
    Then I should see "Search results"

