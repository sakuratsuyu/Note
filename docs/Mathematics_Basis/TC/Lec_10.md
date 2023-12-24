# Lecture 10

## Numerical Functions

!!! definition

    A Turing machine $M$ **computes** $f: \mathbb{N}^K \rightarrow \mathbb{N}$ if $\forall n_1, \dots, n_k \in \mathbb{N}$,

    $$
        M(\text{bin}(n_1), \text{bin}(n_2), \dots, \text{bin}(n_k)) = \text{bin}(f(n_1, \dots, n_k)),
    $$

    where $\text{bin}(x)$ is the binary encoding of $x$.

    And we say $f$ is **computable**.

## Primitive Recursive Function

### Basic Functions

1. zero function

    $$
        \text{zero}(n_1, \dots, n_k) = 0.
    $$

2. identity function

    $$
        \text{id}_{k, j}(n_1, \dots, n_k) = n_j.
    $$

3. successor function

    $$
        \text{succ}(n) = n + 1.
    $$

!!! theorem

    Basic functions are computable.

### Composition

If we have a computable function $g: \mathbb{N}^k \rightarrow \mathbb{N}$ and several computable functions $h_1, \dots, h_k: \mathbb{N}^l \rightarrow \mathbb{N}$. The way to contruct the following function $f: \mathbb{N}^l \rightarrow \mathbb{N}$ is called **composition**.

$$
    f(n_1, \dots, n_l) = g(h_1(n_1, \dots, n_l), \dots, h_k(n_1, \dots, n_l)).
$$

### Recursive Definition

If we have two computable functions $g: \mathbb{N}^k \rightarrow \mathbb{N}$ and $h: \mathbb{N}^{k + 2} \rightarrow \mathbb{N}$. The way to contruct the following function $f: \mathbb{N}^{k + 1} \rightarrow \mathbb{N}$ is called **recursive definition**.

- $f(n_1, \dots, n_k, 0) = g(n_1, \dots, n_k)$.
- $\forall t \in \mathbb{N}$, $f(n_1, \dots, n_k, t + 1) = h(n_1, \dots, n_k, t, f(n_1, \dots, n_k, t))$.

!!! example

    A typical recursive function is factorial: $f(0) = 1$ and $f(n + 1) = (n + 1)f(n)$. In this case, we have

    - $k = 0$.
    - $g(n) = 1$.
    - $h(n, f(n)) = (n + 1)f(n)$.

!!! definition

    **Primitive recursive functions** are the **basic functions** and those obtained from the **basic functions** by applying **composition** and **recursive definition** a finite number of times.

!!! theorem

    Primitive recursive functions are computable.

!!! definition

    If the output of the primitive recursive function is either 0 or 1, then it's called a **predicate**.

