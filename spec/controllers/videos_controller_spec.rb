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

		describe "assigning a typer to a video" do
		it "should change the typer_id of the video" do
			post :assign_typer, :id => @user.id, :video_id => @video.video_id
			@video.reload
			@video.typer_id.should == 1
		end
	end

		describe "assigning a qa to a video" do
		it "should change the qa_id of the video" do
			post :assign_qa, :id => @user.id, :video_id => @video.video_id
			@video = Video.find_by_video_id @video.video_id
			@video.qa_id.should == 1
		end
	end

end