Feature: Admin can view list of all users

  As an admin user
  So that I see all user accounts
  I want to have a view that lists all registered users

Background: users in database

  Given the following users exist:
  | name                     | email                  | password      |
  | user1                    | user1@example.com      | mypassword    |
  | user2                    | user2@example.com      | mypassword    |
  | user3                    | user3@example.com      | mypassword    |
  | admin                    | admin@example.com      | adminpassword |

  And "admin@example.com" is an admin user
  When I am logged in with email: "admin@example.com" and password: "adminpassword"
  And I am on the dashboard page for "admin"
  And I follow "All users"

Scenario: View list of all users
  Then I should see "All users"
  And I should see "admin , admin@example.com"
  And I should see "user1 , user1@example.com"
  And I should see "user2 , user2@example.com"
  And I should see "user3 , user3@example.com"

Scenario: Delete user account as admin
  Then I should see "user1 , user1@example.com | delete"
  When I follow "1_delete"
  Then I should see "The account was successfully deleted"
  When I am logged in with email: "admin@example.com" and password: "adminpassword"
  And I am on the dashboard page for "admin"
  And I follow "All users"
  Then I should not see "user1"
  And I should see "user2"