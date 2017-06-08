class Exercise < ApplicationRecord
  belongs_to :user

  validates :duration_in_minutes, numericality: true
  validates :workout, presence: true
  validates :workout_date, presence: true

end
