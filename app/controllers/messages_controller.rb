class MessagesController < ApplicationController
	def create
		@conversation = current_user.conversations.find(params[:conversation_id])
		@message = @conversation.messages.build(message_params)
		@message.user = current_user

		if @message.save
			@sent_message = @message
			@message = @conversation.messages.build

			respond_to do |format|
				format.html { redirect_to @conversation }
				format.turbo_stream
			end
		else
			respond_to do |format|
				format.html { render "conversations/show", status: :unprocessable_entity }
				format.turbo_stream { render "conversations/show", status: :unprocessable_entity }
			end
		end
	end

	private

	def message_params
		params.require(:message).permit(:content)
	end
end
