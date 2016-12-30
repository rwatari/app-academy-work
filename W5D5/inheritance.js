Function.prototype.inherits = function (parent) {
  function Surrogate () {};
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function MovingObject () {};
MovingObject.prototype.hi = function() {
  console.log("Hi!!");
}

function Ship () {};
Ship.inherits(MovingObject);

Ship.prototype.shipHi = function () {
  console.log("Ship says hi!");
};

function Asteroid () {};
Asteroid.inherits(MovingObject);

Asteroid.prototype.astHi = function () {
  console.log("Asteroid says hi!");
};

const ship = new Ship();
const ast = new Asteroid();

ship.hi();
ship.shipHi();
// ship.astHi();
ast.hi();
