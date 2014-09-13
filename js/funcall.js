function juggle() {
    console.log("arguments: " + arguments);
    console.log("this: " + this);
    var result = 0;
    for (var i = 1; i < arguments.length; i++) {
        result += i;
    }
    this.result = result;
    this.super = arguments[0];
    this.self = this;
}

var call1 = {};
juggle.apply(call1, [this, 1, 2, 3, 4]);
console.log(call1);
console.log(call1 === call1.self);
console.log(call1.super);


var input = [1, 3, 2, 4, 5];
console.log('Before: ' + input);
(function (input) {
    console.log("In function: " + input.sort(function (val1, val2) {
        return val2 - val1;
    }));
})(input);
console.log('After: ' + input);

function forEach(list, callback) {
    for (var n = 0; n < list.length; n++) {
        callback.call(list[n], n);
    }

}

var weapons = ['手裏剣', '刀', 'ぬんちゃく']

forEach(
    weapons,
    function(index) {
        console.log(weapons[index].split("").sort(function (val1, val2) {
            return val2.charCodeAt(0) - val1.charCodeAt(0);
        }).join('-'));
    }
);
