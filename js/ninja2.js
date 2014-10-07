function Ninja() {
    var feints = 0;

    this.getFeints = function () {
        return feints;
    };

    this.feint = function () {
        feints++;
    };
}

var ninja = new Ninja();

ninja.feint();

console.log(ninja.getFeints());