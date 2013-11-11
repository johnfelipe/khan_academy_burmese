require 'spec_helper'

describe VideosController do
	before :each do
		@user = FactoryGirl.create(:user)
		@video = FactoryGirl.create(:video)
	end

	describe "assigning a translator to a video" do
		it "should change the translator_id of the video" do
			post :assign_translator, :id => @user.id, :video_id => @video.video_id
			@video.reload
			@video.translator_id.should == 1
		end
	end

end