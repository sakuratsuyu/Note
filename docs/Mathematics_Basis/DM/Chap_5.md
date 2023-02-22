# Chapter 5 | Induction and Recursion

## Mathematical Induction

**The Well-Ordering Property:** Every nonnegative integers has *a least element*.

!!! plane ""
    **The First Principle of Mathematical Induction**

    To prove by mathematical induction that $P(n)$ is true for every positive integer$n$,

    1. Basic Step. The proposition $P(1)$ is shown to be true.
    2. Inductive Step. The implication $P(n) \rightarrow P(n + 1)$ is shown to be true for every positive integer $n$.

!!! plane ""
    **The Second Principle of Mathematical Induction**

    1. Basic Step. The proposition $P(1)$ is shown to be true.
    2. Inductive Step. The implication $[P(1) \wedge P(2) \wedge \cdots \wedge P(n)] \rightarrow P(n + 1)$ is shown to be true for every positive integer $n$.

## Recursion

**Recursively Defined Functions**

!!! definition "Recursive or Inductive Definition"

    1. Specify the value of function at zero.
    2. Give a rule for finding its value as an integer from its values at smaller integers.

Moreover, we can use **recursion** to define **sets**, **algorithm** and so on.

!!! definition
    An algorithm is called **recursive** if it solves a problem by reducing it to an instance of the same problem with smaller input.