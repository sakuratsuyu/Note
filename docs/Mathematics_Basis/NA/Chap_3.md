# Chapter 3 | Interpolation and Polynomial Approximation

## Lagrange Interpolation

Suppose we have function $y = f(x)$ with the given points $(x_0, y_0), (x_1, y_1), \dots, (x_n, y_n)$, and then construct a relatively simple approximating function $g(x) \approx f(x)$.

!!! theorem "Theorem 3.0"
    If $x_0, x_1, \dots, x_n$ are $n + 1$ distinct numbers and $f$ is a function with given values $f(x_0), \dots, f(x_n)$, then a **unique polynomial** $P(x)$ of degree *at most* $n$ exists with

    $$
        P(x_k) = f(x_k),\ \ \text{ for each } k = 0, 1, \dots, n,
    $$

    and

    $$
        P(x) = \sum\limits_{k = 0}^n f(x_k)L_{n, k}(x),
    $$

    where, for each $k = 0, 1, \dots, n$,

    $$
        L_{n, k}(x) = \prod\limits_{\substack{i = 0 \\ i \ne k}}^n \frac{(x - x_i)}{(x_k - x_i)}.
    $$

    $L_{n, k}(x)$ is called the ***n* th Lagrange interpolating polynomial**.

??? proof
    First we prove for the structure of function $L_{n, k}(x)$.

    From the definition of $P(x)$, $L_{n, k}(x)$ has the following properties.

    - $L_{n, k}(x_i) = 0$ when $i \ne k$.
    - $L_{n, k}(x_k) = 1$.

    To satisfy the first property, the numerator of $L_{n, k}(x)$ contains the term

    $$
        (x - x_0)(x - x_1) \cdots (x - x_{k - 1})(x - x_{k + 1}) \cdots (x - x_n) = \prod\limits_{\substack{i = 0 \\ i \ne k}}^n (x - x_i).
    $$

    To satisfy the second property, the denominator of $L_{n, k}(x)$ must be equal to the numerator at $x = x_k$, thus

    $$
    \begin{aligned}
        L_{n, k}(x) &= \frac{(x - x_0)(x - x_1) \cdots (x - x_{k - 1})(x - x_{k + 1}) \cdots (x - x_n)}{(x_k - x_0)(x - x_1) \cdots (x_k - x_{k - 1})(x_k - x_{k + 1}) \cdots (x_k - x_n)} 
        \\ &= \prod\limits_{\substack{i = 0 \\ i \ne k}}^n \frac{x - x_i}{x_k - x_i}.
    \end{aligned}
    $$

    <div align="center">
    	<img src="../imgs/chap3_0.png" alt="chap3_0 " style="width:600px"/>
    </div>

    For uniqueness, we prove by contradition. If not, suppose $P(x)$ and $Q(x)$ both satisfying the conditions, then $D(x) = P(x) - Q(x)$ is a polynomial of degree $\text{deg}(D(x)) \le n$, but $D(x)$ has $n + 1$ distinct roots $x_0, x_1, \dots, x_n$, which leads to a contradiction.

!!! theorem "Theorem 3.1"
    If $x_0, x_1, \dots, x_n$ are $n + 1$ distinct numbers in the interval $[a, b]$ and $f \in C^{n + 1}[a, b]$. $\forall x \in [a, b], \exists \xi \in [a, b], s.t.$

    $$
        f(x) = P(x) + \frac{f^{(n + 1)}(\xi)}{(n + 1)!}\prod\limits_{i = 0}^n (x - x_i),
    $$

    where $P(x)$ is the Lagrange interpolating polynomial. And

    $$
        R(x) = \frac{f^{(n + 1)}(\xi)}{(n + 1)!}\prod\limits_{i = 0}^n (x - x_i).
    $$

    is the **truncation error**.

