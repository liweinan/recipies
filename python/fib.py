def fib(x):
    if x < 3:
        return 1
    else:
        return fib(x - 1) + fib(x - 2)

print(fib(40))
