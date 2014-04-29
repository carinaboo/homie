Feature: Search
  
  Background: Sign in user and create apartments
  	Given logged in
  	Given apartment created
  	Given apartment created by different user

  Scenario: Sign up when already signed in
    Given I am on the home page
    Then I should not see "Sign Up"

  Scenario: Browse all apartment
  	Given I am on the home page
    When I press "Search"
    Then I should see "Search results"
    Then I should see "Beautiful Studio"
    Then I should see "Best Studio"

  Scenario: Can add picture
    Given I am on the home page
    When I follow "Add apartment"
    Then I should see "Upload image"
    And I should see "Title"
    And I should see "Street address"
    And I should see "Apartment number"
    And I should see "City"
    And I should see "State"
    And I should see "Zip"
    And I should see "Description"
    And I should see "Price"
    And I should see "Bedrooms"
    And I should see "Bathrooms"

  Scenario: View an apartment
  	Given I am on the search results page
  	When I follow "Beautiful Studio"
  	Then I should see "Create Review"

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


