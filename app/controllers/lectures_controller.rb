class LecturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_lecture, only: [:show]

  # GET /lectures
  # GET /lectures.json
  def index
    authorize @course
    @lectures = @course.lectures.where(publish: true).order("seq ASC").all
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    authorize @lecture
    current_user.progesses.update_all(status: 'done')
    progress = current_user.progesses.find_or_initialize_by(lecture: @lecture)
    progress.status = 'doing'
    progress.save
    if Rails.env.production?
      @course.completed?(current_user)
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.where(publish: true).friendly.find(params[:course_id])
    end

    def set_lecture
      @lecture = @course.lectures.where(publish: true).friendly.find(params[:id])
    end
end
