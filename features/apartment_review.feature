Feature: Review

Background:Sign in and create apartments
	Given logged in
	Given apartment created	

Scenario: Apartment allows adding reviews
	Given I am on the apartment page
	Then I should see "Create Review"
	
Scenario: Edit apartment
    Given I am on the home page
    When I follow "Add apartment"
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
    When I follow "Edit Apartment"
    Then I should see "Price"
    When I fill in "apartment_price" with "3000"
    When I press "Save"
    Then I should see "$3000"

Scenario: Delete apartment
	Given I am on the home page
    When I follow "Add apartment"
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
    And I should see "Delete Apartment"
    When I follow "Delete Apartment"
    Then I should see "Welcome"

Scenario: Add first (empty) review should succeed
	Given I am on the apartment page
	When I fill in "review_review" with ""
	When I press "Submit"
	Then I should see "Carina Boo"

Scenario: Add first (nonempty) review should also succeed
	Given I am on the apartment page
	When I fill in "review_review" with "It's great!"
	When I press "Submit"
	Then I should see "It's great!"

Scenario: Verify that review contains image
	Given I am on the apartment page
	When I fill in "review_review" with "It's ok!"
	When I press "Submit"
	Then I should see "It's ok!"
	And I should see "Picture"

Scenario: Add second review should fail
	Given I am on the apartment page
	When I press "Submit"
	Then I should not see "Create Review"
	And I should not see "Submit"
	And I should see "Edit"

Scenario: Delete you own review should succeed
	Given I am on the apartment page
	When I fill in "review_review" with "new review"
	When I press "Submit"
	When I follow "Delete"
	Then I should see "Create Review"

Scenario: Edit your own review should succeed
	Given I am on the apartment page
	When I fill in "review_review" with "new review"
	When I press "Submit"
	When I follow "Edit"
	When I fill in "review_review" with "It's great!"
	When I press "Save"
	Then I should see "It's great!"