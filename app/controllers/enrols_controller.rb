class EnrolsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course

  def create
    if @coupon.present? && @coupon.total > 0
      price = @course.price-@course.price*@coupon.percent/100
    else
      price = @course.price
    end
    if price > 0
      @result = Braintree::Transaction.sale(
        # Amount to send
        amount: price,
        # Not Saved payment
        payment_method_nonce: params[:payment_method_nonce])

      # if payment is successful
      if @result.success?
        if @coupon.present? && @coupon.total > 0
          @coupon.decrement!(:total)
        end
        @enrol = current_user.enroll_course(@course, price)
        redirect_to course_lectures_path(@course), notice: 'You bought the course!'

        # if payment failed
      else
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        redirect_to course_path(@course)
      end

      # if course is free
    else
      @enrol = current_user.enroll_course(@course, 0)
      redirect_to course__lectures_path(@course), notice: 'You gained access to the course!'
    end
  end

  private
  def set_course
    @course = Course.find(params[:course_id])
    if params[:coupon].present?
      @coupon = Coupon.where(name: params[:coupon], course_id: @course.id).first
    end
  end

end
