class User < ActiveRecord::Base
  require 'digest/md5'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: {medium: "300x300#"}, default_url: ENV["USER_PLACEHOLDER"]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :enrols, dependent: :destroy
  has_many :courses, through: :enrols
  has_many :progesses, dependent: :destroy
  has_many :lectures, through: :progesses

  if Rails.env.production?
    after_create :new_user_email, :subscribe
  end

  # Sending the welcome email when user logs in.
  def new_user_email
    MyMailer.send_new_user_email(self).deliver_now
  end

  # MailChimp Subscribe
  def subscribe
    @list_id = ENV['MAILCHIMP_LIST_ID']
    gb = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    gb.timeout = 15
    # generate lower_case_md5_hashed_email_address required by mailchimp api
    digest = Digest::MD5.hexdigest(self.email)

    gb.lists(@list_id).members(digest.to_s).upsert(body: {email_address: self.email, status: "subscribed", merge_fields: {FNAME: self.name}})
  end

  # Enrolling the course after payment or in case of free course
  def enroll_course(course, price)
    self.enrols.create(course: course, price: price)
  end

  # get user enrolled courses list
  def enrolled_courses()
    self.enrols.where(user_id: self.id).all
  end
end