!!! theorem

    If $g$, $h$ are primitive recursive and $p$ is a predicate, then

    $$
        f(n_1, \dots, n_k) = \left\{\begin{aligned}
            g(n_1, \dots, n_k), & \text{ if } p(n_1, \dots,n _k), \\
            h(n_1, \dots, n_k), & \text{ otherwise }.
        \end{aligned}\right.
    $$

    is also primitive recursive.

Here we give some examples of primitive recursive functions.

!!! example

    1. $\text{plus2}(n) = n + 2$

        $$
            \text{succ}(\text{succ}(n))
        $$
    
    2. $\text{plus}(m, n) = m + n$

        $$
        \left\{
        \begin{aligned}
            \text{plus}(m, 0) &= m = \text{id}_{1, 1}(m), \\
            \text{plus}(m, n + 1) &= \text{plus}(m, n) + 1 = \text{succ}(\text{plus(m, n)}).
        \end{aligned}
        \right.
        $$

        !!! plane ""
            But it's not strict enough actually. The following is the a stricter version. Since it's trivial, we needn't actually expand it commonly.

            $$
            \left\{
            \begin{aligned}
                \text{plus}(m, 0) &= m = \text{id}_{1, 1}(m), \\
                \text{plus}(m, n + 1) &= \text{succ}(\text{plus(m, n)}) = h(m, n, \text{plus}(m, n)).
            \end{aligned}
            \right.
            $$

            where

            $$
                h(m, n, \text{plus}(m, n)) = \text{succ}(\text{id}_{3,3}(m, n, \text{plus}(m, n))).
            $$
    
    3. $\text{mult}(m, n) = m \cdot n$

        $$
        \left\{
        \begin{aligned}
            \text{mult}(m, 0) &= 0 = \text{zero}(m), \\
            \text{mult}(m, n + 1) &= \text{mult}(m, n) + m = \text{plus}(\text{mult(m, n)}, m).
        \end{aligned}
        \right.
        $$
    
    4. $\text{exp}(m, n) = m^n$

        $$
        \left\{
        \begin{aligned}
            \text{exp}(m, 0) &= 1 = \text{succ}(\text{zero}(m)), \\
            \text{exp}(m, n + 1) &= \text{exp}(m, n) \cdot m = \text{mult}(\text{exp(m, n)}, m).
        \end{aligned}
        \right.
        $$

    5. constant function: $f(n_1, \dots, n_k) = c$

        $$
            \underbrace{\text{succ}(\dots(\text{succ}}_{c \text{ times}}(\text{zero}(n_1, \dots, n_k)) \dots )
        $$

    6. positive / sign function: $\text{positive}(n) = \text{sgn}(n) = \left\{\begin{aligned}
        1, n > 0, \\ 0, n = 0.
    \end{aligned}\right.$

        $$
        \left\{
        \begin{aligned}
            \text{sgn}(0) &= 0, \\
            \text{sgn}(n + 1) &= 1.
        \end{aligned}
        \right.
        $$
    
    7. predecessor function: $\text{pred}(n) = \left\{\begin{aligned}
        &n - 1, &n > 0, \\ &0, &n = 0.
    \end{aligned}\right.$

        $$
        \left\{
        \begin{aligned}
            \text{pred}(0) &= 0, \\
            \text{pred}(n + 1) &= n = \text{id}_{2, 1}(n, \text{pred}(n)) = n.
        \end{aligned}
        \right.
        $$

    8. non-negative substraction $m \sim n = \max(m - n, 0)$

        $$
        \left\{
        \begin{aligned}
            m \sim 0 &= m, \\
            m \sim (n + 1) &= (m \sim n) \sim 1 = \text{pred}(m \sim n).
        \end{aligned}
        \right.
        $$

    9. $\text{iszero}(n) = \left\{\begin{aligned}
        &1, &n = 0, \\ &0, &n > 0.
    \end{aligned}\right.$

        $$
            1 \sim \text{positive}(n)
        $$
    
    10. $\text{geq}(m, n) = \left\{\begin{aligned}
        &1, &m \ge n, \\ &0, &m < n.
    \end{aligned}\right.$

        $$
            \text{iszero}(n \sim m)
        $$
    
    11. $\text{eq}(m, n) = \left\{\begin{aligned}
        &1, &m = n, \\ &0, &m \neq n.
    \end{aligned}\right.$

        $$
            \text{geq}(m, n) \cdot \text{geq}(n, m)
        $$
    
    12. $\text{rem}(m, n) = m\ \%\ n$.

        $$
        \left\{
        \begin{aligned}
            \text{rem}(0, n) &= 0, \\
            \text{rem}(m + 1, n) &= \left\{\begin{aligned}
                & 0, && \text{if $m + 1$ is divisible by $n$}, \\
                & \text{rem}(m, n), && \text{otherwise}.
            \end{aligned}\right.
        \end{aligned}
        \right.
        $$

        where $m + 1 \text{ is divisible by } n \Leftrightarrow \text{eq}(\text{rem}(m, n), \text{pred}(n))$.

    13. $\text{div}(m, n) = \lfloor m / n \rfloor$. ($n \neq 0$)

        $$
        \left\{
        \begin{aligned}
            \text{div}(0, n) &= 0, \\
            \text{div}(m + 1, n) &= \left\{\begin{aligned}
                & \text{div}(m, n) + 1, && \text{if $m + 1$ is divisible by $n$}, \\
                & \text{div}(m, n), && \text{otherwise}.
            \end{aligned}\right.
        \end{aligned}
        \right.
        $$
    
    14. $\text{digit}(m, n, p) = a_{m - 1}$.

        $$
            \text{div}(\text{rem}(n, p^m), p^{m - 1})
        $$

    15. $\text{sum}_f(m, n) = \sum\limits_{k = 0}^{n} f(m, k)$, where $f$ is primitive recursive.

        $$
        \left\{
        \begin{aligned}
            \text{sum}_f(m, 0) &= f(m, 0), \\
            \text{sum}_f(m, n + 1) &= \text{sum}_f(m, n) + f(m, \text{succ}(n)).
        \end{aligned}
        \right.
        $$
    
        !!! failure "Wrong Consideration"

            $$
                \text{sum}_f(m, n) = \underbrace{f(m, 0) + f(m, 1) + \dots + f(m, n)}_{n \text{ times}}
            $$

            Notice that the theorem that sum of two primitive recursive functions is primitive recursive can not induce that sum of $n$ primitive recursive function is primitive recursive, when $n$ is a variable and is an input of the function.

    16. $\text{mult}_f(m, n) = \prod\limits_{k = 0}^{n} f(m, k)$, where $f$ is primitive recursive.

        $$
        \left\{
        \begin{aligned}
            \text{mult}_f(m, 0) &= f(m, 0), \\
            \text{mult}_f(m, n + 1) &= \text{mult}_f(m, n) \cdot f(m, \text{succ}(n)).
        \end{aligned}
        \right.
        $$

    17. $g_p(n) = \left\{\begin{aligned}
        &1, && \text{if } \exists n' \le n, p(n') = 1 , \\ &0, &&\text{otherwise}.
    \end{aligned}\right.$, where $p$ is a predicate.

        $$
            g_p(n) = p(0) \vee p(1) \vee \dots \vee p(n) = \text{positive} \left(\sum_{n'=0}^n p(n')\right) = \text{positive}(\text{sum}_p(n))
        $$

    !!! note

        If $p$ and $q$ are predicates, then

        $$
        \begin{aligned}
            p \wedge q &= p \cdot q \\
            p \vee q &= 1 \sim \text{iszero}(p + q)
        \end{aligned}
        $$

## Computability

Suppose we define

$$
\begin{aligned}
\text{PR} &= \{\langle f\rangle | f \text{ is a primitive recursive numerical function}\}, \\
\text{C} &= \{\langle f\rangle | f \text{ is a computable numerical function}\}.
\end{aligned}
$$

!!! theorem "Lemma"

    $\text{PR}$ is decidable.

!!! theorem "Lemma"

    $\text{C}$ is undecidable.

!!! proof

    Assume that $C$ is decidable. Then $\text{C} = \{\langle f\rangle | f \text{ is a unary computable numerical function}\} \subseteq C$ is also decidable.

    Then $C'$ is lexicographically Turing enumerable. Thus we can enumerate $C'$ by

    $$
        g_1, g_2, g_3, \dots
    $$

    Now we construct a TM $M$ = on input $n$,

    1. enumerate $C'$ to get $g_n$.
    2. compute $g_n(n)$.
    3. output $g_n(n) + 1$.

    Then $g^*(n) = g_n(n) + 1$ is unary computable numerical function and thus $g^* \in C'$.

    However, $\forall n \in \mathbb{N}$, $g^* \neq g_n$, which leads to a contradiction.

So we can conclude that

$$
    \text{PR} \subsetneq \text{C}
$$

That's not good since all computable function can't build up by that simple functions!

But now we consider add an additional operation of the primitive recursive function: **minimalization**.

## Minimalization

!!! definition

    Suppose $g: \mathbb{N}^{k + 1} \rightarrow \mathbb{N}$, and we define

    $$
        f(n_1, \dots, n_k) = \left\{
        \begin{aligned}
            & \text{minimum $n_{k + 1}$ such that $g(n_1, \dots, n_k, n_{k + 1}) = 1$}, && \text{if such that $n_{k + 1}$ exists}. \\
            & 0, && \text{if such that $n_{k + 1}$ does not exist}.
        \end{aligned}    
        \right.
    $$

    Then we call $f$ is a **minimalization** of $g$, denoted by

    $$
        \mu_m [g(n_1, \dots, n_k, m) = 1].
    $$

!!! definition

    A function $g$ is **minimalizable** if $g$ is computable and $\forall n_1, \dots, n_k$, $\exists m \ge 0$, such that $g(n_1, \dots, n_k, m) = 1$.

!!! example

    $$
        \log(m, n) = \lceil \log_{m + 2} (n + 1) \rceil = \mu_p[\text{geq}((m + 2)^p, n + 1) = 1].
    $$

    This function is minimalizable.

!!! theorem

    If $g: \mathbb{N}^{k + 1} \rightarrow \mathbb{N}$ is minimalizable, then $\mu_m[g(n_1, \dots, n_k, m) = 1]$ is computable.

!!! theorem

    The problem that

    !!! plane ""
        Given a function $g$, is $g$ minimalizable?
    
    is **undecidable**.