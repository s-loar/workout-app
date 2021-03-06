class ExercisesController < ApplicationController
  # before_action :authenticate_user!, except: [ :show, :index ]
  before_action :set_exercise, only: [ :show, :edit, :update, :destroy ]

  def index
    @exercises = current_user.exercises
    @friends = current_user.friends
    set_current_room
    @message = Message.new
    @messages = current_room.messages if current_room
    @followers = Friendship.where(friend_id: current_user.id)
  end

  def show
  end

  def edit
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

  def update
    if @exercise.update(exercise_params)
        flash[:success] = "Exercise has been updated"
        redirect_to [current_user, @exercise]
      else
        flash.now[:danger] = "Exercise has not been updated"
        render :edit
      end
  end

  def destroy
    if @exercise.destroy
      flash[:success] = "Exercise has been deleted."
      redirect_to user_exercises_path(current_user)
    end
  end


  private

    def exercise_params
      params.require(:exercise).permit(:duration_in_minutes, :workout, :workout_date)
    end

    def set_exercise
      @exercise = current_user.exercises.find(params[:id])
    end

    def set_current_room
      if params[:roomId]
        @room = Room.find_by(id: params[:roomId])
      else
        @room = current_user.room
      end
      session[:current_room] = @room.id if @room
    end
end
