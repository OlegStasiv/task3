class API::V1::MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
before_action do
  @conversation = Conversation.find(params[:conversation_id])
end



def create
  @message = @conversation.message.new(message_params)
  if @message.save
    render json: "Message has been sent successfully!", status: 200
  end
end
  def destroy
    @message = @conversation.message.find_by(conversation_id: params[:conversation_id], id: params[:id])
    @message.destroy
    render json: "Message has been deleted!", status: 200

  end

private
def message_params
  params.require(:message).permit(:body, :user_id)
end
  end