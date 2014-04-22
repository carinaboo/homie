Feature: Delete Review
  
  Background: Create apartments
    Given logged in
  	Given apartment created

  Scenario: Try to favorite when user not logged in
    Given logged out
    Given I am on the first apartment page
    Then I should see image favorite

  Scenario: Try to favorite and unfavorite when user logged in
    Given I am on the first apartment page
    Then I should see image favorite
    When I follow favorite
    Then I should see image unfavorite
    When I follow favorite
    Then I should see image favorite