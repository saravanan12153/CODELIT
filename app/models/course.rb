class Course < ActiveRecord::Base
  extend FriendlyId
  has_many :lectures, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :enrols, dependent: :destroy
  has_many :users, through: :enrols
  friendly_id :title, use: :slugged
  validates_uniqueness_of :slug

  has_attached_file :image, styles: {medium: "500x500#"}, default_url: ENV["COURSE_PLACEHOLDER"]
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  # Enrols user to the course
  def enrolled(user)
    self.enrols.where(user_id: [user.id], course_id: [self.id]).empty?
  end

  def progress?(user)
    total = 0
    self.lectures.each do |lec|
      if lec.doing?(user) || lec.done?(user)
        total = total + 1.0
      end
    end
    (total / self.lectures.all.count * 100).to_i
  end

  def completed?(user)
    if self.progress?(user) == 100 && !self.enrols.where(user_id: [user.id]).first.complete
      self.enrols.where(user_id: [user.id]).first.update!(complete: true)
      CourseCompleteEmailJob.new.async.perform(self, user).deliver_later r
    end
  end

end
