function sum() {
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

function sum2(...numbers) {
  let total = 0;
  for (let i = 0; i < numbers.length; i++) {
    total += numbers[i];
  }
  return total;
}

Function.prototype.myBind = function(context, ...bindArgs) {
  return (...callArgs) => {
    this.apply(context, bindArgs.concat(callArgs));
  };
};

Function.prototype.myBind2 = function() {
  const context = arguments[0];
  const bindArgs = Array.prototype.slice.call(arguments, 1);
  const that = this;
  return function() {
    const callArgs = Array.prototype.slice.call(arguments);
    that.apply(context, bindArgs.concat(callArgs));
  };
};

function curriedSum(numArgs) {
  const numbers = [];
  const _curriedSum = function(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return sum(...numbers);
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
}

// const summer = curriedSum(4);
// console.log(summer(5)(30)(20)(1)); // => 56

Function.prototype.curry1 = function(numArgs) {
  const args = [];
  const _curriedFunc = (arg) => {
    args.push(arg);
    if (args.length === numArgs) {
      return this.apply(global, args);
    } else {
      return _curriedFunc;
    }
  };
  return _curriedFunc;
};

Function.prototype.curry2 = function(numArgs) {
  const args = [];
  const _curriedFunc = (arg) => {
    args.push(arg);
    if (args.length === numArgs) {
      // return this(...args);
      return this.apply(this, args);
    } else {
      return _curriedFunc;
    }
  };
  return _curriedFunc;
};

const summer = sum.curry2(4);
// console.log(summer(5)(30)(20)(1)); // => 56


function mysteryScoping3() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  console.log(x);
}

mysteryScoping3();
