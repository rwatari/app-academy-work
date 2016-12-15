function range(start, end){
  if (end < start){
    return [];
  } else {
    return range(start, end - 1).concat([end]);
  }
}

function expo(base, exp){
  if (exp === 0){
    return 1;
  } else {
    return expo(base, exp - 1) * base;
  }
}

function expo2(base, exp){
  if (exp === 0){
    return 1;
  } else if (exp === 1) {
    return base;
  } else if (exp % 2 === 0){
    let root = expo2(base, exp/2);
    return root * root;
  } else {
    let root = expo2(base, (exp-1)/2);
    return root * root * base;
  }
}

function fib(n){
  if (n === 1){
    return [1];
  } else if (n === 2){
    return [1, 1];
  } else {
    let prev = fib(n - 1);
    let nextNum = prev.slice(-1)[0] + prev.slice(-2)[0];
    prev.push(nextNum);
    return prev;
  }
}

Array.prototype.bSearch = function(target) {
  if (this.length === 0){
    return NaN;
  } else {
    let mid = Math.floor(this.length/2);
    let left = this.slice(0,mid);
    let right = this.slice(mid + 1);
    if (this[mid] === target){
      return mid;
    } else if (this[mid] > target) {
      return left.bSearch(target);
    } else {
      return right.bSearch(target) + mid + 1;
    }
  }
};

function makeChange(amt, coins){
  if (coins.includes(amt)) {
    return [amt];
  } else if (coins.length === 0 || amt < coins.slice(-1)[0]) {
    return null;
  } else {
    let best = null;

    for (let i = 0; i < coins.length; i++) {
      let smallChange = makeChange(amt - coins[i], coins.slice(i));
      if (smallChange !== null) {
        if (best === null || best.length > smallChange.length + 1) {
          smallChange.push(coins[i]);
          best = smallChange;
        }
      }
    }

    return best;
  }
}

Array.prototype.mergeSort = function () {
  if (this.length <= 1) {
    return this;
  } else {
    const mid = Math.floor(this.length/2);
    let left = this.slice(0, mid).mergeSort();
    let right = this.slice(mid).mergeSort();

    return Array.merge(left, right);
  }
};

Array.merge = function(left, right) {
  let result = [];

  while (left.length > 0 && right.length > 0) {
    if (left[0] > right[0]) {
      result.push(right.shift());
    } else {
      result.push(left.shift());
    }
  }

  return result.concat(left).concat(right);
};

Array.prototype.subsets = function (){
  if (this.length === 0){
    return [[]];
  } else {
    let subsubs = this.slice(0, this.length - 1).subsets();
    let newsubsubs = subsubs.map(el => {
      return el.concat(this.slice(-1));
    });
    return subsubs.concat(newsubsubs);
  }
};
