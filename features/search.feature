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

  Scenario: Apartment details are split
  	Given I am on the home page
  	When I follow "Add apartment"
  	Then I should see "Street address"
  	Then I should see "Apartment number"
  	Then I should see "City"
  	Then I should see "State"
  	Then I should see "Zip"

  Scenario: View an apartment
  	Given I am on the search results page
  	When I follow "Beautiful Studio"
  	Then I should see "Edit Apartment"

  Scenario: Delete apartment
  	Given I am on the search results page
  	When I follow "Beautiful Studio"
  	Then I should see "Delete Apartment"
  	When I follow "Delete Apartment"

  Scenario: Search apartment by title
  	Given I am on the home page
  	When I fill in "search_field" with "Studio"
  	Then I press "Search"
  	Then I should see "Beautiful Studio"

  Scenario: Filter by price
  	Given I am on the search results page
  	When I fill in "min_price" with "900"
  	When I press "Search"
  	Then I should not see "Beautiful Studio"
  	Then I should see "Best Studio"

  Scenario: Filter by bedrooms
  	Given I am on the search results page
  	When I fill in "min_bedrooms" with "1"
  	When I press "Search"
  	Then I should see "Beautiful Studio"
  	Then I should see "Best Studio"

  Scenario: Filter by bedrooms
  	Given I am on the search results page
  	When I fill in "max_bedrooms" with "2"
  	When I press "Search"
  	Then I should see "Beautiful Studio"
  	Then I should not see "Best Studio"


