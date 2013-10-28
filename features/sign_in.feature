Feature: Sign in to an account

  As a user
  So that I can view my account details
  I want to sign in to my account

Background: users in database

  Given the following users exist:
  | name                     | email@mydomain.com     | password   |
  | Me                       | myemail@mydomain.com   | mypassword |

Scenario: log in to an account
  When I am on the login page
  Then I should see "Sign In"
  When  I fill in "Email" with "email@mydomain.com"
  And  I fill in "loginPassword" with "password"
  And  I press "Sign In"
  Then I should be on my dashboard page
  And I should see "To Translate"