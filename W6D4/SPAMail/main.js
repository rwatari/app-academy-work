const Router = require("./router.js");
const Inbox = require("./inbox.js");
const Sent = require("./sent.js");
const Compose = require("./compose.js");

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
