class ConversationController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @users = User.all
    @conversations = Conversation.all
  end
  def new
    @users = User.all
    @conversations = Conversation.all
  end
  def create
    if !Conversation.between(params[:sender_id],params[:recipient_id])
           .present?
      @conversation = Conversation.create!(conversation_params)

    else
      @conversation = Conversation.between(params[:sender_id],
                                           params[:recipient_id]).first
    end
    redirect_to conversation_messages_path(@conversation)
  end
  def show
    @messages = Message.all
  end
  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
