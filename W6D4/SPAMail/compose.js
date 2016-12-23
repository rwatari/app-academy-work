const MessageStore = require("./message_store.js");

const Compose = {
  render: function() {
    const divNode = document.createElement("div");
    divNode.className = "new-message";
    divNode.innerHTML = this.renderForm();
    divNode.addEventListener("change", event => {
      const target = event.target;
      const name = target.name;
      const value = target.value;
      MessageStore.updateDraftField(name, value);
    });

    divNode.addEventListener("submit", event => {
      event.preventDefault();
      MessageStore.sendDraft();
      window.location.hash = "#inbox";
    });
    return divNode;
  },
  renderForm: function() {
    const currentDraft = MessageStore.getMessageDraft();
    const form = `<p class="new-message-header">New Message</p>` +
                 `<form class="compose-form">` +
                 `<input placeholder="Recipient" name="to" type="text" value="${currentDraft.to}"></input>` +
                 `<input placeholder="Subject" name="subject" type="text" value="${currentDraft.subject}"></input>` +
                 `<textarea rows=20 name="body">${currentDraft.body}</textarea>` +
                 `<button type="submit" class="btn btn-primary submit-message">Send</textarea>` +
                 "</form>";
    return form;
  }
};

module.exports = Compose;
