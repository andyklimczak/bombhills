class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.valid?
        MessageMailer.message_me(@message).deliver
        format.html { redirect_to request.referrer rescue redirect_to root_path, notice: 'Successful message' }
      else
        format.html { redirect_to request.referrer rescue redirect_to root_path, notice: 'Unsuccessful message' }
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:name, :email, :content, :subject)
  end
end
