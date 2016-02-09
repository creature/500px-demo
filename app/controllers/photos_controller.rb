class PhotosController < ApplicationController
  def popular
    @photos = photo_service.most_popular
  end

  protected

  def photo_service
    @service ||= FiveHundredPxService.new
  end
end
