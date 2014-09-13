{
    ultimate = 42;
}

console.log(ultimate);

function a() {
    function b() {
        function c() {
            console.log("c");
        };
        c();
    }
    b();
}

a();

var obj = {};

obj.foo = function() {
    console.log(this === obj); // this becomes obj
}

obj.foo();

function bar() {
    this.foo = "Martian";
    console.log(this);
}
var martian = new bar(); // To invoke the function as a constructor, we precede the function invocation with the new keyword.
console.log(martian.foo);