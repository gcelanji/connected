class ConnectionsController < ApplicationController
  before_action :set_connection, only: [:destroy, :accept]

  def index
    @pending_requests = Connection.where(connection_id: current_user.id, status: 'pending')
    accepted_requests_sent_by_user = Connection.where(user_id: current_user.id, status: 'accepted')
    accepted_requests_received_by_user = Connection.where(connection_id: current_user.id, status: 'accepted')
    @connections = accepted_requests_sent_by_user + accepted_requests_received_by_user
  end

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
    @connection.destroy
    redirect_back fallback_location: connections_path
  end

  def accept
    @connection.accepted!
    redirect_back fallback_location: connections_path
  end

  private

  def set_connection
    @connection = Connection.find(params[:id])
  end
end
