import consumer from "channels/consumer"

consumer.subscriptions.create({ channel: "ChatChannel", room_id: 1 }, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("We are connected to the chat channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from the chat channel!");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Received data:", data);
    message_area.value = message_area.value + "\n" + data;
    message_box.value = ""

    const messagesContainer = document.getElementById('message_area');
    if (messagesContainer) {
      messagesContainer.insertAdjacentHTML('beforeend', data.message); // Assuming data has a message field with HTML
      // Scroll to the bottom
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }
});
