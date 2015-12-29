# Preview all emails at http://localhost:3000/rails/mailers/my_mailer
class MyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/my_mailer/send_new_user_email
  def send_new_user_email
    MyMailer.send_new_user_email
  end

end
