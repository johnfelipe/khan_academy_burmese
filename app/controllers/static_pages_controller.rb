class StaticPagesController < ApplicationController
	def index
	end
  def login
  	@user = User.new
  end
end
