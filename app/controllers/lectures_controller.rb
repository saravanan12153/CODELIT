class LecturesController < ApplicationController
  before_action :set_course
  before_action :set_lecture, only: [:show]

  # GET /lectures
  # GET /lectures.json
  def index
    authorize @course
    @lectures = @course.lectures.all
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    authorize @lecture
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:course_id])
    end

    def set_lecture
      @lecture = @course.lectures.find(params[:id])
    end
end
