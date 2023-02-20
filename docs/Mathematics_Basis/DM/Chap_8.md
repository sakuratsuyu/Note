# Chapter 8 | Advanced Counting Techniques

## Recurrence Relations

!!! definition
    A **recurrence relation** for a sequence $\{a_n\}$ is an equation that express $a_n$ in terms of one or more of the previous terms of the sequence.
    
    - A sequence is called a **solution** of recurrence relation if its term satisfy the recurrence relation.
    - A particular solution needs some **initial conditions**.

Actually, there are many recurrence relations that don't have a solution. But for some certain cases, we have some methods to obtain the solutions. Here we only focus the following form of recurrence relations:

!!! definition
    A **linear homogeneous recurrence relation of degree $k$ with constant coeffieients** is a recurrence relation of the form

    $$
        a_n  = c_1 a_{n - 1} + c_2 a_{n - 2} + \cdots + c_k a_{n - k},
    $$

    where $c_i \in \mathbb{R}$ and $c_k \neq 0$.

    ??? example
        - $a_n = a_{n - 1} + a_{n - 2}^2$ is not linear.
        - $a_n = 2a_{n - 1} + 1$ is not homogeneous.
        - $a_n = na_{n - 1}$ has no constant coefficients.

Now we discuss the solution for it. First we define **characteristic equation** by

$$
    r^k - c_1 r^{k - 1} - c_2 r^{k - 2} - \cdots - c_{k - 1} r - c_k = 0.
$$

and the roots $r_i$ are called the **characteristic roots**.

!!! plane ""
    **degree** $k = 2$

    !!! theorem
        Let $c_1$ and $c_2$ be real numbers. Suppose that the characteristic equation

        $$
            r^2 - c_1 r - c_2 = 0
        $$

        - has two **distinct** roots $r_1$ and $r_2$. Then the solution is of the form
            
            $$
                a_n = \alpha_1 r_1^n + \alpha_2 r_2^n,\ \ \text{ where $\alpha_1$ and $\alpha_2$ are constants}.
            $$
        
        - has **only one** root $r_0$. Then the solution is of the form

            $$
                a_n = \alpha_1 r_0^n + \alpha_2 n r_0^n,\ \ \text{ where $\alpha_1$ and $\alpha_2$ are constants}.
            $$
    
    ??? example

        === "distinct roots"

            Find the solution of $a_n = a_{n - 1} + 2a_{n - 2}$ with intial conditions $a_0 = 2$ and $a_1 = 7$.
        
            **Solution.**

            The charateristic equation is $r^2 - r - 2 = 0$ and the roots are $r = 2$ and $r = -1$. The general solution is

            $$
                a_n = \alpha_1 2^n + \alpha_2 (-1)^n.
            $$

            Substitue initial condition, we have $\alpha_1 = 3$ and $\alpha_2 = -1$.

            Thus the solution is $a_n = 3 \cdot 2^n - (-1)^n$.

        === "multiple roots"

            Find the solution of $a_n = 6a_{n - 1} - 9a_{n - 2}$ with intial conditions $a_0 = 1$ and $a_1 = 6$.
        
            **Solution.**

            The charateristic equation is $r^2 - 6r + 9 = 0$ and the root is $r = 1$. The general solution is

            $$
                a_n = \alpha_1 3^n + \alpha_2 n 3^n.
            $$

            Substitue initial condition, we have $\alpha_1 = 1$ and $\alpha_2 = 1$.

            Thus the solution is $a_n = 3^n + n \cdot 3^n$.

