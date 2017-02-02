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
    current_user == post.user || current_user.admin? || !post.private? || post.user_collaborators.include?(current_user)
  end

  def user_authorized_for_collaboration_post?(post)
    (current_user == post.user || current_user.admin?) && post.private?
  end

  def user_authorized_for_private_checkbox?(post)
     current_user.admin? || (current_user.premium? && current_user == post.user)
  end

  # Replaced by Pundit
  #def user_authorized_for_private_post?
  #  current_user.role == "premium" || current_user.admin?
  #end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end



end
