class Cast < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :comments, as: :commentable, dependent: :destroy

  def next
    self.class.where(publish: true).where("created_at > ?", created_at).friendly.first
  end

  def previous
    self.class.where(publish: true).where("created_at < ?", created_at).friendly.last
  end
end
