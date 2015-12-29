class MyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mailer.send_new_user_email.subject
  #
  def send_new_user_email(user)
    @user = user
    mail(from: "no-reply @ CODElit<no-reply@codelit.com>", subject: 'Welcome To CODElit', to: "#{user.name}<#{user.email}>")
  end

  def new_course_buy_email(enrol)
    @enrol = enrol
    mail(from: "no-reply @ CODElit<no-reply@codelit.com>", subject: "CODElit | You bought #{enrol.course.title}", to: "#{enrol.user.name}<#{enrol.user.email}>")
  end

  def course_complete_email(course, user)
    @course = course
    @user = user
    mail(from: "no-reply @ CODElit<no-reply@codelit.com>", subject: "Congratulations on completing #{course.title}", to: "#{user.name}<#{user.email}>")
  end
end
