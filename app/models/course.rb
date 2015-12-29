class Course < ActiveRecord::Base
  has_many :lectures, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :enrols, dependent: :destroy
  has_many :users, through: :enrols

  has_attached_file :image, styles: {medium: "500x500#"}, default_url: ENV["COURSE_PLACEHOLDER"]
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Enrols user to the course
  def enrolled(user)
    self.enrols.where(user_id: [user.id], course_id: [self.id]).empty?
  end
end
