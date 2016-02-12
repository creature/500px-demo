class MockFiveHundredPxService
  def initialize(token = nil, secret = nil)
    nil
  end

  def most_popular(number = 100)
    (1..number).map { |n| FiveHundredPxService::Photo.new(n, "Fake photo #{n}", "http://placekitten.com/256/256", false, "Fake user #{n}") }
  end

  def like(id)
    true
  end

  def unlike(id)
    true
  end

end

# An implementation of the API wrapper that returns no data.
class EmptyFiveHundredPxService < MockFiveHundredPxService
  def most_popular
    []
  end
end
