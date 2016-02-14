class FiveHundredPxService
  def initialize(token = nil, secret = nil)
    @client = F00px::Client.new

    if token && secret
      @client.token = token
      @client.token_secret = secret
    end
  end

  def most_popular(number = 100)
    photos_from_json(@client.popular(rpp: number, image_size: 600).body).reject(&:nsfw)
  end

  # Sends a 'like' to 500px, returning a boolean to indicate success or failure.
  def like(id)
    @client.post("photos/#{id}/vote?vote=1").success?
  end

  # Removes a like from 500px, returning a boolean to indicate success or failure.
  def unlike(id)
    @client.delete("photos/#{id}/vote").success?
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
