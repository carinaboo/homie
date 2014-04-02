Feature: Search
  
  Background: Sign in user and create apartments
  	Given logged in
  	Given apartment created
  	Given apartment created by different user

  Scenario: Sign up when already signed in
    Given I am on the home page
    Then I should not see "Sign Up"

  Scenario: Browse all apartments
  	Given I am on the home page
    When I press "Search"
    Then I should see "Search results"
    Then I should see "Beautiful Studio"
    Then I should see "Best Studio"

  Scenario: View an apartment
  	Given I am on the search results page
  	When I follow "Beautiful Studio"
  	Then I should see "Edit Apartment"