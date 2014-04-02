Feature: User
  
  Scenario: Sign up
    Given I am on the home page
    When I follow "Sign Up"
    Then I should see "Sign in"

  Scenario: Search
  	Given I am on the home page
    When I press "Search"
    Then I should see "Search results"

