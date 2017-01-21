module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Wikiikki App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def user_authorized_for_delete_post?(post)
    current_user == post.user || current_user.admin?
  end

  def user_authorized_for_edit_post?(post)
    current_user == post.user || current_user.admin? || !post.private?
  end

  def user_authorized_for_private_post?
    current_user.role == "premium" || current_user.admin?
  end

end
