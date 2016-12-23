const MessageStore = require("./message_store.js");

const Inbox = {
  render: function() {
    const ulNode = document.createElement("ul");
    ulNode.className = "messages";
    const messages = MessageStore.getInboxMessages();

    messages.forEach(message => {
      ulNode.appendChild(this.renderMessage(message));
    });
    return ulNode;
  },
  renderMessage: function(message) {
    const li = document.createElement("li");
    li.className = "messages";
    li.innerHTML = `<span class="from">${message.from}</span>` +
                   `<span class="subject">${message.subject}</span>` +
                   `<span class="body">${message.body}</span>`;
    return li;
  }
};

module.exports = Inbox;
