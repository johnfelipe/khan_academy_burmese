Feature: Assign a video to me

  As a user
  So that I can translate/type/qa a video
  I want to assign an available video to me

Background: users and videos in database

  Given the following users exist:
  | name                     | email                  | password    | id |
  | Me                       | myemail@mydomain.com   | mypassword  | 1  |

  And the following videos exist:
  | video_id     | subject  | course   | title  | translator_id | typer_id | qa_id | translate_complete | type_complete | qa_complete |
  | To_Translate | SubjectA | CourseA  | TitleA |               |          |       | false              | false         | false       | 
  | To_Digitize  | SubjectB | CourseB  | TitleB | 2             |          |       | true               | false         | false       | 
  | To_Qa        | SubjectC | CourseC  | TitleC | 2             | 3        |       | true               | true          | false       | 

  And I am on the dashboard page for "Me"

Scenario: assign a video to translate
  When I press "To_Translate_translate_button"
  And I follow "Translate"
  Then I should see "TitleA"

Scenario: assign a video to digitize
  When I press "To_Digitize_digitize_button"
  And I follow "Digitize"
  Then I should see "TitleB"

Scenario: assign a video to qa
  When I press "To_Qa_qa_button"
  And I follow "QA"
  Then I should see "TitleC"