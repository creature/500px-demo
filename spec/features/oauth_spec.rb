require 'rails_helper'

describe "Logging in via oAuth" do
  before { fake_login_via_omniauth }

  it "Allows a logged out user to log in" do
    visit root_path
    click_link "Login with 500px"

    expect(current_path).to eq root_path
    expect(page).to have_selector ".flash.notice"
    within(".flash.notice") { expect(page).to have_content "Logged in" }
    expect(page).to have_link "Log out"
    expect(page).to have_content "Test user" # The name of our fake user.
  end

  # Logging in and then logging out could produce false positives (if login never worked)
  # but the previous test case should preclude that.
  it "Allows a logged in user to log out" do
    visit root_path
    click_link "Login with 500px"
    click_link "Log out"

    expect(current_path).to eq root_path
    expect(page).to have_selector ".flash.notice"
    within(".flash.notice") { expect(page).to have_content "logged out" }
    expect(page).to have_link "Login with 500px"
    expect(page).not_to have_content "Test user"
  end

  it "Handles login failures gracefully" do
    # Set up an auth failure first
    OmniAuth.config.mock_auth[:default] = :invalid_credentials
    OmniAuth.config.on_failure = Proc.new { | env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }

    visit root_path
    click_link "Login with 500px"

    expect(current_path).to eq root_path
    expect(page).to have_link "Login with 500px"
    expect(page).to have_selector ".flash.alert"
    within(".flash.alert") { expect(page).to have_content "Sorry" }
  end
end
