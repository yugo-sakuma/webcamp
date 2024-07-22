class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @chat_room = ChatRoom.find(params[:id])
    if @chat_room.users.include?(current_user)
      @chat_messages = @chat_room.chat_messages.order(created_at: :asc)
    else
      redirect_to root_path, alert: 'あなたはこのチャットルームにアクセスできません。'
    end
  end
end