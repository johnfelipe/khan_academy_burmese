class ApplicationController < ActionController::Base
  protect_from_forgery
  def require_user
    if session[:id].nil?
      flash[:notice] = "You have to be logged in to view that page"
      redirect_to login_page_path
      return
    end

    current_user = User.find(session[:id])
    if params[:id] != "#{session[:id]}" #and not current_user.admin?
      render :status => :forbidden, :text => "You do not have permission to access that page"
      return
    end
  end

end
