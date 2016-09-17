# frozen_string_literal: true
class MessageMailer < ApplicationMailer
  default to: 'bombhillscommunity@gmail.com'
  default from: 'bombhillscommunity@gmail.com'
  def message_me(msg)
    @msg = msg
    mail from: @msg.email, subject: @msg.subject
  end

  def message_me_confirmation(msg)
    @msg = msg
    mail to: @msg.email, subject: @msg.subject
  end
end
