class ExercisesController < ApplicationController

  def index
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.user = current_user
    if @exercise.save
      flash[:success] = "Exercise has been created"
      redirect_to user_exercise_path(current_user)
    else
      flash.now[:danger] = "Exercise has not been created"
      render :new
    end
  end

  private

    def exercise_params
      params.require(:exercise).permit(:duration_in_minutes, :workout, :workout_date)
    end

end
