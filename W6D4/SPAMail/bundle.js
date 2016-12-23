/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const Router = __webpack_require__(1);
	const Inbox = __webpack_require__(2);
	const Sent = __webpack_require__(4);
	const Compose = __webpack_require__(5);

	const routes = {
	  inbox: Inbox,
	  sent: Sent,
	  compose: Compose
	};


	document.addEventListener("DOMContentLoaded", () => {
	  const lis = document.querySelectorAll(".sidebar-nav li");
	  lis.forEach(li => {
	    li.addEventListener("click", e => {
	      e.preventDefault();
	      const location = li.innerText.toLowerCase();
	      window.location.hash = location;
	    });
	  });

	  const contentNode = document.querySelector(".content");
	  const router = new Router(contentNode, routes);
	  router.start();

	  window.location.hash = "#inbox";
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Router {
	  constructor(node, routes) {
	    this.node = node;
	    this.routes = routes;
	  }

	  start() {
	    this.render();
	    addEventListener("hashchange", () => this.render());
	  }

	  render() {
	    this.node.innerHTML = "";
	    const component = this.activeRoute();
	    if (component) {
	      this.node.appendChild(component.render());
	    }
	  }

	  activeRoute() {
	    const routeName =  window.location.hash.slice(1);
	    return this.routes[routeName];
	  }
	}

	module.exports = Router;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

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


/***/ },
/* 3 */
/***/ function(module, exports) {

	let messages = {
	  sent: [
	    {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
	    {to: "person@mail.com", subject: "zzz", body: "so booring"}
	  ],
	  inbox: [
	    {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body:
	"Stay at home mom discovers cure for leg cramps. Doctors hate her"},
	  {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"}
	]
	};

	class Message {
	  constructor(from, to, subject, body) {
	    this.from = from;
	    this.to = to;
	    this.subject = subject;
	    this.body = body;
	  }
	}

	let messageDraft = new Message("me@mail.com","","","");

	const MessageStore = {
	  getInboxMessages: function() {
	    return messages.inbox;
	  },
	  getSentMessages: function() {
	    return messages.sent;
	  },
	  getMessageDraft: function() {
	    return messageDraft;
	  },
	  updateDraftField: function(field, value) {
	    messageDraft[field] = value;
	  },
	  sendDraft: function() {
	    messages.sent.push(messageDraft);
	    messageDraft = new Message("me@mail.com","","","");
	  }
	};

	module.exports = MessageStore;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

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


/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

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


/***/ }
/******/ ]);