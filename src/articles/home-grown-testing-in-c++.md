---
title: 'Home grown testing with C++'
---

Knowing the value of testing our code in development, I decided to implement a small testing utility in C++ to help me ensure my assignment works correctly, not only on my machine, but on the standard environment specified by the subject.

I started with a very naive implementation which took a function, an argument and an expected value.

```{.cpp}
template<typename TestedFunction, typename Arg, typename Expected>
bool test(TestedFunction f, Expected e, Arg a) {
    Expected observed = f(a);

    if (e != observed) {
        // a function defined elsewhere that just prints "FAIL" and shows the expected and observed;
        print_fail(e, observed);
        return false;
    }

    std::cout << "SUCCESS" << std::endl;
    return true;
}
```

This would be run something like `test(addOne, 2, 1)` and would return true if addOne was miraculously implemented correctly...

However very quickly I found myself needing to test a function that takes more than one argument and implemented an overload of `test` that takes two arguments. Just add another typename so the second argument can be of a different type to the first (something simple I missed the first time I attempted this) and another argument to the function and awaayyy we go.

```{.cpp}
template<typename TestedFunction, typename Expected, typename Arg1, typename Arg2>
bool test(TestedFunction f, Expected e, Arg1 a1, Arg2 a2) {
    Expected observed = f(a1, a2);

    if (e != observed) {
        print_fail(e, observed);
        return false;
    }

    std::cout << "SUCCESS" << std::endl;
    return true;
}
```

Of course, sooner or later, functions with 3 or more arguments (gross but possible) will come along and ruin our nice little testing picnic, so this clearly doesn't scale. So I went simpler, where it was just a function that compared two values of the same type.

```{.cpp}
template<typename Compare>
bool test(Compare observed, Compare expected) {

    if (expected != observed) {
        print_fail(expected, observed);
        return false;
    }

    std::cout << "SUCCESS" << std::endl;
    return true;
}
```
To run this test implementation it goes a little something like this: `test(addOne(1), 2)`.
Super simple, and handles any number of arguments! Surely this is as far as we go? Nope, I got greedy and implemented a version which takes a string as the first argument to print a test name.

```{.cpp}
template<typename TestName, typename Compare>
bool test(TestName name, Compare observed, Compare expected) {
    std::cout << name << std::endl;

    if (expected != observed) {
        print_fail(expected, observed);
        return false;
    }

    std::cout << "SUCCESS" << std::endl;
    return true;
}
```

However, this led to the sad revelation that any output from the function would be printed before the test name leading to confusion and much despair. So, a bit more googling and some learning about function pointers and variadic arguments in templates and we have our final testing implementation!

```{.cpp}
template<typename Compare>
bool isSame(Compare observed, Compare expected) {
    if (observed != expected) {
        print_fail(expected, observed);
        return false;
   };

    std::cout << "SUCCESS" << std::endl;
    return true;
}

template<typename ReturnType, typename... Args>
bool test(ReturnType expected, ReturnType(*f)(Args... args), Args... args) {
    return isSame(f(args...), expected);
}

template<typename TestName, typename ReturnType, typename... Args>
bool test(TestName name, ReturnType expected, ReturnType(*f)(Args... args), Args... args) {
    std::cout << name << std::endl;

    return isSame(f(args...), expected);
}
```

As you can see, the previous implementation has remained as a convenience function as not to rewrite the logic for comparing output to the expected value. However there are some new things here.

1. `ReturnType(*f)(Args...args)` This is a function pointer saying that a function, returning `ReturnType` and taking `Args...` is passed in, ensuring three things:
    * that it's a function passed in
    * that it returns the same type as the expected value passed in
    * that the function takes the arguments passed in

2. `Args...` this is the variadic arguments I was referring to before. It just describes that there will be an unknown number of arguments and we can refer to them all. In this case we can just apply them all (in order) to the function specified.
3. I rearranged the order of the arguments to `test` to make more sense:
    1. Optional test name
    2. Expected value
    3. Function to test
    4. Arguments to function
