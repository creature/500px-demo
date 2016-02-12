require 'rails_helper'

describe "The 'Popular photos' page" do
  before { allow_any_instance_of(PhotosController).to receive(:photo_service).and_return(MockFiveHundredPxService.new) }

  it "Is accessible via the root path" do
    visit root_path
    expect(page.status_code).to eq 200
    expect(page).to have_content "Most popular"
  end

  it "Is accessible from the photos/popular path" do
    visit photos_popular_path
    expect(page.status_code).to eq 200
    expect(page).to have_content "Most popular"
  end

  it "Displays some photos, if some are returned" do
    visit root_path
    expect(page).to have_selector('img', 100)
  end

  it "Displays a message to the user if there's nothing returned from 500px" do
    allow_any_instance_of(PhotosController).to receive(:photo_service).and_return(EmptyFiveHundredPxService.new)

    visit root_path
    expect(page).to have_selector ".no_photos"
    expect(page).to have_content "couldn't retrieve the most popular images"
  end
end
