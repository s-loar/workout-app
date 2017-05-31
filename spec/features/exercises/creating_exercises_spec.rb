require "rails_helper"

RSpec.feature "Creating Exercises" do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
  end

  scenario "successfully create an exercise" do
    visit "/"
    click_link "My Lounge"
    expect(page).to have_link("New Workout")

    click_link "New Workout"
    expect(page).to have_link("Back")

    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "Weight lifting"
    fill_in "Activity Date", with: "2017-05-31"
    click_button "Create Exercise"

    expect(page).to have_content("Exercise has been created")

    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@john, exercise))
    expect(exercise.user_id).to eq(@john.id)
  end

  # scenario "fails to create an exercise" do
  #   visit "/"
  #   click_link "My Lounge"
  # end

end
