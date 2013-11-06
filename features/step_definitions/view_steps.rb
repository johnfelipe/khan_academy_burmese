Given(/^the following videos exist:$/) do |videos_table|
  videos_table.hashes.each do |video|
    Video.create(video)
  end
end

Given(/^I am logged in as User/) do

  visit '/login_page'
  fill_in 'inputSignInUsername', :with => 'User@gmail.com'
  fill_in 'loginSignInPassword', :with => 'mypassword'
  click_button 'Sign In'
end
