require "rails_helper"

RSpec.feature "Deleting Exercises" do

  before do
    @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @exercise = @john.exercises.create!(duration_in_minutes: 42, workout: "Test Exercise", workout_date: 1.days.ago)
    login_as(@john)
  end

  scenario "successful delete" do
    visit "/"
    click_link "My Lounge"

    path = "/users/#{@john.id}/exercises/#{@exercise.id}"
    link = "a[contains(href=\'#{path}\') and .//text()='Delete']"
    # find(:xpath, link).click
    click_link "Delete"

    expect(page).to have_content("Exercise has been deleted")
  end

end
