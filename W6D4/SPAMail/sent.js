const MessageStore = require("./message_store.js");

const Sent = {
  render: function() {
    const ulNode = document.createElement("ul");
    ulNode.className = "messages";
    const messages = MessageStore.getSentMessages();

    messages.forEach(message => {
      ulNode.appendChild(this.renderMessage(message));
    });
    return ulNode;
  },
  renderMessage: function(message) {
    const li = document.createElement("li");
    li.className = "messages";
    li.innerHTML = `<span class="to">${message.to}</span>` +
                   `<span class="subject">${message.subject}</span>` +
                   `<span class="body">${message.body}</span>`;
    return li;
  }
};

module.exports = Sent;
