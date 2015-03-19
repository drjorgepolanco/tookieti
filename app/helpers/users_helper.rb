module UsersHelper
  def full_name(user)
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

  def gravatar(user, options = { size: 80 })
    id  = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    url = "https://secure.gravatar.com/avatar/#{id}?s=#{size}"
    image_tag(url, alt: full_name(user), class: "gravatar")
  end
end
