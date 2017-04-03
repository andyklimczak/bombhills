# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(_resource)
    new_user_session_path
  end

  def after_sign_up_path_for(_resource)
    new_user_session_path
  end

  def after_update_path_for(resource)
    show_user_path(resource)
  end
end
