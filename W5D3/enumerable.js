Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

Array.prototype.myMap = function(callback) {
  const res = new Array;
  this.myEach(el => res.push(callback(el)));
  return res;
};

// [1,2,3].myMap(el => {return el * 2;})

Array.prototype.myInject = function(callback) {
  let accum = this[0];
  this.slice(1).myEach(el => {
    accum = callback(accum, el);
  });

  return accum;
};

// [1,2,3].myInject((sum,el) => {return sum + el})
