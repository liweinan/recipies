var library = {
    id: 1,
    store: {},
    add: function(fn) {
        if (!fn.id) {
            fn.id = library.id++;
            return !!(library.store[fn.id] = fn);
        }
    }
};

var fn = function() { console.log("fn"); };

library.add(fn);