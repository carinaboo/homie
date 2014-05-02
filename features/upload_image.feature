Feature: Upload image

	Background: Sign in user and create apartments
  		Given logged in
  		Given apartment created

  	Scenario: Signed out user cannot add photo
  		Given I am on the apartment page
  		When I follow "Sign out"
  		When I am on the apartment page
  		Then I should not see "Share Photo"

	Scenario: A User uploads a photo
		Given I am on the apartment page
		Then I should see "Share Photo"
		When I attach a "small" image to "picture_image" 		
		And I press "Upload" 
		Then I should see "Share Photo"

	Scenario: A User uploads multiple photos to the apartment page
		Given I am on the apartment page
		Then I should see "Share Photo"
		When I attach a "small" image to "picture_image" 		
		And I press "Upload" 
		Then I should see "Share Photo"
		Given I am on the apartment page
		Then I should see "Share Photo"
		When I attach a "small" image to "picture_image" 		
		And I press "Upload" 
		Then I should see "Share Photo"