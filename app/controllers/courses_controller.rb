class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all.order("updated_at ASC")
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    if user_signed_in?
      if !@course.enrolled(current_user)
        redirect_to course_lectures_path(@course)
      end
      if @coupon.present? && @coupon.total > 0
        @price = @course.price.to_f-@course.price.to_f*@coupon.percent.to_f/100
        if @price <= 0
          @coupon.decrement!(:total)
        end
      else
        @price = @course.price
      end
      if @price == 0
        @enrol = current_user.enroll_course(@course, 0)
        redirect_to course_path(@course), notice: 'You gained access to the course!'
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.where(publish: true).friendly.find(params[:id])
      if params[:coupon].present?
        @coupon = Coupon.where(name: params[:coupon], course_id: @course.id).first
      end
    end
end
