module UsersHelper
  def full_name(user)
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  def gravatar(user)
    id  = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{id}"
    image_tag(url, alt: full_name(user), class: "gravatar")
  end
end
