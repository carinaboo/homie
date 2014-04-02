Feature: Review

Background:Sign in and create apartments
	Given logged in
	Given apartment created	

Scenario: Apartment allows adding reviews
	Given I am on the apartment page
	Then I should see "Create Review"
	
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