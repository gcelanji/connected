class MessagesController < ApplicationController
	def create
		@conversation = Conversation.find(params[:conversation_id])
		@message = @conversation.messages.build(message_params)
		@message.user = current_user

		if @message.save
			respond_to do |format|
				format.html { redirect_to @conversation }
				format.turbo_stream
			end
		else
			@messages = @conversation.messages.includes(:user).order(:created_at)
			@conversations = current_user.conversations.includes(:users, messages: :user).order(updated_at: :desc)
			render 'conversations/show'
		end
	end

	private

	def message_params
		params.require(:message).permit(:content)
	end
end
