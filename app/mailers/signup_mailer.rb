# frozen_string_literal: true

class SignupMailer < ApplicationMailer
  default from: 'notifications@bombhills.com'

  def signup_notification(user)
    @user = user
    mail(to: @user.email, subject: 'You signed up')
  end
end
