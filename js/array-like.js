
function smallest(array) {
    return Mavar elems = {
        length: 0,
        add: function (elem) {
            Array.prototype.push.call(this, elem);
        },
        gather: function (val) {
            this.add(val);
        }
    };

    elems.gather("first");
    elems.gather("second");

    console.log(elems);
    console.log(elems[0]);
    console.log(elems[1]);
    th.min.apply(Math, array);
}

smallest([0, 1, 2, 3]);
Math.min(0, 1, 2, 3);

function overload() {
    console.log(arguments);
}
overload();
overload(1);
overload(1, 2);
overload(1, 2, 3);

var ninjas = {
    values: ["Dean Edwards", "Sam Stephenson", "Alex Russell"]
};

function addMethod(object, name, fn) {
    var old = object[name];
    object[name] = function () {
        if (fn.length == arguments.length)
            return fn.apply(this, arguments)
        else if (typeof old == 'function')
            return old.apply(this, arguments);
        else
            console.log("no matching function");
    }
}

var ninja = {};
addMethod(ninja, 'say', function () {
    console.log("にんじゃ");
});

ninja.say();
ninja.say("手裏剣");

addMethod(ninja, 'say', function (input) {
    console.log(input);
});

ninja.say();
ninja.say("手裏剣");

addMethod(ninja, 'say', function (input, input2) {
    console.log(input, input2);
});
