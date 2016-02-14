def fake_login_via_omniauth
  allow_any_instance_of(SessionsController).to receive(:auth_hash).and_return(OmniAuth::AuthHash.new({
    provider: '500px',
    uid: 12345,
    info: { nickname: "Test user" },
    credentials: { token: "fake token", secret: "fake secret" }
  }))
end

# Swap out the real 500px service with a test mock that generates fake data.
def use_mock_500px_service
  allow_any_instance_of(PhotosController).to receive(:photo_service).and_return(MockFiveHundredPxService.new)
end

# Swap out the 500px service with a version that returns an empty list.
def use_empty_500px_service
  allow_any_instance_of(PhotosController).to receive(:photo_service).and_return(EmptyFiveHundredPxService.new)
end
