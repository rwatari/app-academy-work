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
