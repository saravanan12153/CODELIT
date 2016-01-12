class UsersController < ApplicationController
  before_action :set_user, only: :show

  def show
    @enrols = @user.enrolled_courses
  end

  private
  def set_user
    @user = User.friendly.find(params[:id])
  end
end
