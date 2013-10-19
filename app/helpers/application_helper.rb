module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def avatar_url(user)
    if user
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png"
    else
      'http://placehold.it/75x75&text=User'
    end
  end
end
