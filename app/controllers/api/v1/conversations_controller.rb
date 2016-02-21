class API::V1::ConversationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate
  def index
    @users = User.all
    @conversations = Conversation.all
  end

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
    @users = User.all
    @conversations = Conversation.all
    @conversations.each do |conversation|
      if conversation.sender_id == @current_user.id || conversation.recipient_id == @current_user.id
        if conversation.sender_id == @current_user.id
          @recipient = User.find(conversation.recipient_id)
        else
          @recipient = User.find(conversation.sender_id)


        end
      end
    end
    render json: @recipient
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end