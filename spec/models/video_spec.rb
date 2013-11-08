require 'spec_helper'

describe Video do

	before { @video = Video.new(:video_id => "123", :subject => "Math", :course => "Algebra 1",
	 :title => "Dividing both sides by x", :translator_id => 1, :typer_id => 2,
	 :qa_id => nil, :translate_complete => true, :type_complete => true,
	 :qa_complete => false) }

	subject { @video }

	it { should respond_to(:video_id) }
	it { should respond_to(:subject) }
	it { should respond_to(:course) }
	it { should respond_to(:title) }
	it { should respond_to(:translator_id) }
	it { should respond_to(:typer_id) }
	it { should respond_to(:qa_id) }
	it { should respond_to(:translate_complete) }
	it { should respond_to(:type_complete) }
	it { should respond_to(:qa_complete) }


	it { should be_valid }

  describe "when video_id is not present" do
  	before { @video.video_id = " " }
  	it { should_not be_valid }
  end
  
  describe Video do
		subject { create(:video) }
		its(:video_id) { should == 'Video1' }
    its(:subject) { should == 'Math' }
    its(:course) { should == 'Algebra' }
    its(:title) { should == 'I Love Algebra' }
    its(:translator_id) { should == 1 }
    its(:typer_id) { should == 1 }
    its(:qa_id) { should == nil }
    it { should == be_translate_complete }
    it { should be_type_complete }
    it { should_not be_qa_complete }
	end
  
end
