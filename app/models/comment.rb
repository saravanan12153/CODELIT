class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  auto_html_for :content do
    html_escape
    image
    youtube(:width => "100%", :height => 300, :autoplay => false)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end
