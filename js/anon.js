(function () {
    console.log("Hello, Martian!")
})();

var myfunc = function () {
    console.log("I have no name");
}

console.log(myfunc.name);

var ninja = {
    shout: function() {
        console.log("にんじゃ！");
    }
};

ninja.shout();

setTimeout(ninja.shout, 500);