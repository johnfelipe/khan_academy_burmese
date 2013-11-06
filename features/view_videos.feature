Feature: View Videos

As a user
So that I can see my assigned/completed tasks
I want to have views for Translate/Digitize/QA/Completed Videos


Background: Videos in database 

Given the following users exist:
| name   | email                | password   |
| User   | user@gmail.com       | mypassword |

Given the following videos exist:

|video_id|title          |translator_id|typer_id|qa_id|translate_complete|type_complete|qa_complete|
|1234    |This Is A Video|nil          |nil     |nil  |nil               |nil          |nil        |
|5679    |Best Vid Ever  |nil          |nil     |nil  |nil               |nil          |nil        |
|7849    |A Great Video  |21           |nil     |nil  |nil               |nil          |nil        |
|2647    |Volleyball Vid |21           |nil     |nil  |nil               |nil          |nil        |
|9018    |Math Video     |nil          |21      |nil  |nil               |nil          |nil        |
|9564    |Documentary    |nil          |21      |nil  |nil               |nil          |nil        |
|7758    |Science Video  |nil          |nil     |21   |nil               |nil          |nil        |
|0182    |Info Video     |nil          |nil     |21   |nil               |nil          |nil        |
|5869    |Hello World    |21           |nil     |nil  |true              |nil          |nil        |
|3343    |Learn English  |21           |nil     |nil  |true              |nil          |nil        |
|0495    |Learn Math     |nil          |21      |nil  |nil               |true         |nil        |
|1111    |Chemistry Vid  |nil          |21      |nil  |nil               |true         |nil        |
|4095    |Learn Fractions|nil          |nil     |21   |nil               |nil          |true       |
|2641    |Good Movie     |nil          |nil     |21   |nil               |nil          |true       |

And I am logged in as User


Scenario: View Available Videos
When I am on the Available Videos View for "User"
Then I should see "This Is A Video"
And I should see "Best Vid Ever"


Scenario: View Videos To Translate
When I am on the Available Videos View for "User"
And I follow "the_translate_button"
Then I should be on the Translation Videos View for "User"
And I should see "Hi, User"
And I should see "A Great Video"
And I should see "Volleyball Vid"

Scenario: View Videos To Digitize
When I am on the Translation Videos View for "User"
And I follow "the_digitize_button"
Then I should be on the Digitize Videos View for "User"  
And I should see "Math Video"
And I should see "Documentary" 

Scenario: View Videos To QA
When I am on the Available Videos View for "User"
And I follow "the_qa_button"
Then I should be on the QA Videos View for "User"
And I should see "Science Video"
And I should see "Info Video" 

Scenario: View Completed Videos
When I am on the Available Videos View for "User"
And I follow "the_completed_button"
Then I should be on the Completed Videos View for "User"  
And I should see "Hello World"
And I should see "Learn English" 
And I should see "Learn Math"
And I should see "Chemistry Vid"
And I should see "Learn Fractions" 
And I should see "Good Movie"


