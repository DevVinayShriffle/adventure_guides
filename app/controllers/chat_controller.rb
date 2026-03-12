class ChatController < ApplicationController
  def room
  end

  def send_message  
  ActionCable.server.broadcast "chat_channel_1", params[:message_box]  
 end
end
