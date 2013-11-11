Feature: Modify user account

  As a user
  So that I can update my account
  I want to make modifications to my account information

Background: users in database

  Given the following users exist:
  | name                     | email                  | password   |
  | Me                       | myemail@mydomain.com   | mypassword |

  When I am on the user page for "Me"
  And I am logged in as "Me"

Scenario: View the current user's account
  Then I should see "Me"
  And  I should see "myemail@mydomain.com"

Scenario: Change name associated with account
  And  I press "Edit account information"
  Then I should be on the edit user page for "Me"
  And  I should see "Me"
  When I fill in "Name" with "My new name"
  And  I press "Update Account Info"
  Then I should be on the user page for "My new name"
  And  I should see "My new name"
  And  I should see "myemail@mydomain.com"

Scenario: Change the email associated with account
  And  I press "Edit account information"
  Then I should be on the edit user page for "Me"
  And  I should see "Me"
  When I fill in "Email" with "newemail@newdomain.com"
  And  I press "Update Account Info"
  Then I should be on the user page for "Me"
  And  I should see "Me"
  And  I should see "newemail@newdomain.com"

Scenario: Delete a user account
  And  I press "Delete account"
  Then I should be on the login page
  And  I should see "Your account was successfully deleted"
  And  the user "Me" should not exist


#Scenario: Attempt to view another user's account (?)
