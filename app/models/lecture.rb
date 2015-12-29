class Lecture < ActiveRecord::Base
  extend FriendlyId
  belongs_to :course
  has_many :progesses, dependent: :destroy
  has_many :users, through: :progesses
  friendly_id :title, use: :slugged

  def previous
    self.course.lectures.where(publish: true).where("seq < ?", seq).order(:seq).last
  end

  def next
    self.course.lectures.where(publish: true).where("seq > ?", seq).order(:seq).first
  end

  def doing?(user)
    self.progesses.where(user_id: [user.id]).where(status: 'doing').present?
  end

  def done?(user)
    self.progesses.where(user_id: [user.id]).where(status: 'done').present?
  end
end
