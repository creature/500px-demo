class SessionsController < ApplicationController
  # Log a user in by saving the relevant info to the session.
  def create
    session[:uid] = auth_hash.uid
    session[:user] = auth_hash.info.nickname
    session[:oauth_token] = auth_hash.credentials.token
    session[:oauth_secret] = auth_hash.credentials.secret
    redirect_to root_path, notice: "Logged in as #{auth_hash.info.nickname}."
  end

  # Log a user out by removing data from the session.
  def destroy
    [:uid, :user, :oauth_token, :oauth_secret].map { |sym| session[sym] = nil }
    redirect_to root_path, notice: "You've been logged out."
  end

  def failure
    logger.debug(auth_hash.inspect)
    redirect_to root_path, alert: "Sorry, we couldn't log you in. :("
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
