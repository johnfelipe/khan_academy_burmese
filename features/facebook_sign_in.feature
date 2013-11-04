Feature: Sign in to an account using facebook

  As a user
  So that I can easily access my account 
  I want to sign in using my existing facebook


# happy path
Scenario: log in to an account using google
  Given I am on the login page
  Then I should see "Sign In"
  When  I press "Sign in with facebook"
  Then  I fill in "email" with "kabtdashboardtest5364@gmail.com"
  And  I fill in "password" with "kabtdashboardpass"
  Then I should be on the dashboard page for "kabtdashboardtest5364"
  And I should see "Hi kabtdashboardtest5364"

# sad path
Scenario: try to log in using facebook using an incorrect password
  Given I am on the login page
  When  I press "Sign in with facebook"
  Then  I fill in "email" with "kabtdashboardtest5364@gmail.com"
  And  I fill in "password" with "wrong_password"
  Then I should not be on the dashboard page for "kabtdashboardtest5364"
  And I should see "wrong password"