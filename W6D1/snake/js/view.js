const Board = require('./board.js');

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
