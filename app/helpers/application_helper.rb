# frozen_string_literal: true
module ApplicationHelper
  def active_page(active_page)
    @active == active_page ? 'active' : ''
  end

  def can_edit(user, resource)
    user == resource.user
  end
end
