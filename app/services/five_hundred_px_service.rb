class FiveHundredPxService
  def most_popular(number = 100)
    @photos = photos_from_json(F00px.popular(rpp: number, image_size: 600).body).reject(&:nsfw)
  end

  protected

  def photos_from_json(json)
    data = JSON.parse(json)
    data['photos'].map { |p| FiveHundredPxService::Photo.new(p['id'], p['name'], p['image_url'], p['nsfw'], p['user']['username']) }
  end
end

FiveHundredPxService::Photo = Struct.new(:id, :name, :image_url, :nsfw, :user_name) do
  def site_url
    "https://500px.com/photo/#{id}"
  end
end
