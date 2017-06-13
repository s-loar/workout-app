require "rails_helper"

RSpec.feature "Signing Users In" do

  before do
    @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_link("Sign in")
    expect(page).to have_link("Sign up")
  end

end
