class NewUserEmailJob
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(user)
    MyMailer.send_new_user_email(user).deliver_now
  end

end