??? proof
    Since $R(x) = f(x) - P(x)$ has at least $n + 1$ roots, thus

    $$
        R(x) = K(x)\prod\limits_{i = 0}^n (x - x_i).
    $$

    For a fixed $x \ne x_k$, define $g(t)$ in $[a, b]$ by

    $$
        g(t) = R(t) - K(x)\prod\limits_{i = 0}^n (t - x_i).
    $$

    Since $g(t)$ has $n + 2$ distinct roots $x, x_0, \dots, x_n$, by Generalized Rolle's Theorem, we have

    $$
        \exists\ \xi \in [a, b],\ s.t.\ g^{(n + 1)}(\xi) = 0.
    $$

    Namely,

    $$
        f^{(n + 1)}(\xi) - \underbrace{P^{n + 1}(\xi)}_{0} - K(x)(n + 1)! = 0.
    $$

    Thus 

    $$
        K(x) = \frac{f^{(n + 1)}(\xi)}{(n + 1)!},\ R(x) = \frac{f^{(n + 1)}(\xi)}{(n + 1)!}\prod\limits_{i = 0}^n (x - x_i).
    $$

??? example
    Suppose a table is to be prepared for the function $f(x) = e^x$ for $x$ in $[0, 1]$. Assume that each entry of the table is accurate up to 8 decimal places and the step size is $h$. What should $h$ be for linear interpolation to give an absolute error of at most $10^{-6}$?

    **Solution.**

    $$
    \begin{aligned}
        |f(x) - P(x)| &= \left|\frac{f^{(2)}(\xi)}{2!}(x - x_j)(x - x_{j + 1})\right| 
        \\ &= \left|\frac{e^\xi}{2}(x - kh)(x - (k + 1)h)\right| \le \frac{e}{2} \cdot \frac{h^2}{4} = \frac{eh^2}{8}.
    \end{aligned}
    $$

    Thus let $\dfrac{eh^2}{8} \le 10^{-6}$, we have $h \le 1.72 \times 10^{-3}$. To make $N = \dfrac{(1 - 0)}{h}$ an integer, we can simply choose $h = 0.001$.

??? note "Extrapolation"
    Suppose $a = \min\limits_i \{x_i\}$, $b = \max\limits_i \{x_i\}$. Interpolation estimates value $P(x)$, $x \in [a, b]$, while **Extrapolation** estimates value $P(x)$, $x \notin [a, b]$.
    
    - In genernal, interpolation is better than extrapolation.

### Neville's Method

**Motivation:** When we have more interpolating points, the original Lagrange interpolating method should *re-calculate* all $L_{n, k}$, which is not efficient.

!!! definition "Definition 3.0"
    Let $f$ be a function defined at $x_0, x_1, \dots, x_n$, and suppose that $m_1, \dots, m_k$ are $k$ distinct integers with $0 \le m_i \le n$ for each $i$. The Lagrange polynomial that agrees with $f(x)$ at the $k$ points denoted by $P_{m_1, m_2, \dots, m_k}(x)$.

    Thus $P(x) = P_{0, 1, \dots, n}(x)$, where $P(x)$ is the *n* th Lagrange polynomials that interpolate $f$ at $k + 1$ points $x_0, \dots, x_k$.

!!! theorem "Theorem 3.2"
    Let $f$ be a function defined at $x_0, x_1, \dots, x_n$, and $x_i \ne x_j$, then
    
    $$
        P(x) = \frac{(x - x_j)P_{0, 1, \dots, j - 1, j + 1, \dots k}(x) - (x - x_i)P_{0, 1, \dots, i - 1, i + 1, \dots k}(x)}{(x_i - x_j)}.
    $$

Denote that

$$
    Q_{i, j} = P_{i - j, i - j + 1, \dots, i - 1, i},
$$

then from **Theorem 3.2**, the interpolating polynomials can be generated **recursively**. 

<div align="center">
	<img src="../imgs/chap3_1.png" alt="chap3_1 " style="width:700px"/>
</div>

## Newton Interpolation

Differing from Langrange polynomials, we try to represent $P(x)$ by the following form:

$$
\begin{aligned}
    N(x) = &\ a_0 + a_1(x - x_0) + a_2(x - x_0)(x - x_1) + \cdots
    \\ & + a_n(x - x_0)(x - x_1) \cdots (x - x_{n - 1}).
\end{aligned}
$$