!!! plane ""
    **degree** $k$

    !!! theorem
        Let $c_1, \dots, c_k$ be real numbers. Suppose that the characteristic equation

        $$
            r^k - c_1 r^{k - 1} - c_2 r^{k - 2} - \cdots - c_{k - 1} r - c_k = 0.
        $$

        - has $k$ distinct roots $r_1, \dots, r_k$. Then the solution is of the form
            
            $$
                a_n = \alpha_1 r_1^n + \alpha_2 r_2^n + \cdots + \alpha_k r_k^n,\ \ \text{ where $\alpha_i$ are constants}.
            $$
        
        - has $t$ distinct roots $r_1, \dots, r_t$ with multiplicitiese $m_1, \dots, m_t$. Then the solution is of the form

            $$
            \begin{aligned}
                a_n &= (\alpha_{1, 0} + a_{1, 1}n + \cdots + \alpha_{1, m_1} n^{m_1 - 1}) r_1^n \\
                    &+ (\alpha_{2, 0} + a_{2, 1}n + \cdots + \alpha_{2, m_2} n^{m_2 - 1}) r_2^n \\
                    &+ \cdots \\
                    &+ (\alpha_{t, 0} + a_{t, 1}n + \cdots + \alpha_{t, m_t} n^{m_t - 1}) r_t^n \\
            \end{aligned}
            ,\ \ 
            \text{ where $\alpha_{ij}$ are constants}.
            $$

    ??? example

        === "distinct roots"

            Find the solution of $a_n = 6a_{n - 1} - 11a_{n - 2} + 6a_{n - 3}$ with intial conditions $a_0 = 2$, $a_1 = 5$ and $a_2 = 15$.
        
            **Solution.**

            The charateristic equation is $r^3 - 6r^2 + 11r - 6 = 0$ and the roots are $r = 1$, $r = 2$ and $r = 3$. The general solution is

            $$
                a_n = \alpha_1 \cdot 1^n + \alpha_2 \cdot 2^n + \alpha_3 \cdot 3^n.
            $$

            Substitue initial condition, we have $\alpha_1 = 1$, $\alpha_2 = -1$ and $\alpha_3 = 2$.

            Thus the solution is $a_n = 1 - 2^n + 2 \cdot 3^n$.

        === "multiple roots"

            Find the solution of $a_n = -3a_{n - 1} - 3a_{n - 2} - a_{n - 3}$ with intial conditions $a_0 = 1$, $a_1 = -2$ and $a_2 = -1$.
        
            **Solution.**

            The charateristic equation is $r^3 + 3r^2 + 3r + 1 = (r + 1)^3 = 0$ and the root is $r = -1$ of multiplicity $3$. The general solution is

            $$
                a_n = \alpha_{1, 0} (-1)^n + \alpha_{1, 1} n (-1)^n + \alpha_{1, 2} n^2 (-1)^n.
            $$

            Substitue initial condition, we have $\alpha_{1, 0} = 1$, $\alpha_{1, 1} = 3$ and $\alpha_{1, 2} = -2$.

            Thus the solution is $a_n = (1 + 3n - 2n^2)(-1)^n$.

Moreover, we can also consider the nonhomogeneous cases.

!!! definition
    A **linear nonhomogeneous recurrence relation of degree $k$ with constant coeffieients** is a recurrence relation of the form

    $$
        a_n  = c_1 a_{n - 1} + c_2 a_{n - 2} + \cdots + c_k a_{n - k} + F(n),
    $$

    where $c_i \in \mathbb{R}$ and $F(n) \not\equiv = 0$. And

    $$
        a_n  = c_1 a_{n - 1} + c_2 a_{n - 2} + \cdots + c_k a_{n - k}
    $$

    is called the **associated homogeneous recurrence relation**.

!!! theorem
    If $\{a_n^{(p)}\}$ is **particular solution** of the linear nonhomogeneous recurrence relation with constant coefficients

    $$
        a_n  = c_1 a_{n - 1} + c_2 a_{n - 2} + \cdots + c_k a_{n - k} + F(n),,
    $$

    then each solution is of the form $\{a_n^{(p)} + a_n^{(h)}\}$, where $a_n^{(h)}$ is a solution of the associated homogeneous recurrence relation

    $$
        a_n  = c_1 a_{n - 1} + c_2 a_{n - 2} + \cdots + c_k a_{n - k}.
    $$

??? example
    Find solutions of $a_n = 3a_{n - 1} + 2n$ with $a_1 = 3$.

    **Solution.**

    The associated linear homogeneous recurrence relation is $a_n = 3a_{n-1}$, whose solution is $a_n^{(h)} = \alpha \cdot 3^n$.

    It's reasonable to try $a_n^{(p)} = cn + d$ as a solution. Then from $a_n = 3a_{n - 1} + 2n$ we have

    $$
        cn + d = 3(c(n - 1) + d) + 2n,
    $$

    and thus $c = -1$ and $d = -\cfrac{3}{2}$.

    The general solution is

    $$
        a_n = a_n^{(p)} + a_n^{(h)} = -n - \frac{3}{2} + \alpha \cdot 3^n.
    $$

    Substitute $a_1 = 3$, we have $\alpha = \cfrac{11}{6}$. Thus

    $$
        a_n = a_n^{(p)} + a_n^{(h)} = -n - \frac{3}{2} + \frac{11}{6} \cdot 3^n.
    $$

