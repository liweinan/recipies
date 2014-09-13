function outer() {
    console.log(typeof inner);
    function inner() {}
}

var mars = function planet() {
    console.log("This is Mars");
}

console.log(mars.name);

function planet() {
    console.log("This is Earth");
}

planet();
mars();
