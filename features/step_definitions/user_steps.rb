# Add a declarative step here for populating the DB with movies.
require 'uri'

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(user)
  end
end

Then /the user "(.*)" should not exist/ do |username|
  User.where(:name => username).should be_blank
end

Then /the user "(.*)" should exist/ do |username|
  User.where(:name => username).should_not be_blank
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
#  flunk "Unimplemented"
end

Then /the "(.*)" for "(.*)" should be "(.*)"/ do |field, username, value|
  User.where(:name => username)[field].should == value
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  body = page.body
  pos1 = body.index(e1)
  pos2 = body.index(e2)

  pos1.should < pos2
#  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(",")
  ratings.each do |rating|
    if uncheck
      uncheck("ratings_"+rating.strip)
    else
      check("ratings_"+rating.strip)
    end
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  m = Movie.find_by_title title
  m.director.should == director
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.count.should == page.all('#movies tbody tr').count
end
