class API::V1::MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate
before_action do
  @conversation = Conversation.find(params[:conversation_id])
end

  def index
    user_token = request.headers["Token"]
    @current_user = User.find_by(token: user_token)
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last
      if @messages.last.user_id != @current_user.id
        @messages.last.read = true;
      end
    end
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end



def create
  @message = @conversation.messages.new(message_params)
  if @message.save
    render json: "Message has been sent successfully!", status: 200
  end
end
  def destroy
    @message = @conversation.messages.find_by(conversation_id: params[:conversation_id], id: params[:id])
    @message.destroy
    render json: "Message has been deleted!", status: 200

  end

  def show_m
    @showall = []
    user_token = request.headers["Token"]
    @current_user = User.find_by(token: user_token)
    @messages = @conversation.messages
    @messages.each do |message|
      @email = message.user_id
      @names = User.find_by(@email)
      @showall.push(@names.email)
      @mes = message.body
      @showall.push(@mes)
    end

    render json: @showall


  end

private
def message_params
  params.require(:message).permit(:body, :user_id)
end
  end