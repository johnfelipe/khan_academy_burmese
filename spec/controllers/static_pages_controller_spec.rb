require 'spec_helper'

describe "Static Pages" do

 
   describe "Home page" do

    it "should have the content 'Khan Academy'" do
      visit '/static_pages'
      page.should have_content('Khan Academy')
      page.should have_title('KABT')
      page.should_not have_title('Title')
      page.should_not have_content('Welcome to Rails')
    end
  end

end
