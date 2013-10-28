Feature: Create an account

  As a user
  So that I can translate videos
  I want to open an account


Scenario: Open a new account
  Given I am on the login page
  Then I should see "Sign Up"
  And  I should see "Sign In"
  When I fill in "First Name" with "Test"
  When I fill in "Last Name" with "User"
  And  I fill in "Email" with "testemail@test.com"
  And  I fill in "createPassword" with "testpassword"
  And  I press "Sign Up"
  Then I should be on the login page
  And I should see "Your account was successfully created"
  Then I should see "Sign In"
  When  I fill in "Email" with "testemail@test.com"
  And  I fill in "loginPassword" with "12345678"
  And  I press "Sign In"
  Then I should be on the login page
  And I should see "Sign Up"
