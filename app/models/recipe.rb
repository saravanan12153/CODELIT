class Recipe < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_taggable
  has_many :comments, as: :commentable, dependent: :destroy
  validates_uniqueness_of :slug

  def next
    self.class.where(publish: true).where("created_at > ?", created_at).friendly.first
  end

  def previous
    self.class.where(publish: true).where("created_at < ?", created_at).friendly.last
  end
end