Moreover, for specific forms of $F(n)$, we have the following theorem.

!!! theorem
    If $F(n) = (b_t n^t + b_{t - 1} n^{t - 1} + \cdots + b_1 n + b_0) s^n$, where $b_i, s \in \mathbb{R}$.

    - When $s$ is not a characteristic root of the associated linear homogeneous recurrence relation, there is a particular solution of the form

        $$
            a_n^{(p)} = (p_t n^t + p_{t - 1} n^{t - 1} + \cdots + p_1 n + p_0) s^n.
        $$

    - When $s$ is a characteristic root with multiplicity $m$, there is a particular solution of the form

        $$
            a_n^{(p)} = n^m (p_t n^t + p_{t - 1} n^{t - 1} + \cdots + p_1 n + p_0) s^n.
        $$

!!! example
    Consider $a_n = 6a_{n - 1} - 9a_{n - 2} + F(n)$. The charateristic root is $r = 3$ of multiplicity $2$.

    - If $F(n) = 3^n$, then $a_n^{(p)} = n^2 p_0 3^n$.
    - If $F(n) = n \cdot 3^n$, then $a_n^{(p)} = n^2(p_1 n + p_0) 3^n$.
    - If $F(n) = n^2 2^n$, then $a_n^{(p)} = (p_2 n^2 + p_1 n + p_0) 2^n$.
    - If $F(n) = (n^2 + 1) 3^n$, then $a_n^{(p)} = n^2 (p_2 n^2 + p_1 n + p_0) 3^n$.
    

## Generating Functions

!!! definition
    The **generating function** for the sequence $a_0, a_1, \dots$ is the infineite series

    $$
        G(x) = a_0 + a_1 x + \dots = \sum\limits_{k = 0}^{\infty} a_k x^k.
    $$

    For finite sequence, then

    $$
        G(x) = a_0 + a_1 x + \dots + a_n x^n = \sum\limits_{k = 0}^{n} a_k x^k.
    $$

!!! theorem "Property"
    Let $f(x) = \sum\limits_{k = 0}^{\infty}a_k x^k$ and $g(x) = \sum\limits_{k = 0}^{\infty}b_k x^k$.

    - $f(x) + g(x) = \sum\limits_{k = 0}^{\infty}(a_k + b_k) x^k$
    - $f(x) \cdot g(x) = \sum\limits_{k = 0}^{\infty}(\sum\limits_{j = 0}^k a_j b_{k - j}) x^k$
    - $\alpha f(x) = \sum\limits_{k = 0}^{\infty} \alpha a_k x^k$
    - $x f'(x) = \sum\limits_{k = 0}^{\infty} k a_k x^k$
    - $f(\alpha x) = \sum\limits_{k = 0}^{\infty} \alpha^k a_k x^k$

