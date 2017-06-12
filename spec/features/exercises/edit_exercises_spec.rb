require "rails_helper"

RSpec.feature "Editing Exercises" do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @exercise = @john.exercises.create!(duration_in_minutes: 20, workout: "Test Exercise", workout_date: 1.days.ago)
    login_as(@john)
  end

  scenario "with valid data" do
    visit "/"
    click_link "My Lounge"

    path = "/users/#{@john.id}/exercises/#{@exercise.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click

    fill_in "Duration", with: 45
    click_button "Update Exercise"

    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(45)
    expect(page).not_to have_content(20)
  end

end
