function log() {
    try {
        console.log.apply(console, arguments);
    } catch(e) {
        try {
            opera.postError.apply(opera, arguments);
        } catch(e) {
            alert(Array.prototype.join.call(arguments, " "));
        }
    }
}

(function() {
    _log = this.log;
    this.log = function log() {
        _log("Hello, Martian!");
    };
}());

log();