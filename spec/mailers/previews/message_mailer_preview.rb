# frozen_string_literal: true
# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview
  def message_me
    MessageMailer.message_me(Message.new(name: 'First Name', email: 'test@email.com', subject: 'Contact Us', content: 'Hello there!'))
  end

  def message_me_confirmation
    MessageMailer.message_me_confirmation(Message.new(name: 'First Name', email: 'test@email.com', subject: 'Contact Us', content: 'Hello there!'))
  end
end
