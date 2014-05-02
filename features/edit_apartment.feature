Feature: Edit apartment
  
  Background: Sign in user and create apartments
  	Given logged in
  	Given apartment created
  	Given apartment created by different user

  Scenario: Negative price
  	Given I am on the home page
  	When I follow "Add apartment"
    When I fill in "apartment_price" with "-900"
    Then I press "Create Apartment"
    Then I should see "Price must be greater than 0"

  Scenario: Missing fields
    Given I am on the home page
    When I follow "Add apartment"
    Then I should not see "Title can't be blank"
    Then I press "Create Apartment"
    Then I should see "Title can't be blank"

   Scenario: All fields valid
    Given I am on the home page
    When I follow "Add apartment"
    When I attach a "small" image to "apartment_photo"    
    When I fill in "apartment_title" with "Northside two bedroom"
    When I fill in "apartment_street_address" with "1644 Oxford St"
    When I fill in "apartment_apartment_number" with "1"
    When I fill in "apartment_city" with "Berkeley"
    When I fill in "apartment_state" with "CA"
    When I fill in "apartment_zip" with "94709"
    When I fill in "apartment_description" with "This is one nice place"
    When I fill in "apartment_price" with "2000"
    When I select "2" from "apartment_bedrooms"
    When I select "1" from "apartment_bathrooms"
    Then I press "Create Apartment"
    Then I should see "Northside two bedroom"
    And I should see "Share Photo"
