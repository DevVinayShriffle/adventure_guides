class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:room_id]}"
    puts "chat channel connected"
  end

  # def receive(data)
  #   # Handle messages sent from the client
  #   ActionCable.server.broadcast("chat_channel", data)
  # end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
