class UsersController < ApplicationController
  before_action :set_user, only: :show

  def index
    @users = User.all
  end

  def show
    @enrols = @user.enrolled_courses
  end

  private
  def set_user
    @user = User.friendly.find(params[:id])
  end
end
