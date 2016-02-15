require 'rails_helper'

describe "Liking photos" do
  before { use_mock_500px_service }

  it "Doesn't show 'like' buttons to people who aren't logged in" do
    visit root_path
    expect(page).not_to have_selector ".like"
  end

  context "A logged in user" do
    # Fake a login before each test.
    before do
      fake_login_via_omniauth("Test user", 12345)
      visit root_path
      click_link "Login with 500px"
    end

    it "Shows like buttons to people who are logged in" do
      expect(page).to have_selector ".like", count: 100
    end

    it "Accurately reflects the status of likes based on things in the database" do
      our_liked_photo_id, other_liked_photo_id = (1..100).to_a.sample(2) # Pick two random IDs for our photos.
      Like.create(user_id: 12345, photo_id: our_liked_photo_id)
      Like.create(user_id: 54321, photo_id: other_liked_photo_id)
      visit root_path

      # Should have a visible link to unlike our previously-liked photo...
      our_photo = page.find(".photo[data-photo-id='#{our_liked_photo_id}']")
      expect(our_photo).not_to have_selector "#unlike_button_#{our_liked_photo_id}.hidden"

      # Definitely shouldn't have a visible link to unlike someone else's liked photo...
      other_liked_photo = page.find(".photo[data-photo-id='#{other_liked_photo_id}']")
      expect(other_liked_photo).to have_selector "#unlike_button_#{other_liked_photo_id}.hidden"

      # ... or any of the others. Like buttons should be visible, unlike buttons not.
      (1..100).reject { |n| [our_liked_photo_id, other_liked_photo_id].include? n }.each do |n|
        photo = page.find(".photo[data-photo-id='#{n}']")
        expect(photo).to have_selector "#like_button_#{n}"
        expect(photo).to have_selector "#unlike_button_#{n}.hidden"
      end

    end
    it "Allows a user to like a photo" do
      expect { click_link("", { href: like_photo_path(55) }) }.to change { Like.count }.by 1
      new_like = Like.last
      expect(new_like.user_id).to eq 12345
      expect(new_like.photo_id).to eq 55
    end

    it "Allows a user to remove a like" do
      Like.create(user_id: 12345, photo_id: 23)

      visit root_path
      expect { click_link("", href: unlike_photo_path(23)) }.to change { Like.count }.by(-1)
    end
  end
end
