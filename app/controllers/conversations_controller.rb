class ConversationsController < ApplicationController
  before_action :set_conversations, only: [:index, :show, :destroy]

  def index
    @connections = current_user.active_connections
  end

  def show
    @conversation = @conversations.detect { |c| c.id == params[:id].to_i }
    return redirect_to conversations_path, alert: 'Conversation not found' unless @conversation
    
    @messages = @conversation.messages.sort_by(&:created_at)
    @message = @conversation.messages.build
  end

  def create
    other_user = User.find(params[:user_id])
    existing_conversation = current_user.conversations.joins(:users).where(users: { id: other_user.id }).first
    
    if existing_conversation
      redirect_to existing_conversation
    else
      @conversation = Conversation.create
      @conversation.users << current_user
      @conversation.users << other_user
      redirect_to @conversation
    end
  end

  def destroy
    @conversation = @conversations.detect { |c| c.id == params[:id].to_i }
    return redirect_to conversations_path, alert: 'Conversation not found' unless @conversation
    
    @conversation.destroy
    redirect_to conversations_path, notice: "Conversation deleted successfully."
  end

  private

  def set_conversations
    @conversations = current_user.conversations
                                 .includes(:users, messages: :user)
                                 .order(updated_at: :desc)
                                 .to_a
  end
end
