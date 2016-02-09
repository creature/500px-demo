class PhotosController < ApplicationController
  # Display a page showing the most popular images right now.
  def popular
    @photos = Rails.cache.fetch("most_popular", expires_in: 1.minute) { photo_service.most_popular }
  end

  protected

  # Putting this in its own method will make it easy for us to provide stub data when we want to write tests.
  def photo_service
    @service ||= FiveHundredPxService.new
  end
end
