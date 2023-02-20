# Chapter 6 | Counting

## Basic Counting Principle

!!! theorem "Theorem | SUM RULE"
    Suppose that the tasks $T_1, T_2, \dots, T_k$ can be down in $n_1, n_2, \dots, n_m$ ways respectively and no two of these tasks can be down at the same time. Then the number of ways to do one of these tasks is

    $$
        n_1 + n_2 + \dots + n_k.
    $$

    Or, if $A_1, A_2, \dots, A_k$ are disjoint sets, then
    
    $$
        |A_1 \cup A_2 \cup \dots \cup A_k| = |A_1| + |A_2| + \dots + |A_k|.
    $$

!!! theorem "Theorem | PRODUCT RULE"
     Suppose that a procedure can be performed in $k$ succeessive steps, step $i$ can be done in $n_i$ ways. Then the number of different ways that the procedure can be is the product

    $$
        n_1 \cdot n_2 \cdot \cdots \cdot n_k.
    $$

    Or, if $A_1, A_2, \dots, A_k$ are finite sets, then

    $$
        |A_1 \times A_2 \times \cdots \times A_k| = |A_1| \cdot |A_2| \cdot \cdots \cdot |A_k|.
    $$

## Pigeonhole Principle

!!! theorem "Pigeonhole Principle"
    If $k + 1$ or more objects are placed into $k$ boxes then there is at least one box containing two or more of the objects.

!!! theorem "Generalized Pigeonhole Principle"
    If $N$ are placed into $k$ boxes then there is at least one box containing at least $\lceil N / k \rceil$ objects.

We give some elegant applications of this principle.

!!! example

    === "Example 1"

        Given $n + 1$ positive integers $a_i$ ($i = 1, \dots, n + 1$) and $a_i \le 2n$, show that $\exist\ i, j,\ \ \text{ s.t. } a_i \mid a_j$.

        **Solution.**

        Suppose $a_i = 2^{k_i} q_i$ for some $k_i$ and odd $q_i$.

        Then

        - the pigeonhole is $\{q_i\}_{i = 1}^{n}$, totally $n$ elements.
        - the pigeon is $\{a_i\}_{i = 1}^{n + 1}$, totally $n + 1$ elements.

        Thus $\exists\ i, j,\ \ \text{ s.t. } q_i = q_j$, and $a_i = 2^{k_i}q_i$, $a_j = 2^{k_j}q_j$. Without loss of generation, if $k_i < k_j$, then $a_i \mid a_j$.

    === "Example 2"

        !!! theorem
            Every sequence of $n^2 + 1$ distinct real numbers $\{a_i\}_{i = 1}^{n^2+1}$ contains a subsequence of length $n + 1$ that is either strictly increasing or strictly decreasing.
    
        !!! proof
            Define

            - $i_k$ by the length of the **longest** increasing subsequence starting at $a_k$.
            - $d_k$ by the length of the **longest** decreasing subsequence starting at $a_k$.

            First we prove that if $s \neq t$, then either $i_s \neq i_t$ or $d_s = d_t$.

            !!! plane ""
                Since $a_i$ are distinct, without loss of generation, for $s < t$ either $a_s < a_t$ or $a_s > a_t$.

                - If $a_s < a_t$, then $i_s > i_t$.
                - If $a_s > a_t$, then $d_s > d_t$.

            We prove the theorem by contradiction. Suppose that there are no increasing or decreasing subsequence of length $n + 1$, then we have

            $$
                1 \le i_k, d_k \le n, k = 1, \dots, n^2 + 1.
            $$

            Thus there are $n^2$ possible ordered pair $(i_k, d_k)$.

            Then

            - the pigeonhole is $\{(i_k, d_k)\}$, totally $n^2$ elements.
            - the pigeon is $\{a_i\}_{i = 1}^{n^2 + 1}$, totally $n^2 + 1$ elements.

            Thus $\exists\ s, t,\ \ \text{ s.t. } i_s = i_t, d_s = d_t$, which leads to a contradiction.
    
    === "Example 3"

        Let $x_1, \dots x_n$ be a sequence of integers, then there are some successive integers in the sequence s.t. their sum can be divied by $n$.

        **Solution.**

        Let $A_i = \sum\limits_{k = 1}^{i}x_k$.

        - If $\exists\ i$, s.t. $n \mid A_i$, then it's true.
        - If not, then $n \nmid A_i, i = 1, 2, \dots n$. Then
            
            - the pigeonhole is $[1]_n, \dots, [n - 1]_n$, totally $n - 1$ elements.
            - the pigeon is $\{A_i\}_{i = 1}^{n}$, totally $n$ elements.

            Thus $\exists\ i < j,\ \ \text{ s.t. } A_i \equiv A_j (\text{ mod } n)$. Thus $n \mid (A_j - A_i)$.

    === "Example 4"

        Every sequence $a_1, a_2, \dots, a_N$ ($N = 2^n$), where $a_i \in \{x_1, x_2, \dots, x_n\}$, contains a successive subsequence such that their product is a perfect square.

        **Solution.**

        Let $A_i$ = \prod_{k = 1}^{i} a_k$, then $A_i = \sum\limits_{k = 1}^{n} x_k^{\alpha_{ik}}$.

        - If $\exists\ i$, s.t. $A_i$ is a perfect square, then it's true.
        - If not, then $A_i$ are not perfect square. Suppose a bijection

            $$
                A_i \leftrightarrow (\alpha_{i1}, \dots, \alpha_{in}) \leftrightarrow (\alpha_{i1} (\text{ mod } 2), \dots, \alpha_{in} (\text{ mod } 2)).
            $$

            - the pigeonhole is $\{0, 1\} \times \{0, 1\} \times \cdots \times \{0, 1\} - (0, 0, \cdots, 0)$, totally $2^n - 1$ elements.
            - the pigeon is $\{A_i\}_{i = 1}^{2^n}$, totally $2^n$ elements.

            Thus $\exists\ i < j,\ \ \text{ s.t. }$ 

            $$
                \frac{A_j}{A_i} = x_1^{2k_1} x_2^{2k_2} \cdots x_n^{2k_n} = (x_1^{k_1} x_2^{k_2} \cdots x_n^{k_n})^2,
            $$

            which is a perfect square.
        
    === "Example 5"

        During 30 days, a baseball team plays at least $1$ game a day, but no more than $45$ games in total. Show that there must be a period of some number of consecutive adays during which the team ust play exactly $14$ games.
            
        **Solution.**

        Let $a_i$ be the number of games played on before the *i*th day. Then $a_1 < a_2 < \cdots < a_{30}$, and

        $$
            1 \le a_i \le 45,\ \ 15 \le a_i + 14 \le 59.
        $$

        Then

        - the pigeonhole is $1 \sim 59$, totally $59$ elements.
        - the pigeon is $\{a_i\}_{i = 1}^{30}, \{a_i + 14\}_{i = 1}^{30}$, totally $60$ elements.

        Thus $\exists\ i < j,\ \ \text{ s.t. } a_i = a_j + 14$.




