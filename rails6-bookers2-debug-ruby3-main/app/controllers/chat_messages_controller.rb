class ChatMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    if @chat_room.users.include?(current_user)
      @chat_message = @chat_room.chat_messages.build(chat_message_params)
      @chat_message.user = current_user
      if @chat_message.save
        redirect_to chat_room_path(@chat_room)
      else
        render 'chat_rooms/show'
      end
    else
      redirect_to root_path, alert: 'あなたはこのチャットルームにメッセージを送信できません。'
    end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:content)
  end
end