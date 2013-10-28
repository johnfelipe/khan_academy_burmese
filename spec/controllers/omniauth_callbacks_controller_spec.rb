require 'spec_helper'

describe OmniauthCallbacksController do

  describe "GET 'google_oauth2'" do
    it "returns http success" do
      get 'google_oauth2'
      response.should be_success
    end
  end

end
