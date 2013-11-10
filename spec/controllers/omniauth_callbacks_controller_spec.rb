require 'spec_helper'

describe "OmniAuth Callbacks Controller" do

	before(:each) { visit '/' }	

	describe "Home page should have link to sign in with facebook" do
		it "should have the link to sign in with facebook" do
			page.should have_content('Sign in with Facebook')
		end
	end

	describe "Signing in with facebook" do
		before do 
			request.env["devise.mapping"] = Devise.mappings[:user] 
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
		end
		it "should be successfull" do
			click_link 'Sign in with Facebook'
			page.should have_content 'Successfully authenticated from Facebook account'
			page.should have_content 'Hi, kabttest account'
		end
	end

	describe "Signing in with google" do
		before do 
			request.env["devise.mapping"] = Devise.mappings[:user] 
			request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
		end
		it "should be successfull" do
			click_link 'Sign in with google'
			page.should have_content 'Successfully authenticated from Google account'
			page.should have_content 'Hi, kabttest account'
		end
	end

end
