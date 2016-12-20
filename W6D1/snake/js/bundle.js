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

	const View = __webpack_require__(1);
	$(() => {
	  const view = new View($(".snake"));
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Board = __webpack_require__(2);

	class View {
	  constructor($el) {
	    this.board = new Board();
	    this.$el = $el;
	    this.setupBoard();
	    this.render();
	    this.turnSnake();
	    setInterval(() => this.step(), 500);
	  }

	  setupBoard() {
	    for (let i = 0; i < 16; i++) {
	      const $ul = $("<ul></ul>");
	      for (let j = 0; j < 16; j++) {
	        const $li = $("<li></li>");
	        $li.data("pos", [i, j]);
	        $ul.append($li);
	      }
	      this.$el.append($ul);
	    }
	  }

	  turnSnake() {
	    $("body").on("keydown", event => {
	      this.handleKeyEvent(event);
	    });
	  }

	  render() {
	    $('li.segment').removeClass('segment');
	    const segments = this.board.snake.segments;
	    for (var i = 0; i < segments.length; i++) {
	      const row = segments[i][0] + 1;
	      const col = segments[i][1] + 1;
	      const $li = $(`ul:nth-child(${row}) :nth-child(${col})`);
	      $li.addClass('segment');
	    }
	  }

	  handleKeyEvent(event) {
	    switch (event.keyCode) {
	      case 38:
	        this.board.snake.turn("N");
	        break;
	      case 40:
	        this.board.snake.turn("S");
	        break;
	      case 37:
	        this.board.snake.turn("W");
	        break;
	      case 39:
	        this.board.snake.turn("E");
	        break;
	      default:
	        return;
	    }
	  }

	  step() {
	    this.board.snake.move();
	    this.render();
	  }
	}

	module.exports = View;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Snake = __webpack_require__(3);

	class Board {
	  constructor() {
	    this.snake = new Snake();
	  }

	  randomPos() {

	  }

	  growSnake() {

	  }

	  isGameOver() {

	  }

	}

	module.exports = Board;


/***/ },
/* 3 */
/***/ function(module, exports) {

	class Snake {
	  constructor() {
	    this.direction = "N";
	    this.segments = [[8, 8]];
	  }

	  move() {
	    const currHead = this.segments[0];
	    const newHead = Snake.plus(currHead, Snake.directions[this.direction]);
	    this.segments.unshift(newHead);
	    this.segments.pop();
	  }

	  turn(newDir) {
	    if (!Snake.isOpposite(this.direction, newDir)) {
	      this.direction = newDir;
	    }
	  }

	  static plus(arr1, arr2) {
	    return [arr1[0] + arr2[0], arr1[1] + arr2[1]];
	  }

	  static equals(arr1, arr2) {
	    return arr1[0] === arr2[0] && arr1[1] === arr2[1];
	  }

	  static isOpposite(oldDir, newDir) {
	    switch (oldDir) {
	      case "N":
	        return newDir === "S";
	      case "E":
	        return newDir === "W";
	      case "W":
	        return newDir === "E";
	      default:
	        return newDir === "N";
	    }
	  }
	}

	Snake.directions = {
	  N: [-1, 0],
	  E: [0, 1],
	  S: [1, 0],
	  W: [0, -1]
	};

	module.exports = Snake;


/***/ }
/******/ ]);