Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fiveHundredPx, ENV['500PX_CONSUMER_KEY'], ENV['500PX_CONSUMER_SECRET']
end
