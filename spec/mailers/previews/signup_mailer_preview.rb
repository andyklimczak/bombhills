# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/signup_mailer
class SignupMailerPreview < ActionMailer::Preview
  def signup_notification
    SignupMailer.signup_notification(User.first)
  end
end
