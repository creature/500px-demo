class SessionsController < ApplicationController
  def create
    session[:user] = auth_hash.info.nickname
    session[:oauth_token] = auth_hash.credentials.token
    session[:oauth_secret] = auth_hash.credentials.secret
    redirect_to root_path, notice: "Signed in as #{auth_hash.info.nickname}."
  end

  def destroy
    session[:user] = nil
    redirect_to root_path, notice: "You've been signed out."
  end

  def failure
    logger.debug(request.env['omniauth.auth'])
    redirect_to root_path, alert: "Sorry, we couldn't log you in. :("
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
