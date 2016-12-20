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
