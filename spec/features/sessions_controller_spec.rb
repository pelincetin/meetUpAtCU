require 'rails_helper'
require 'open-uri'

RSpec.feature "google auth", type: :feature do

    before(:each) do
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
end
    
    scenario "log in" do
        visit "/profiles"
        click_link "Log in"
        click_link "Log in"
        expect(page).to have_text('Tony Stark')
    end

    scenario "registration" do
        visit "/profiles"
        click_link "Sign Up"
        fill_in "Name", with: "Tony Stark"
        fill_in "Email", with: "tony@stark.com"
        fill_in "UNI", with: "ts2244"
        click_button "Submit"
        expect(page).to have_text('Tony Stark')
    end

    scenario "log in and log out" do
        visit "/profiles"
        click_link "Log in"
        click_link "Log in"
        click_link "Log out"
        expect(page).to have_text('Log in')
    end
end
