module ApplicationHelper
  def avatar_url(user)
    if user
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png"
    else
      "http://lorempixel.com/output/fashion-q-c-20-20-4.jpg"
    end
  end
end