!!! definition
    For $u \in \mathbb{R}$ and $k \in \mathbb{N}^*$, the **extended binomial coefficient** is

    $$
        \binom{u}{k} = \left\{
            \begin{aligned}
                & \frac{1}{k!} u(u - 1)\cdots(u - k + 1), & k > 0 \\
                & 1, & k = 0.
            \end{aligned}
        \right.
    $$

    In particular, for $u = -n$,

    $$
        \binom{-n}{r} = (-1)^r \binom{n + r - 1}{r}.
    $$

!!! theorem "Theorem | Extended Binomial Theorem"
    If $x, u \in \mathbb{R}$ and $|x| < 1$, then

    $$
        (1 + x)^u = \sum\limits_{k = 0}^{\infty}\binom{u}{k}x^k.
    $$

<div align="center">
	<img src="../Pic/12.png" style="width:600px"/>
</div>

### Application

!!! example "Solve Recurrence Relations"
    Solve $a_n = 8a_{n - 1} + 10^{n - 1}$ with initial condition $a_1 = 9$.

    **Solution.**

    Let $G(x) = \sum\limits_{k = 0}^{\infty} a_k x^k$. Then

    $$
    \begin{aligned}
        G(x) - a_0 &= \sum\limits_{k = 1}^{\infty} a_k x^k = \sum\limits_{k = 1}^{\infty} (8 a_{k - 1} x^k + 10^{k - 1} x^k) \\
                   &= 8 \sum\limits_{k = 1}^{\infty} a_{k - 1} x^k + \sum\limits_{k = 1}^{\infty} 10^{k - 1} x^k \\
                   &= 8 x\sum\limits_{k = 1}^{\infty} a_{k - 1} x^{k - 1} + x \sum\limits_{k = 1}^{\infty} 10^{k - 1} x^{k - 1} \\
                   &= 8 x\sum\limits_{k = 0}^{\infty} a_{k - 1} x^k + x \sum\limits_{k = 0}^{\infty} 10^{k - 1} x^k \\
                   &= 8 G(x) + \frac{x}{1 - 10x}.
    \end{aligned}
    $$

    Thus
    
    $$
    \begin{aligned}
        G(x) &= \frac{1 - 9x}{(1 - 8x)(1 - 10x)} = \frac{1}{2}\left(\frac{1}{1 - 8x} + \frac{1}{1 - 10x}\right) \\
             &= \sum\limits_{l = 0}^{\infty} \frac{1}{2} \left(8^k + 10^k\right) x^k
    \end{aligned}
    $$

    Therefore

    $$
        a_k = \frac{1}{2} \left(8^k + 10^k\right).
    $$

!!! example "Combination"

    - Find $C(n, k)$.

        $$
            G(x) = (1 + x)^n = \sum\limits_{k = 0}^n C(n, k) x^k.
        $$

    - Find $C(n + r - 1, r)$.

        $$
        \begin{aligned}
            G(x) &= (1 + x + x^2 + x^3 + \cdots)^n = \frac{1}{(1 - x)^n} = (1 + (-x))^{-n} \\
                 &= \sum\limits_{r = 0}^{\infty}\binom{-n}{r}(-x)^r = \sum\limits_{r = 0}^{\infty}\binom{-n}{r}(-1)^r x^r \\
                 &= \sum\limits_{r = 0}^{\infty}(-1)^r C(n + r - 1, r) (-1)^r x^r \\
                 &= \sum\limits_{r = 0}^{\infty}C(n + r - 1, r) x^r
        \end{aligned}
        $$
    
    ??? example
        Find the number of solution of

        $$
            x_1 + x_2 + x_3 = 17
        $$
        
        where $x_1, x_2, x_3 \in \mathbb{N}$ with $2 \le x_1 \le 5$, $3 \le x_2 \le 6$ and $4 \le x_3 \le 7$.

        **Solution.**

        It's the same to find the coefficient of $x^{17}$ in the expansion of

        $$
            G(x) = (x^2 + x^3 + x^4 + x^5)(x^3 + x^4 + x^5 + x^6)(x^4 + x^5 + x^6 + x^7).
        $$

        Thus the answer is $3$.

!!! example "Permutation"

    !!! definition
        The **exponential generating function** for $\{a_n\}$ is $\sum\limits_{n = 0}^{\infty} \cfrac{a_n}{n!}x^n$.
    
    !!! example
        How many different strings with four characaters can be formed from four $A$, two $B$, two $C$, two $D$, two $E$ and one $F$, one $G$, one $H$?

        **Solution.**

        It's the same to find the coefficient of $\cfrac{x^{4}}{4!}$ in the expansion of

        $$
            G(x) = \left(1 + \frac{x}{1!} + \frac{x^2}{2!} + \frac{x^3}{3!} + \frac{x^4}{4!}\right)\left(1 + \frac{x}{1!} + \frac{x^2}{2!}\right)^4 \left(1 + \frac{x}{1!}\right)^3.
        $$

        Thus the answer is $3029$.
    

    ??? example
        How many different strings with length $r$ made from digits $1, 3, 5, 7, 9$ are there which contain even $3$s and even $7$s?

        **Solution.**

        $$
            G(x) = \left(1 + \frac{x^2}{2!} + \frac{x^4}{4!} + \cdots\right)^2 \left(1 + \frac{x}{1!} + \frac{x^2}{2!} + \frac{x^3}{3!} + \cdots\right)^3
        $$

        Notice that $e^x + e^{-x} = 2 \left(1 + \cfrac{x^2}{2!} + \cfrac{x^4}{4!} + \cdots \right)$, hence

        $$
        \begin{aligned}
            G(x) &= \left(\frac{e^x + e^{-x}}{2}\right)^2 \cdot (e^x)^3 = \frac{1}{4}(e^{5x} + 2e^{3x} + e^{x}) \\
                 &= \frac{1}{4}\left(\sum\limits_{r = 0}^{\infty}5^r \frac{x^r}{r!} + 2 \sum\limits_{r = 0}^{\infty}3^r \frac{x^r}{r!} + \sum\limits_{r = 0}^{\infty} \frac{x^r}{r!}\right) \\
                 &= \sum\limits_{r = 0}^{\infty} \left(\frac{1}{4} \cdot 5^r + \frac{1}{2} \cdot 3^r\right) \frac{x^r}{r!}.
        \end{aligned}
        $$

        Thus the answer is $\frac{1}{4} \cdot 5^r + \frac{1}{2} \cdot 3^r$.

## Principle of Inclusion-Exclusion

Recall principle of inclusion-exclusion

$$
    \left|\bigcup_{i = 1}^nA_i\right| = \sum_{i = 1}^n|A_i| - \sum_{1 \le i \ne j \le n} |A_i \cap A_j| + \cdots + (-1)^{n-1}\left|\bigcap_{i = 1]}^n A_i\right|.
