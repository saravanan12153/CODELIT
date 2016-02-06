class User < ActiveRecord::Base
  require 'digest/md5'
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_uniqueness_of :slug
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, password_length: 8..128, :omniauth_providers => [:google_oauth2, :facebook]
  has_attached_file :avatar, styles: {medium: "300x300#"}, default_url: ENV["USER_PLACEHOLDER"]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :enrols, dependent: :destroy
  has_many :courses, through: :enrols
  has_many :progesses, dependent: :destroy
  has_many :lectures, through: :progesses
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id

  if Rails.env.production?
    after_create :new_user_email, :subscribe
    after_update :subscribe
  end

  # Sending the welcome email when user logs in.
  def new_user_email
    NewUserEmailJob.new.async.perform(self)
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

  def self.find_for_google_oauth2(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    if user
      return user
    else
      registered_user = User.where(:email => access_token.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          name: data["name"],
          provider: access_token.provider,
          email: data["email"],
          uid: access_token.uid,
          image: data["image"],
          password: Devise.friendly_token[0, 20]
        )
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid).first

    if user
      return user
    else
      registered_user = User.where(:email => data.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          name: access_token.extra.raw_info.name,
          provider: access_token.provider,
          email: data.email,
          uid: access_token.uid,
          image: data.image,
          password: Devise.friendly_token[0, 20]
        )
      end
    end
  end

end
