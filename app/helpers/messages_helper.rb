module MessagesHelper
  def recipients_options
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}'>#{user.user_name+" ("+user.email+")"}</option>"
    end
    s.html_safe
  end
end
