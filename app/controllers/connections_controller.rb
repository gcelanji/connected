class ConnectionsController < ApplicationController
  def create
    @user_to_connect = User.find(params[:user_id])
    @pending_connection = current_user.connections.build(connection: @user_to_connect, status: :pending)
    if @pending_connection.save
      redirect_back fallback_location: feed_path
    else
      raise "error"
    end
  end

  def destroy
    @connection = Connection.find(params[:id])
    @connection.destroy
    redirect_back fallback_location: feed_path
  end
end
