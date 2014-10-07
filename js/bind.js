function bind(context, other, name) {
    return function () {
        return context[name].apply(other, arguments);
    };
}

var foo = {
    click: function () {
        console.log("I'm " + this.name);
    }
}

foo.name = "foo";

var bar = { name: "bar" }
bind(foo, bar, "click")();