$$

!!! plane ""
    **An Alternative Form**
    
    Suppose $A_i \{x | x \text{ has property } P_i\}$, and

    $$
        \small
        N(P_{i_1} \dots P_{i_k}) = |\{x | x \text{ has all the properties } P_{i_1}, \dots, P_{i_k}\}| = \left|\bigcap_{i = 1}^nA_i\right|.
    $$

    $$
        \small
        N(P_{i_1}' \dots P_{i_k}') = |\{x | x \text{ has none of the properties } P_{i_1}, \dots, P_{i_k}\}| = N - \left|\bigcup_{i = 1]}^n A_i\right|.
    $$

!!! example
    How many solution does

    $$
        x_1 + x_2 + x_3 = 11
    $$

    have, where $x_i \in \mathbb{N}$ with $x_1 \le 3$, $x_2 \le 4$ and $x_3 \le 6$?

    **Solution.**

    Let $P_1 : x_1 > 3$, $P_2 : x_2 > 4$ and $P_3 : x_3 > 6$. The answer is

    $$
    \small
    \begin{aligned}
        N(P_1' P_2' P_3') &= N - N(P_1) - N(P_2) - N(P_3) \\
                          &+ N(P_1 P_2) + N(P_1 P_3) + N(P_2 P_3) - N(P_1 P_2 P_3).
    \end{aligned}
    $$

    We have

    $$
    \small
    \begin{aligned}
        & N = C(3 + 11 - 1, 11) = 78, \\
        & N(P_1) = C(3 + 7 - 1, 7) = 36, N(P_2) = C(3 + 6 - 1, 6) = 28, \\
        & N(P_3) = C(3 + 4 - 1, 4) = 15, \\
        & N(P_1 P_2) = C(3 + 2 - 1, 2) = 6, N(P_1 P_3) = N(P_2 P_3) = N(P_1 P_2 P_3) = 0.
    \end{aligned}
    $$

    Thus

    $$
        N(P_1' P_2' P_3') = 6.
    $$

!!! example
    How many **onto functions** are there from a set of $6$ elements to a set of $3$ elements?

    **Solution.**

    Suppose codomain = $\{b_1, b_2, b_3\}$. Let $P_i$ be the property that $b_i$ are not in the range of the function. Then a function is onto iff it has none of properties $P_1$, $P_2$ or $P_3$.

    The answer is

    $$
    \small
    \begin{aligned}
        N(P_1' P_2' P_3') &= N - N(P_1) - N(P_2) - N(P_3) \\
                          &+ N(P_1 P_2) + N(P_1 P_3) + N(P_2 P_3) - N(P_1 P_2 P_3).
    \end{aligned}
    $$

    We have

    $$
    \small
    \begin{aligned}
        & N = 3^6, \\
        & N(P_i) = 2^6 \\
        & N(P_i P_j) = 1^6, \\
        & N(P_1 P_2 P_3) = 0.
    \end{aligned}
    $$

    Thus

    $$
        N(P_1' P_2' P_3') = 3^6 - C(3, 1) 2^6 + C(3, 2) 1^6 = 540.
    $$

    !!! theorem
        There are

        $$
            \small
            n^m - \binom{n}{1} (n - 1)^m + \cdots + (-1)^{n - 1} \binom{n}{n - 1} \cdot 1^m = \sum\limits_{k = 0}^{n - 1}(-1)^k \binom{n}{k} (n - k)^m
        $$ 

        onto functions from a set with $m$ elements to a set with $n$ elements, where $m, n \in \mathbb{N}^*$.
