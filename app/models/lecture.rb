class Lecture < ActiveRecord::Base
  extend FriendlyId
  belongs_to :course
  friendly_id :title, use: :slugged

  def previous
    self.course.lectures.where(publish: true).where("seq < ?", seq).order(:seq).last
  end

  def next
    self.course.lectures.where(publish: true).where("seq > ?", seq).order(:seq).first
  end
end