!!! definition "Definition 3.1"
    $f[x_i] = f(x_i)$ is the **zeroth divided difference** w.r.t. $x_i$.

    The ***k* th divided difference** w.r.t. $x_i, x_{i + 1}, x_{i + k}$ is defined recursively by

    $$
    \small
        f[x_i, x_{i + 1}, \dots, x_{i + k - 1}, x_{i + k}] = \frac{f[x_{i + 1}, x_{i + 2}, \dots, x_{i + k}] - f[x_i, x_{i + 1}, \dots, x_{i + k - 1}]}{x_{i + k} - x_i}.
    $$

Then we derive the **Newton's interpolatory divided-difference formula**

$$
    N(x) = f[x_0] + \sum\limits_{k = 1}^n f[x_0, x_1, \dots, x_k]\prod\limits_{i = 0}^{k - 1}(x - x_i).
$$

And the divided difference can be generated as below, which is similar to Neville's Method.

<div align="center">
	<img src="../imgs/chap3_2.png" alt="chap3_2 " style="width:700px"/>
</div>

!!! theorem "Theorem 3.3"
    If $x_0, x_1, \dots, x_n$ are $n + 1$ distinct numbers in the interval $[a, b]$ and $f \in C^{n + 1}[a, b]$. $\forall x \in [a, b], \exists \xi \in [a, b], s.t.$

    $$
        f(x) = N(x) + f[x, x_0, \dots, x_n]\prod\limits_{i = 0}^n (x - x_i).
    $$

    where $N(x)$ is the Newton's interpolatory divided-difference formula. And

    $$
        R(x) = f[x, x_0, \dots, x_n]\prod\limits_{i = 0}^n (x - x_i).
    $$

    is the **truncation error**.