## Permutations and Combinations

!!! definition
    Given a set of distinct object $X = \{x_1, \cdots, x_n\}$,

    - a **permutation** of $X$ is an order arrangement of $X$.
    - an **r-permutation** ($r \le n$) is an ordering of a subset of *r*-elements is denoted by $P(n, r)$. The number of *r*-permutations is denoted by $P(n, r)$.
    - an **r-combination** of $X$ is an unordered selection of $r$ elements. The number of *r*-combinations is denoted by $C(n, r)$.

!!! theorem

    $$
        P(n, r) = n(n - 1)\cdot(n - r + 1) = \frac{n!}{(n - r)!}.
    $$

    $$
        C(n, r) = \frac{n!}{r!(n - r)!} = \frac{P(n, r)}{r!}.
    $$

!!! theorem "Property"
    
    - $\sum\limits_{k = 0}^{n}C(n, k) = 2^n$.
    - **Pascal's Identity" $C(n + 1, k) = C(n, k) + C(n, k - 1)$.
    - **Vandermonde's Identity$ $C(m + n, r) = \sum\limits_{k = 0}^rC(m, r - k)C(n, k)$.

### Binomial Coefficients

!!! theorem "Theorem | Binomial Therorem"
    If $a$ and $b$ are eal numbers and $n$ is a positive integer, then

    $$
        (a + b)^n = C(n, 0)a^nb^0 + C(n, 1)a^{n - 1}b^1 + \cdots + C(n, n)a^0b^n.
    $$

## Generalized Permutations and Combinations

### Permutation with repetition

!!! theorem
    The number of *r*-permutations of a set of $n$ objects with repetition allowed is $n^r$.

### Combination with repetition

!!! theorem
    The umber of *r*-combination of a set with $n$ elements with repetition allowed is $C(n + r - 1, r)$.

!!! example

    === "Example 1"

        How many solutions in nonnegative integers are there to the equation $x_1 + x_2 + x_3 + x_4 = 29$, where $x_1 > 0, x_2 > 1, x_3 > 2, x_4 \ge 0$ ?

        **Solution.**

        $C(4 + 23 - 1, 23) = C(26, 23) = C(26, 3) = 2600$.

    === "Example 2"

        How many ways to place $2t + 1$ indistinguishable balls into $3$ distinguishable boxes such that the total number of balls in arbitrary two boxes is larger than the third one?

        **Solution.**

        $C(3 + 2t + 1 - 1, 2t + 1) - C(3, 1) \cdot C(3 + t - 1, t) = C(2t + 3, 2) - 3C(t + 2, 2)$.

!!! theorem
    The number of ways to distriute $n$ distinguishable objects into $K$ distinguishable boxes so that $n_i$ objects are placed into box $i$ equals

    $$
        \frac{n!}{n_1!n_2!\cdots n_k!}.
    $$

## Generating Permutations

!!! definition
    The permutaion $a_1 a_2 \cdots a_n$ **precedes** the permutation of $b_1 b_2 \cdots b_n$, if for some $k$, $a_1 = b_1, \cdots, a_{k - 1} = b_{k - 1}$ and $a_k < b_k$. It defines an order called $lexicographic order**.

!!! example
    The next permutaion in lexicographic order after $362541$ is $364125$.