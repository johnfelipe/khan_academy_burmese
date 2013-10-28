Feature: Create an account

  As a user
  So that I can translate videos
  I want to open an account

Background: users in database

  Given the following users exist:
  | name                     | email                  |
  | Me                       | myemail@mydomain.com   |

Scenario: Open a new account
  Given I am on the login page
  Then I should see "Sign Up"
  And  I should see "Sign In"
  When I fill in "First Name" with "Test"
  When I fill in "Last Name" with "User"
  And  I fill in "Email" with "testemail@test.com"
  And  I fill in "Password" with "testpassword"
  And  I check "I agree to all your Terms of Service"
  And  I press "Sign Up"
  Then I should be on the login page
  And I should see "Your account was successfully created"