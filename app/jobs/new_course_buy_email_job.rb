class NewCourseBuyEmailJob
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(enrol)
    MyMailer.new_course_buy_email(enrol).deliver_now
  end

end