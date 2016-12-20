class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    $('li.unclicked').on('click', event => {
      const currTarget = event.currentTarget;
      const $currTarget = $(currTarget);
      this.makeMove($currTarget);
    });
  }

  makeMove($square) {
    const pos = $square.data("pos");
    try {
      const currentPlayer = this.game.currentPlayer;
      this.game.playMove(pos);
      $square.text(currentPlayer);
      $square.removeClass("unclicked");
      $square.addClass(currentPlayer);
    } catch (e) {
      alert(e.msg);
    } finally {
      if (this.game.isOver()) {
        const $winMessage = $("<figcaption>");
        $winMessage.text(`${this.game.winner()} wins!`);
        $("figure").append($winMessage);
        $("li").off("mouseover");
        $("li").off("click");
      }
    }
  }

  setupBoard() {
    const $ul = $("<ul>");
    $ul.addClass("group");
    for (let i = 0; i < 9; i++) {
      const $li = $("<li>");
      $li.addClass('unclicked');
      $li.data("pos", [Math.floor(i/3), i % 3]);
      $ul.append($li);
    }
    this.$el.append($ul);

    $('li.unclicked').on('mouseover', event => {
      const currTarget = event.currentTarget;
      const $currTarget = $(currTarget);
      $currTarget.attr('style', 'background-color:yellow');
    });

    $('li.unclicked').on('mouseout', event => {
      const currTarget = event.currentTarget;
      const $currTarget = $(currTarget);
      $currTarget.removeAttr("style");
    });

  }
}

module.exports = View;
