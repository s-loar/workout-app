require "rails_helper"

RSpec.feature "Searching for Users" do

  before do
    @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @sarah = User.create!(first_name: "Sarah", last_name: "Doe", email: "sarah@example.com", password: "password")
  end

  scenario "using last name to find multiple members" do
    visit "/"
    fill_in "search_name", with: "Doe"
    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah.full_name)
    expect(page.current_path).to eq("/dashboards/search")
  end

end
