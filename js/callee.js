function caller() {
    console.log(this);
    console.log(arguments.callee);
    console.log(this === arguments.callee);
}