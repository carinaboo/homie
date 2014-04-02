Feature: remove time and apt id
  
  Background: Sign in user and create apartments
    Given logged in
  	Given apartment created

  Scenario: Delete a review that the user create
    Given I am on the first apartment page
    Then I should see "Overall rating"
    Then I should not see "Created At"
    Then I should not see "Updated At"
    Then I should not see "Id"
