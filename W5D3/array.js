Array.prototype.myUniq = function () {
  const result = [];

  for (let i = 0; i < this.length; i++) {
    if (!result.includes(this[i])) {
      result.push(this[i]);
    }
  }
  return result;
};

Array.prototype.twoSum = function () {
  const result = [];

  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        result.push([i,j]);
      }
    }
  }

  return result;
};

Array.prototype.myTranspose = function () {
  const result = new Array(this[0].length);

  for (let i = 0; i < result.length; i++) {
    result[i] = new Array(this.length);
  }

  for (let row = 0; row < this.length; row++) {
    for (let col = 0; col < this[row].length; col++) {
      result[col][row] = this[row][col];
    }
  }

  return result;
};
