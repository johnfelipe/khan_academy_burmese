require 'spec_helper'

describe "When" do

	before { visit '/' }	
	
	describe "Signing in with facebook" do
		before { OmniAuth.config.mock_auth[:facebook] = :invalid_credentials }
		it "should fail" do
			click_link 'Sign in with Facebook'
			page.should have_content 'Login credentials are incorrect.'
		end
	end

	describe "Signing in with google" do
		before { OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials }
		it "should fail" do
			click_link 'Sign in with google'
			page.should have_content 'Login credentials are incorrect.'
		end
	end
end