require "rails_helper"

RSpec.feature "Showing Friend Workout" do
  before do
    @sarah = User.create!(first_name: "Sarah", last_name: "Anderson", email: "sarah@example.com", password: "password")
    @john = User.create!(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    login_as(@john)

    @e1 = @john.exercises.create(duration_in_minutes: 20,
                                 workout: "My body building activity",
                                 workout_date: Date.today )

    @e2 = @sarah.exercises.create(duration_in_minutes: 55,
                                 workout: "Weight lifting",
                                 workout_date: 2.days.ago )

    @e3 = @john.exercises.create(duration_in_minutes: 24,
                                 workout: "Jumping Jacks",
                                 workout_date: 8.days.ago )

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario "shows friend's exercises for the last 7 days" do
    visit "/"
    click_link "My Lounge"
    click_link @sarah.full_name

    expect(page).to have_content(@sarah.full_name + "'s Exercises")
    expect(page).to have_content(@e2.workout)
    expect(page).to have_css("div#chart")
  end
end
