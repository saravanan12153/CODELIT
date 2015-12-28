class Lecture < ActiveRecord::Base
  belongs_to :course

  def previous
    self.course.lectures.where(publish: true).where("seq < ?", seq).order(:seq).last
  end

  def next
    self.course.lectures.where(publish: true).where("seq > ?", seq).order(:seq).first
  end
end
