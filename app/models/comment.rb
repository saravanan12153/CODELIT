class Comment < ActiveRecord::Base
  after_create :notified_users
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  auto_html_for :content do
    html_escape
    image
    youtube(:width => "100%", :height => 300, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def mentions
    @mentions ||= begin
      regex = /@([\w]+.[\w]+)/
      matches = content.scan(regex).flatten
    end
  end

  def mentioned_users
    @mentioned_users ||= User.where(slug: mentions)
  end

  def notified_users
    mentioned_users.each do |user|
      # WORK ON SENDING MAIL OR NOTIFICATIONS
    end
  end
end
