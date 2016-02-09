class PhotosController < ApplicationController
  def popular
    @photos = photos_from_json(F00px.popular(rpp: 100, image_size: 31).body).reject(&:nsfw)
  end

  protected

  def photos_from_json(json)
    data = JSON.parse(json)

    data['photos'].map { |p| F00px::Photo.new(p['name'], p['image_url'], p['nsfw']) }
  end
end

F00px::Photo = Struct.new(:name, :image_url, :nsfw)
