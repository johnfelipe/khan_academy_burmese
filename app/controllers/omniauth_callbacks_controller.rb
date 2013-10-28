class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #def google_oauth2
  	#user = User.from_omniauth(request.env["omniauth.auth"])
    #if user.persisted?
      #flash.notice = "Signed in Through Google!"
      #sign_in_and_redirect user
    #else
      #session["devise.user_attributes"] = user.attributes
      #flash.notice = "You are almost Done! Please provide a password to finish setting up your account"
      #redirect_to new_user_registration_url
    #end
  #end

  def google_oauth2
	    # You need to implement the method below in your model (e.g. app/models/user.rb)
	    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

	    if @user.persisted?
	      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
	      sign_in_and_redirect @user, :event => :authentication
	    else
	      session["devise.google_data"] = request.env["omniauth.auth"]
	      redirect_to new_user_registration_url
	    end
	end

end
