class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :destroy, :mark_read]

  def index
    @connections = current_user.active_connections
    @conversations = current_user.conversations
                                 .includes(:users, messages: :user)
                                 .joins(:messages)
                                 .distinct
                                 .order(updated_at: :desc)
  end

  def show
    @messages = @conversation.messages.order(:created_at)
    @message = @conversation.messages.build
    mark_messages_read
  end

  def create
    @conversation = Conversation.create!(user_ids: [current_user.id, params[:user_id]])
    redirect_to @conversation
  end

  def destroy
    current_user.conversations.delete(@conversation)
    redirect_to conversations_path, notice: "Conversation deleted successfully."
  end

  def mark_read
    mark_messages_read
    head :ok
  end

  private

  def set_conversation
    @conversation = current_user.conversations.find(params[:id])
  end

  def mark_messages_read
    @conversation.messages.where.not(user_id: current_user.id).where(read: false).update_all(read: true)
  end
end