??? proof
    By definition of divided difference, we have
    
    $$
    \left\{
    \begin{aligned}
        f(x) &= f[x_0] + (x - x_0)f[x, x_0], & \textbf{Eq.1} \\
        f[x, x_0] &= f[x_0, x_1] + (x - x_1)f[x, x_0, x_1], & \textbf{Eq.2} \\
        & \ \ \vdots \\
        f[x, x_0, \dots, x_{n - 1}] &= f[x_0, \dots, x_n] + (x - x_n)f[x, x_0, \dots, x_n]. & \textbf{Eq.n - 1}
    \end{aligned}
    \right.
    $$

    then compute

    $$
    \textbf{Eq.1} + (x - x_0) \times \textbf{Eq.2} + \cdots + (x - x_0) \cdots (x - x_{n - 1}) \times \textbf{Eq.n - 1}.
    $$

    i.e. 

    $$
        f(x) = N(x) + \underbrace{f[x, x_0, \dots, x_n]\prod\limits_{i = 0}^n (x - x_i)}_{R(x)}.
    $$

!!! note
    Since the uniqueness of *n*-th interpolating polynomial,

    - $N(x) \equiv P(x)$.
    - They have the same truncation error, which is

        $$
            f[x, x_0, \dots, x_n]\prod\limits_{i = 0}^n (x - x_i) = \frac{f^{(n + 1)}(\xi)}{(n + 1)!}\prod\limits_{i = 0}^n (x - x_i).
        $$


!!! theorem "Theorem 3.4"
    Suppose that $f \in C^n[a, b]$ and $x_0, x_1, \dots, x_n$ are distinct numbers in $[a, b]$. Then $\exists\ \xi \in (a, b)$, s.t.

    $$
        f[x_0, x_1, \dots, x_n] = \frac{f^{(n)}(\xi)}{n!}.
    $$

### Special Case: Equal Spacing

!!! definition "Definition 3.2"
    **Forward Difference** 

    $$
    \begin{aligned}
        \Delta f_i &= f_{i + 1} - f_i, \\
        \Delta^k f_i &= \Delta\left(\Delta^{k - 1} f_i \right) = \Delta^{k - 1}f_{i + 1} - \Delta^{k - 1}f_i.
    \end{aligned}
    $$

    **Backward Difference** 

    $$
    \begin{aligned}
        \nabla f_i &= f_i - f_{i - 1}, \\
        \nabla^k f_i &= \nabla\left(\nabla^{k - 1} f_i \right) = \nabla^{k - 1}f_i - \nabla^{k - 1}f_{i - 1}.
    \end{aligned}
    $$

??? theorem "Property of Forward / Backward Difference"
    
    - Linearity $\Delta (af(x) + bg(x)) = a \Delta f + b \Delta g$.
    - If $\text{deg}(f(x)) = m$, then

        $$
            \text{deg}\left(\Delta^kf(x)\right) = \left\{
            \begin{aligned}
                & m - k, & 0 \le k \le m, \\
                & 0, & k > m.
            \end{aligned}
            \right.
        $$
    
    - Decompose the recursive definition,

        $$
        \begin{aligned}
            \Delta^n f_k &= \sum\limits_{j = 0}^n (-1)^j \binom{n}{j} f_{n + k - j}, \\
            \nabla^n f_k &= \sum\limits_{j = 0}^n (-1)^{n - j} \binom{n}{j} f_{j + k - n}.
        \end{aligned}
        $$
    
    - Vice versa,

        $$
            f_{n + k} = \sum\limits_{j = 0}^n \binom{n}{j} \Delta^j f_k.
        $$

Suppose $x_0, x_1, \dots x_n$ are equally spaced, namely $x_i = x_0 + ih$. And let $x = x_0 + sh$, then $x - x_i = (s - i)h$. Thus

$$
\begin{aligned}
    N(x) &= f[x_0] + \sum\limits_{k = 1}^n s(s - 1) \cdots (s - k + 1) h^k f[x_0, x_1, \dots, x_k]
    \\ &= f[x_0] + \sum\limits_{k = 1}^n \binom{s}{k} k! h^k f[x_0, x_1, \dots, x_k]
\end{aligned}
$$

is called **Newton forward divided-difference formula**.

From mathematical induction, we can derive that

$$
    f[x_0, x_1, \dots, x_k] = \frac{1}{k!h^k}\Delta^k f(x_0).
$$

Thus we get the **Newton Forward-Difference Formula**

$$
    N(x) = f[x_0] + \sum\limits_{k = 1}^n \binom{s}{k} \Delta^k f(x_0).
$$

---

Inversely, $x = x_n + sh$, then $x - x_i = (s + n - i)h$, Thus

$$
\begin{aligned}
    N(x) &= f[x_n] + \sum\limits_{k = 1}^n s(s + 1) \cdots (s + k - 1) h^k f[x_n, x_{n - 1}, \dots, x_{n - k}]
    \\ &= f[x_n] + \sum\limits_{k = 1}^n (-1)^k \binom{-s}{k} k! h^k f[x_n, x_{n - 1}, \dots, x_{n - k}].
\end{aligned}
$$

is called **Newton backward divided-difference formula**.

From mathematical induction, we can derive that

$$
    f[x_n, x_{n - 1}, \dots, x_0] = \frac{1}{k!h^k}\nabla^k f(x_n).
$$

Thus we get the **Newton Backward-Difference Formula**

$$
    N(x) = f[x_n] + \sum\limits_{k = 1}^n (-1)^k \binom{-s}{k} \nabla^k f(x_n).
$$

## Hermit Interpolation

!!! definition "Definition 3.3"
    Let $x_0, x_1, \dots, x_n$ be $n + 1$ distinct numbers in $[a, b]$ and $m_i \in \mathbb{N}$. Suppose that $f \in C^m[a, b]$, where $m = \max \{m_i\}$. The **osculating polynomial** approximating $f$ is the polynomial $P(x)$ of *least* degree such that

    $$
        \frac{d^k P(x_i)}{dx^k} = \frac{d^k f(x_i)}{dx^k}, \text{ for each } i = 0, 1, \dots, n \text{ and } k = 0, 1, \dots, m_i.
    $$

From definition above, we know that when $m_i = 0$ for each $i$, it's the *n*-th Lagrange polynomial. And the cases that $m_i = 1$ for each $i$, then it's **Hermit Polynomials**.

!!! theorem "Theorem 3.5"
    If $f \in C^1[a, b]$ and $x_0, \dots, x_n \in [a, b]$ are distinct, the unique polynomial of least degree agreeing with $f$ and $f'$ at $x_0, \dots, x_n$ is the **Hermit Polynomial** of degree *at most* $\bf 2n + 1$ defined by
    
    $$
        H_{2n + 1}(x) = \sum\limits_{j = 0}^n f(x_j) H_{n ,j}(x) + \sum\limits_{j = 0}^n f'(x_j) \hat H_{n, j}(x),
    $$

    where

    $$
        H_{n, j}(x) = [1 - 2(x - x_j)L'_{n, j}(x_j)]L^2_{n, j}(x),
    $$

    and

    $$
        \hat H_{n, j}(x) = (x - x_j)L^2_{n, j}(x).
    $$

    Moreover, if $f \in C^{2n + 2}[a, b]$, then $\exists\ \xi \in (a, b)$, s.t.

    $$
        f(x) = H_{2n + 1}(x) + \underbrace{\frac{1}{(2n + 2)!}\prod\limits_{i = 0}^n (x - x_i)^2 f^{2n + 2}(\xi)}_{R(x)}.
    $$

The theorem above gives a complete description of Hermit interpolation. But in pratice, to compute $H_{2n + 1}(x)$ through the formula above is *tedious*. To make it compute easier, we introduce a method that is similar to Newton's interpolation.

Define the sequence $\{z_k\}_{0}^{2n + 1}$ by

$$
    z_{2i} = z_{2i + 1} = x_i.
$$

Based on the **Theorem 3.4**, we redefine that 

$$
    f[z_{2i}, z_{2i + 1}] = f'(z_{2i}) = f'(x_i).
$$

Then Hermite polynomial can be represented by

$$
    H_{2n + 1}(x) = f[z_0] + \sum\limits_{k = 1}^{2n + 1} f[z_0, \dots, z_k]\prod\limits_{i = 0}^{k - 1}(x - z_i).
$$

<div align="center">
	<img src="../imgs/chap3_3.png" alt="chap3_3 " style="width:800px"/>
</div>

## Cubic Spline Interpolation

**Motivation:** For osculating polynomial approximation, we can let $m_i$ be bigger to get high-degree polynomials. It can somehow be better but higher degree tends to causes a *fluctuation* or say *overfitting*.

An alternative approach is to divide the interval into subintervals and approximate them respectively, which is called **piecewise-polynomial approximation**. The most common piecewise-polynomial approximation uses cubic polynomials called **cubic spline approximation**.

!!! definition "Definition 3.4"
    Given a function $f$ defined on $[a, b]$ and a set of nodes $a = x_0 < x_1 < \cdots < x_n = b$, a **cubic spline interpolant** $S$ for $f$ is a function that satisfies the following conditions.

    - $S(x)$ is a cubic polynomial, denoted $S_j(x)$, on the subinterval $[x_j, x_j + 1]$, for each $j = 0, 1, \dots, n - 1$;
    - $S(x_j) = f(x_j)$ for each $j = 0, 1, \dots, n$;
    - $S_{j + 1}(x_{j + 1}) = S_j(x_{j + 1})$ for each $j = 0, 1, \dots, n - 2$;
    - $S'_{j + 1}(x_{j + 1}) = S'_j(x_{j + 1})$ for each $j = 0, 1, \dots, n - 2$;
    - $S''_{j + 1}(x_{j + 1}) = S''_j(x_{j + 1})$ for each $j = 0, 1, \dots, n - 2$;
    - One of the following sets of boundary conditions:
        - $S''(x_0) = S''(x_n) = 0$ (**free or natural boundary**);
        - $S'(x_0) = f'(x_0)$ and $S'(x_n) = f'(x_n)$ (**clamped boundary**).

    The spline of natural boundary is called **natural spline**. 

!!! theorem "Theorem 3.6"
    The cubic spline interpolation of either natural boundary or clamped boundary is **unique**.

    (Since the coefficient matrix $A$ is strictly diagonally dominant.)

Suppose interpolation function in each subinterval is

$$
    S_j(x) = a_j + b_j(x - x_j) + c_j(x - x_j)^2 + d_j(x - x_j)^3.
$$

From the conditions in the definition above, by some algebraic process, we can derive the solution with the following equations,

$$
\begin{aligned}
    h_j &= x_{j + 1} - x_j; \\
    a_j &= f(x_j); \\
    b_j &= \frac{1}{h_j}(a_{j + 1}) - \frac{h_j}{3}(2c_j + c_{j + 1}); \\
    d_j &= \frac{1}{3h_j}{c_{j + 1} - c_j}.
\end{aligned}
$$

While $c_j$ is given by solving the following linear system,

$$
    A\mathbf{x} = \mathbf{b},
$$

where

$$
\small
A = 
\begin{bmatrix}
    1 & 0 & 0 & \cdots & \cdots & 0 \\
    h_0 & 2(h_0 + h_1) & h_1 & \cdots & \cdots & \vdots \\
    0 & h_1 & 2(h_1 + h_2) & h_2 & \ddots & \vdots \\
    \vdots & \ddots & \ddots & \ddots & \ddots & 0 \\
    \vdots & \ddots & \ddots & h_{n - 2} & 2(h_{n - 2} + h_{n - 1}) & h_{n - 1} \\
    0 & \cdots & \cdots & 0 & 0 & 1 \\
\end{bmatrix}
,
\mathbf{x} = 
\begin{bmatrix}
    c_0 \\ c_1 \\ \vdots \\ c_n
\end{bmatrix}
$$

For natural boundary,

$$
\small
\mathbf{b} = 
\begin{bmatrix}
    0 \\
    \frac{3}{h_1}(a_2 - a_1) - \frac{3}{h_0}(a_1 - a_0) \\
    \vdots \\
    \frac{3}{h_{n - 1}}\ (a_n - a_{n - 1}) - \frac{3}{h_{n - 2}}\ (a_{n - 1} - a_{n - 2}) \\
    0
\end{bmatrix}.
$$

For clamped boundary,

$$
\small
\mathbf{b} = 
\begin{bmatrix}
    \frac{3}{h_0}(a_1 - a_0) - 3f'(a) \\
    \frac{3}{h_1}(a_2 - a_1) - \frac{3}{h_0}(a_1 - a_0) \\
    \vdots \\
    \frac{3}{h_{n - 1}}\ (a_n - a_{n - 1}) - \frac{3}{h_{n - 2}}\ (a_{n - 1} - a_{n - 2}) \\
    3f'(b) - \frac{3}{h_{n - 1}}\ (a_n - a_{n - 1}) \\
\end{bmatrix}.
$$

!!! note "For More Accuracy..."
    If $f \in C[a, b]$ and $\frac{\max h_i}{\min h_i} \le C < \infty$. Then $S(x)\ \overset{\text{uniform}}{\longrightarrow}\ f(x)$ when $\max h_i \rightarrow 0$.

    That is the accuracy of approximation can be improved by **adding more nodes** without increasing the degree of the splines.

## Curves

We've discussed the interpolation of functions above, but we may encounter the case to interpolate a curve.

### Straightforward Technique

For given points $(x_0, y_0), (x_1, y_1), \dots, (x_n, y_n)$, we can construct *two* approximation functions with

$$
    x_i = x(t_i),\ y_i = y(t_i).
$$

The interpolation method can be Lagrange, Hermite and Cubic spline, whatever.

### Bezier Curve

In nature, it's **piecewise cubic Hermite polynomial**, and the curve is called **Bezier curve**.

Similarly, suppose two function $x(t)$ and $y(t)$ at each interval. We have the following condtions.

$$
    x(0) = x_0,\ x(1) = x_1,\ x'(0) = \alpha_0,\ x'(1) = \alpha_1.
$$

$$
    y(0) = y_0,\ y(1) = y_1,\ y'(0) = \beta_0,\ y'(1) = \beta_1.
$$

The solution is

$$
\begin{aligned}
    x(t) &= [2(x_0 - x_1) + (\alpha_0 + \alpha_1)]t^3 + [3(x_1 - x_0) - (\alpha_1 + 2\alpha_0)]t^2 + \alpha_0 t + x_0. \\
    y(t) &= [2(y_0 - y_1) + (\beta_0 + \beta_1)]t^3 + [3(y_1 - y_0) - (\beta_1 + 2\beta_0)]t^2 + \alpha_0 t + y_0.
\end{aligned}
$$

<div align="center">
	<img src="../imgs/chap3_4.png" alt="chap3_4 " style="width:500px"/>
</div>