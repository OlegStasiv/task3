class API::V1::ConversationController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id])
           .present?
      @conversation = Conversation.between(params[:sender_id],
                                           params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    render json: "Conversation has been created successfully!", status: 200
  end
  def destroy
    @conversation = Conversation.find_by(params[:id])
    @conversation.destroy
    render json: "Conversation has been deleted!", status: 200

  end

  def show
    @messages = Message.all
    render json: @messages
  end
  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end