class ConversationsController < ApplicationController
  before_action :set_conversations
  before_action :set_conversation, only: [:show, :destroy, :mark_read]

  def index
    @connections = current_user.active_connections
  end

  def show
    @messages = @conversation.messages.sort_by(&:created_at)
    @message = @conversation.messages.build
    mark_messages_read
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
    @conversation.destroy
    redirect_to conversations_path, notice: "Conversation deleted successfully."
  end

  def mark_read
    mark_messages_read
    head :ok
  end

  private

  def set_conversation
    @conversation = @conversations.find(params[:id])
  end

  def set_conversations
    @conversations = current_user.conversations
                                 .includes(:users, messages: :user)
                                 .order(updated_at: :desc)
  end

  def mark_messages_read
    @conversation.messages.where.not(user_id: current_user.id).where(read: false).update_all(read: true)
  end
end
