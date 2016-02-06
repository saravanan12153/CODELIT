class CourseCompleteEmailJob
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(course, user)
    MyMailer.course_complete_email(course, user).deliver_now
  end

end