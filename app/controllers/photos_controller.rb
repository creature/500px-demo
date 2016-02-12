class PhotosController < ApplicationController
  include ApplicationHelper

  # Display a page showing the most popular images right now.
  def popular
    @photos = Rails.cache.fetch("most_popular", expires_in: 1.minute) { photo_service.most_popular }
    @liked_ids = user_logged_in? ? Like.where(user_id: session[:uid]).pluck(:photo_id) : []
  end

  # Send a 'like' to 500px.
  def like
    if photo_service.like(params[:id]).success?
      Like.find_or_create_by(user_id: session[:uid], photo_id: params[:id])
    end
    redirect_to :back
  end

  # 'Unlike' a photo - that is, remove a 'Like'.
  def unlike
    if photo_service.unlike(params[:id]).success?
      Like.where(user_id: session[:uid], photo_id: params[:id]).delete_all
    end
    redirect_to :back
  end

  protected

  # Putting this in its own method will make it easy for us to provide stub data when we want to write tests.
  def photo_service
    if user_logged_in?
      @service ||= FiveHundredPxService.new(session[:oauth_token], session[:oauth_secret])
    else
      @service ||= FiveHundredPxService.new
    end
  end
end
