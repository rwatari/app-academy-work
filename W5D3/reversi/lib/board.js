let Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  const grid = new Array(8);
  for (var i = 0; i < grid.length; i++) {
    grid[i] = new Array(8);
  }

  grid[3][4] = new Piece('black');
  grid[4][3] = new Piece('black');
  grid[4][4] = new Piece('white');
  grid[3][3] = new Piece('white');

  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  let x = pos[0];
  let y = pos[1];
  if (!this.isValidPos(pos)){
    throw new Error("Not valid pos!");
  } else {
    return this.grid[x][y];
  }
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  if (this.isOccupied(pos)){
    return this.getPiece(pos).color === color;
  } else {
    return false;
  }
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  return this.getPiece(pos) !== undefined;
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  let x = pos[0];
  let y = pos[1];
  return !(x < 0 || y < 0 || x > 7 || y > 7);
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */
function _piecesToFlip (board, pos, color, dir, piecesToFlip) {
  if (!board.isValidPos(pos)) {
    return null;
  } else {
    const newPos = [pos[0] + dir[0], pos[1] + dir[1]];

    if (board.isMine(newPos, color) && piecesToFlip.length === 0) {
      return null;
    } else if (board.isMine(newPos, color)) {
      return piecesToFlip;
    } else if (!board.isOccupied(newPos) || !board.isValidPos(newPos)) {
      return null;
    } else {
      piecesToFlip.push(board.getPiece(newPos));
      return _piecesToFlip(board, newPos, color, dir, piecesToFlip);
    }
  }
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if (this.isOccupied(pos)) {
    return false;
  } else {
    for (let i = 0; i < Board.DIRS.length; i++) {
      if (_piecesToFlip(this, pos, color, Board.DIRS[i], []) !== null) {
        return true;
      }
    }
    return false;
  }
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  const moves = [];
  for (let row = 0; row < 8; row++) {
    for (let col = 0; col < 8; col++) {
      let pos = [row, col];
      if (this.validMove(pos, color)) {
        moves.push(pos);
      }
    }
  }

  return moves;
};

module.exports = Board;
