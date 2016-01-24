class Cast < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :comments, as: :commentable, dependent: :destroy
  has_attached_file :avatar, styles: {medium: "300x300#"}, default_url: ENV["COURSE_PLACEHOLDER"]
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_uniqueness_of :slug

  def next
    self.class.where(publish: true).where("created_at > ?", created_at).friendly.first
  end

  def previous
    self.class.where(publish: true).where("created_at < ?", created_at).friendly.last
  end
end
