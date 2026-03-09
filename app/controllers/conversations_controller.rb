class ConversationsController < ApplicationController
  before_action :set_conversations

  def index
    @connections = current_user.active_connections
  end

  def show
    @conversation = @conversations.find(params[:id])
    @messages = @conversation.messages.sort_by(&:created_at)
    @message = @conversation.messages.build
  end

  def create
    other_user = User.find(params[:user_id])
    @conversation = @conversations.find { |c| c.user_ids.include?(other_user.id) }
    
    unless @conversation
      @conversation = Conversation.create
      @conversation.users << current_user
      @conversation.users << other_user
    end

    redirect_to @conversation
  end

  def destroy
    @conversation = @conversations.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path, notice: "Conversation deleted successfully."
  end

  private

  def set_conversations
    @conversations = current_user.conversations
                                 .includes(:users, messages: :user)
                                 .order(updated_at: :desc)
  end
end
