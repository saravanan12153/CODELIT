class Enrol < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  before_create :populate_guid

  validates_presence_of :user_id
  validates_presence_of :course_id
  #validates :guid, presence: true, uniqueness: true

  # after_create :send_mail_receipt
  #
  # def send_mail_receipt
  #   MyMailer.new_course_buy_mail(self).deliver_now
  # end

  if Rails.env.production?
    after_create :send_mail_receipt
  end

  def send_mail_receipt
    MyMailer.new_course_buy_email(self).deliver_now
  end

  private

  def populate_guid
    self.guid = SecureRandom.uuid
  end
end
