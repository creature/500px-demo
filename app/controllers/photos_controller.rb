class PhotosController < ApplicationController
  # Display a page showing the most popular images right now.
  def popular
    @photos = Rails.cache.fetch("most_popular", expires_in: 1.minute) { photo_service.most_popular }
  end

  # Send a 'like' to 500px.
  def like
    photo_service.like(params[:id])
    redirect_to :back
  end

  protected

  # Putting this in its own method will make it easy for us to provide stub data when we want to write tests.
  def photo_service
    if view_context.user_logged_in?
      @service ||= FiveHundredPxService.new(session[:oauth_token], session[:oauth_secret])
    else
      @service ||= FiveHundredPxService.new
    end
  end
end
