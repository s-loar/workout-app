require "rails_helper"

RSpec.feature "Display Home Page" do

  scenario "when user visits the home page" do
    visit '/'

    expect(page).to have_link('Home')
    expect(page).to have_link('Athletes Den')
    expect(page).to have_content('Workout Lounge')
    expect(page).to have_content('Show off your workout to your friends and family')
  end
end
