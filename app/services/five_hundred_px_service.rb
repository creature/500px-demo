class FiveHundredPxService
  def most_popular(number = 100)
    @photos = photos_from_json(F00px.popular(rpp: number, image_size: 600).body).reject(&:nsfw)
  end

  protected

  def photos_from_json(json)
    data = JSON.parse(json)
    data['photos'].map { |p| FiveHundredPxService::Photo.new(p['name'], p['image_url'], p['nsfw']) }
  end
end

FiveHundredPxService::Photo = Struct.new(:name, :image_url, :nsfw)
