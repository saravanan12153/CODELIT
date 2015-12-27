class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
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

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      if params[:coupon].present?
        @coupon = Coupon.where(name: params[:coupon], course_id: @course.id).first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :subtitle, :description, :promo, :price, :publish)
    end
end
