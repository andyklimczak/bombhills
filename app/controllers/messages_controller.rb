# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    MessageMailer.message_me(@message).deliver if @message.valid?
    MessageMailer.message_me_confirmation(@message).deliver if @message.valid?
    redirect_back(fallback_location: root_path)
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content, :subject)
  end
end
