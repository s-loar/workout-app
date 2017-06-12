class ExercisesController < ApplicationController
  # before_action :authenticate_user!, except: [ :show, :index ]
  before_action :set_exercise, only: [ :show, :edit, :update, :destroy ]

  def index
    @exercises = current_user.exercises
  end

  def show
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)
    if @exercise.save
      flash[:success] = "Exercise has been created"
      redirect_to [current_user, @exercise]
    else
      flash.now[:danger] = "Exercise has not been created"
      render :new
    end
  end


  private

    def exercise_params
      params.require(:exercise).permit(:duration_in_minutes, :workout, :workout_date)
    end

    def set_exercise
      @exercise = current_user.exercises.find(params[:id])
    end

end
