class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: {medium: "300x300#"}, default_url: ENV["USER_PLACEHOLDER"]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :enrols, dependent: :destroy
  has_many :courses, through: :enrols

  # Enrolling the course after payment or in case of free course
  def enroll_course(course, price)
    self.enrols.create(course: course, price: price)
  end

  # get user enrolled courses list
  def enrolled_courses()
    self.enrols.where(user_id: self.id).all
  end
end
