class Course < ActiveRecord::Base
  has_many :lectures, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :enrols, dependent: :destroy
  has_many :users, through: :enrols

  # Enrols user to the course
  def enrolled(user)
    self.enrols.where(user_id: [user.id], course_id: [self.id]).empty?
  end
end
