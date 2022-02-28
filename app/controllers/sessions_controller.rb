class  SessionsController < ApplicationController
  def googleAuth
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = Profile.from_omniauth(access_token)
    session[:user_id] = user.uni
    # Access_token is used to authenticate request made from the rails application to the google server
    user.google_token = access_token.credentials.token
    # Refresh_token to request new access_token
    # Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    #if !Profile.exists?(:email => @profile.email)
    #end
    user.save
    redirect_to profiles_path
  end

  def testAuth
     session[:user_id] = "ak1000"
     redirect_to profiles_path
  end
  def destroy
		session[:user_id] = nil
		redirect_to profiles_path
	end
end
