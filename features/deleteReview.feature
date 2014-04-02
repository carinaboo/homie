Feature: Delete Review
  
  Background: Sign in user and create apartments
    Given logged in
  	Given apartment created
  	Given apartment created by different user

  Scenario: Delete a review that the user create
    Given I am on the first apartment page
    Then I should see "Overall rating"
    When I press "Submit"
    Then I should see "Carina Boo"
    When I follow "Delete"

  Scenario: cannot Delete a review that is not created by the current user
    Given logged out
    Given I am on the first apartment page
    Then I should see "Overall rating"
    Then I should see "Carina Boo"
    Then I should not see "Delete" 



