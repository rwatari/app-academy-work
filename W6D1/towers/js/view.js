class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.firstTower = null;
    this.setupTowers();
    this.render();
    this.clickTower();
  }

  setupTowers() {
    for (let i = 0; i < 3; i++) {
      const $ul = $('<ul></ul>');
      $ul.addClass(`${i}`);
      // for (let j = 0; j < 3; j++) {
      //   $ul.append($('<li></li>'));
      // }
      $ul.data('pos', i);
      this.$el.append($ul);
    }
  }

  render() {
    $('li').remove();
    for (let i = 0; i < 3; i++) {
      const stackArr = this.game.towers[i];
      const $ul = $(`ul.${i}`);

      for (let j = 0; j < stackArr.length; j++) {
        const $li = $('<li></li>');
        $li.addClass(`d${stackArr[j]}`);
        $ul.prepend($li);
      }
    }

    if (this.game.isWon()) {
      const $winMessage = $("<figcaption>");
      $winMessage.text(`You win!`);
      $("figure").append($winMessage);
      $("ul").off('click');
    }
  }

  clickTower() {
    $('ul').on('click', event => {
      const $curr = $(event.currentTarget);

      if (this.firstTower === null) {
        this.firstTower = $curr.data('pos');
        $curr.addClass('clicked');
      } else {
        const start = this.firstTower;
        const end = $curr.data('pos');

        if (this.game.isValidMove(start, end)) {
          this.game.move(start, end);
          this.render();
        } else {
          alert("Invalid move");
        }

        this.firstTower = null;
        $('ul.clicked').removeClass('clicked');
      }
    });
  }
}

module.exports = View;
