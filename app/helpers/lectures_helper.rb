module LecturesHelper
  def linked_users(content)
    content.gsub /@([\w]+.[\w]+)/ do |match|
      link_to match, user_path(match.to_s[1..-1])
    end.html_safe
  end
end
