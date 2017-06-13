require "rails_helper"

RSpec.feature "Signing Up Users" do

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
    # expect(page.current_path).to eq(articles_path)

    visit "/"
    expect(page).to have_content("John Doe")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign up"
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    expect(page).to have_content("4 errors prohibited this user from being saved")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    # expect(page.current_path).to eq(articles_path)
  end

end
