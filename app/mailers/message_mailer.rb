class MessageMailer < ApplicationMailer
  default to: "bombhillscommunity@gmail.com"
  def message_me(msg)
    @msg = msg
    mail from: @msg.email, subject: @msg.subject
  end
end
