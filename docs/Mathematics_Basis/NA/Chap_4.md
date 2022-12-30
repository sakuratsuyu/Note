# Chapter 4 | Numerical Differentiation and Integration

Before everything start, it's necessary to introduce an approach to reduce truncation error: **Richardson's extrapolation**.
### Richardson's Extrapolation

Suppose for each $h$, we have a formula $N(h)$ to approximate an unknown value $M$. And suppose the truncation error have the form

$$
    M - N(h) = K_1 h + K_2 h^2 + K_3 h^3 + \cdots,
$$

for some unknown constants $K_1$, $K_2$, $K_3$, $\dots$. This has $O(h)$ approximation.

First, we try to make some transformation to reduce the $K_1 h$ term.

$$
\begin{aligned}
    M &= N(h) + K_1 h + K_2 h^2 + K_3 h^3 + \cdots, \\
    M &= N\left(\frac{h}{2}\right) + K_1 \frac{h}{2} + K_2 \frac{h^2}{4} + K_3 \frac{h^3}{8} + \cdots,
\end{aligned}
$$

Eliminate $h$, and we have

$$
    \small
    M = \left[N\left(\frac{h}{2}\right) + \left(N\left(\frac{h}{2}\right) - N(h)\right)\right] + K_2\left(\frac{h^2}{2} - h^2\right) + K_3 \left(\frac{h^3}{4} - h^3\right) + \cdots
$$

Define $N_1(h) \equiv N(h)$ and

$$
    N_2(h) = N_1 \left(\frac{h}{2}\right) + \left(N_1\left(\frac{h}{2}\right) - N_1(h)\right).
$$

Then we have $O(h^2)$ approximation formula for $M$:

$$
    M = N_2(h) - \frac{K_2}{2}h^2 - \frac{3K_3}{4}h^3 - \cdots.
$$

Repeat this process by eliminating $h^2$, and then we have

$$
    M = N_3(h) + \frac{K_3}{8}h^3 + \cdots,
$$

where

$$
    N_3(h) = N_2 \left(\frac{h}{2}\right) + \frac{1}{3}\left(N_2\left(\frac{h}{2}\right) - N_2(h)\right).
$$

We can repeat this process recursively, and finally we get the following conclusion.

!!! success "Richardson's Extrapolation"
    If $M$ is in the form

    $$
        M = N(h) + \sum\limits_{j = 1}^{m - 1}K_jh^j + O(h^m),
    $$

    then for each $j = 2, 3, \dots, m$, we have an $O(h^j)$ approximation of the form

    $$
        N_j(h) = N_{j - 1}\left(\frac{h}{2}\right) + \frac{1}{2^{j - 1} - 1}\left(N_{j - 1}\left(\frac{h}{2}\right) - N_{j - 1}(h)\right).
    $$

    Also it can be used if the truncation error has the form

    $$
        \sum\limits_{j = 1}^{m - 1}K_jh^{\alpha_j} + O(h^{\alpha_m}).
    $$

    <div align="center">
    	<img src="../Pic/chap4_0.png" alt="chap4_0" style="width:500px"/>
    </div>

## Numerical Differentiation

### First Order Differentiation

Suppose $\{x_0, x_1, \dots, x_n\}$ are distinct in some interval $I$ and $f \in C^{n + 1}(I)$, then we have the Lagrange interpolating polynomials,

$$
    f(x) = \sum\limits_{k = 0}^{n}f(x_k)L_k(x) + \frac{f^{(n + 1)}(\xi(x))}{(n + 1)!}\prod\limits_{i = 0}^{n}(x - x_i).
$$

Differentiate $f(x)$ and substitute $x_j$ to it,

$$
    f'(x_j) = \sum\limits_{k = 0}^{n}f(x_k)L_k'(x) + \frac{f^{(n + 1)}(\xi(x_j))}{(n + 1)!} \prod\limits_{\substack{k = 0 \\ k \ne j}}^n(x_j - x_k),
$$

which is called an **(n + 1)-point formula** to approximate $f'(x_j)$.

For convenience, we only discuss the **equally spaced** situation. Suppose the interval is $[a, b]$ divided to $n$ parts, and denote 

$$
\begin{aligned}
    h = \frac{b - a}{n}, \\
    x_i = a + ih.
\end{aligned}
$$

!!! plane ""
    When $n = 1$, we simply get the two-point formula,

    $$
        f'(x_0) = \frac{f(x_0 + h) - f(x_0)}{h} - \frac{h}{2}f''(\xi),
    $$

    which is known as **forward-difference formula**. Inversely, by replacing $h$ with $-h$,

    $$
        f'(x_0) = \frac{f(x_0) - f(x_0 - h)}{h} + \frac{h}{2}f''(\xi),
    $$

    is known as **backward-difference formula**.

!!! plane ""
    When $n = 3$, we get the **three-point formulae**. Due to symmetry, there are only two.

    $$
    \begin{aligned}
        f'(x_0) &= \frac{1}{2h}[-3(f(x_0)) + 4f(x_0 + h) - f(x_0 + 2h)] + \frac{h^2}{3}f^{(3)}(\xi), \\
        & \text{where some } \xi \in [x_0, x_0 + 2h], \\
        f'(x_0) &= \frac{1}{2h}[f(x_0 + h) + f(x_0 - h)] - \frac{h^2}{6}f^{(3)}(\xi), \\
        & \text{where some } \xi \in [x_0 - h, x_0 + h].
    \end{aligned}
    $$

!!! plane ""
    When $n = 5$, we get the **five-point formulae**. The following are the useful two of them.

    $$
    \begin{aligned}
        f'(x_0) &= \frac{1}{12h}[-25f(x_0) + 48f(x_0 + h) - 36f(x_0 + 2h) \\
                & \ \ \ \ + 16f(x_0 + 3h) - 3f(x_0 + 4h)] + \frac{h^4}{5}f^{(5)}(\xi), \\
        & \text{where some } \xi \in [x_0, x_0 + 4h], \\
        f'(x_0) &= \frac{1}{12h}[f(x_0 - 2h) - 8f(x_0 - h)] + 8f(x_0 + h) - f(x_0 + 2h)] \\
                & \ \ \ \ + \frac{h^4}{30}f^{(5)}(\xi), \\
        & \text{where some } \xi \in [x_0 - 2h, x_0 + 2h].
    \end{aligned}
    $$

<div align="center">
	<img src="../Pic/chap4_2.png" alt="chap4_2" style="width:500px"/>
</div>

<div align="center">
	<img src="../Pic/chap4_3.png" alt="chap4_3" style="width:500px"/>
</div>

!!! success "Differentiation with Richardson's Extrapolation"
    Consider the three-point formula,

    $$
        f'(x_0) = \frac{1}{2h}[f(x_0 + h) + f(x_0 - h)] - \frac{h^2}{6}f^{(3)}(\xi) - \frac{h^4}{120}f^{(5)}(\xi) - \cdots.
    $$

    In this case, considering Richardson's extrapolation, we have

    $$
        N_1(h) = \frac{1}{2h}[f(x_0 + h) + f(x_0 - h)].
    $$

    Eliminate $h^2$, we have

    $$
        f'(x_0) = N_2(h) + \frac{h^4}{480}f^{(5)}(x_0) + \cdots,
    $$

    where

    $$
        N_2(h) = N_1 \left(\frac{h}{2}\right) + \frac{1}{3}\left(N_1\left(\frac{h}{2}\right) - N_1(h)\right).
    $$

    Continuing this procedure, we have,

    $$
        N_j(h) = N_{j - 1}\left(\frac{h}{2}\right) + \frac{1}{4^{j - 1} - 1}\left(N_{j - 1}\left(\frac{h}{2}\right) - N_{j - 1}(h)\right).
    $$

    ??? example

        Suppose $x_0 = 2.0$, $h = 0.2$, $f(x) = xe^x$, the exact value of $f'(x_0)$ is 22.167168. While the extrapolation process is shown below.

        <div align="center">
        	<img src="../Pic/chap4_1.png" alt="chap4_1" style="width:600px"/>
        </div>


### Higher Differentiation

Take second order differentiation as an example. From Taylor polynomial about point $x_0$, we have

$$
\begin{aligned}
    f(x_0 + h) &= f(x_0) + f'(x_0)h + \frac{1}{2}f''(x_0)h^2 + \frac{1}{6}f'''(x_0)h^3 + \frac{1}{24}f^{(4)}(\xi_1)h^4, \\
    f(x_0 - h) &= f(x_0) - f'(x_0)h + \frac{1}{2}f''(x_0)h^2 - \frac{1}{6}f'''(x_0)h^3 + \frac{1}{24}f^{(4)}(\xi_{-1})h^4, \\
\end{aligned}
$$

where $x_0 - h < \xi_{-1} < x_0 < \xi_1 < x_0 + h$.

Add these equations and take some transformations, we get

$$
    f''(x_0) = \frac{1}{h^2}[f(x_0 - h) - 2f(x_0) + f(x_0 + h)] - \frac{h^2}{12}f^{(4)}(\xi),
$$

where $x_0 - h < \xi < x_0 + h$, and $f^{(4)}(\xi) = \dfrac{1}{2}(f^{(4)}(\xi_1) + f^{(4)}(\xi_{-1}))$.

### Error Analysis

Now we examine the formula below,

$$
    f'(x_0) = \frac{1}{2h}[f(x_0 + h) + f(x_0 - h)] - \frac{h^2}{6}f^{(3)}(\xi).
$$

Suppose that in evaluation of $f(x_0 + h)$ and $f(x_0 - h)$, we encounter roundoff errors $e(x_0 + h)$ and $e(x_0 - h)$. Then our computed values $\tilde f(x_0 + h)$ and $\tilde f(x_0 - h)$ satisfy the following formulae,

$$
\begin{aligned}
    f(x_0 + h) &= \tilde f(x_0 + h) + e(x_0 + h), \\ 
    f(x_0 - h) &= \tilde f(x_0 - h) + e(x_0 - h).
\end{aligned}
$$

Thus the total error is 

$$
    R = f'(x_0) - \frac{\tilde f(x_0 + h) - \tilde f(x_0 - h)}{2h} = \frac{e(x_0 + h) - e(x_0 - h)}{2h} - \frac{h^2}{6}f^{(3)}(\xi).
$$

Moreover, suppose the roundoff error $e$ are bounded by some number $\varepsilon > 0$ and $f^{(3)}(x)$ is bounded by some number $M > 0$, then

$$
    |R| \le \frac{\varepsilon}{h} + \frac{h^2}{6}M.
$$

Thus theoretically the best choice of $h$ is $\sqrt[3]{3\varepsilon / M}$. But in reality we cannot compute such an $h$ since we know nothing about $f^{(3)}(x)$.

In all, we should aware that *the step size $h$ cannot be too large or too small*.

## Numerical Integration

### Numerical Quadrature

Similarly to the differentiation case, suppose $\{x_0, x_1, \dots, x_n\}$ are distinct in some interval $I$ and $f \in C^{n + 1}(I)$, then we have the Lagrange interpolating polynomials,

$$
    f(x) = \sum\limits_{k = 0}^{n}f(x_k)L_k(x) + \frac{f^{(n + 1)}(\xi(x))}{(n + 1)!}\prod\limits_{i = 0}^{n}(x - x_i).
$$

Integrate $f(x)$ and we get

$$
\begin{aligned}
    \int_a^b f(x) dx &= \int_a^b \sum\limits_{k = 0}^{n}f(x_k)L_k'(x) dx + \int_a^b \frac{f^{(n + 1)}(\xi(x))}{(n + 1)!} \prod\limits_{k = 0}^n (x - x_k)dx, 
    \\ &= \sum\limits_{i = 0}^n A_i f(x_i) + \underbrace{\frac{1}{(n + 1)!} \int_a^b \prod_{i = 0}^n(x - x_i)f^{(n + 1)}(\xi(x))dx}_{E(f)},
\end{aligned}
$$

where

$$
    A_i = \int_a^b L_i(x)dx.
$$

!!! definition "Definition 4.0"
    The **degree of accuracy**, or say **precision**, of a quadrature formula is the *largest* positive integer $n$ such that the formula is *exact* for $x^k$, for each $k = 0, 1, \dots, n$.


Similarly, we suppose **equally spaced** situation here again.

!!! theorem "Theorem 4.0 | (n + 1)-point closed Newton-Cotes formulae"
    Suppose $x_0 = a$, $x_n = b$, and $h = (b - a) / n$, then $\exists\ \xi \in (a, b)$, s.t.

    $$
        \int_a^b f(x)dx = \sum\limits_{i = 0}^n A_i f(x_i) + \frac{h^{n + 3}f^{(n + 2)}(\xi)}{(n + 2)!}\int_0^n t^2(t - 1)\cdots(t - n)dt,
    $$

    if $n$ is even and $f \in C^{n + 2}[a, b]$, and

    $$
        \int_a^b f(x)dx = \sum\limits_{i = 0}^n A_i f(x_i) + \frac{h^{n + 2}f^{(n + 1)}(\xi)}{(n + 1)!}\int_0^n t(t - 1)\cdots(t - n)dt,
    $$

    if $n$ is odd and $f \in C^{n + 1}[a, b]$,

    where

    $$
        A_i = \int_a^b L_i(x) dx = \int_a^b \prod\limits_{\substack{j = 0 \\ j \ne i}}^n \frac{(x - x_j)}{(x_i - x_j)} dx.
    $$

    <div align="center">
    <figure>
    	<img src="../Pic/chap4_6.png" alt="chap4_6" style="width:500px"/>
        <figcaption>(n + 1)-point closed Newton-Cotes formulae</figcaption>
    </figure>
    </div>

!!! plane ""
    $n = 1$ **Trapezoidal rule**

    $$
        \int_{x_0}^{x_1}f(x)dx = \frac{h}{2}[f(x_0) + f(x_1)] - \frac{h^3}{12}f''(\xi)
        ,\ \ \text{ where some } x_0 < \xi < x_1.
    $$

    $n = 2$ **Simpson's rule**

    $$
        \int_{x_0}^{x_2}f(x)dx = \frac{h}{3}[f(x_0) + 4f(x_1) + f(x_2)] - \frac{h^5}{90}f^{(4)}(\xi)
        ,\ \ \text{ where some } x_0 < \xi < x_2.
    $$

    $n = 3$ **Simpson's Three-Eighths rule**

    $$
        \int_{x_0}^{x_3}f(x)dx = \frac{3h}{8}[f(x_0) + 3f(x_1) + 3f(x_2) + f(x_3)] - \frac{3h^5}{80}f^{(4)}(\xi), \\
        \text{where some } x_0 < \xi < x_3.
    $$

<div align="center">
<figure>
	<img src="../Pic/chap4_4.png" alt="chap4_4" style="width:500px"/>
    <figcaption>Trapezoidal rule</figcaption>
</figure>
</div>

<div align="center">
<figure>
	<img src="../Pic/chap4_5.png" alt="chap4_5" style="width:500px"/>
    <figcaption>Simpson's rule</figcaption>
</figure>
</div>

!!! theorem "Theorem 4.1 | (n + 1)-point open Newton-Cotes formulae"
    Suppose $x_{-1} = a$, $x_{n + 1} = b$, and $h = (b - a) / (n + 2)$, then $\exists\ \xi \in (a, b)$, s.t.

    $$
        \int_a^b f(x)dx = \sum\limits_{i = 0}^n A_i f(x_i) + \frac{h^{n + 3}f^{(n + 2)}(\xi)}{(n + 2)!}\int_{-1}^{n + 1} t^2(t - 1)\cdots(t - n)dt,
    $$

    if $n$ is even and $f \in C^{n + 2}[a, b]$, and

    $$
        \int_a^b f(x)dx = \sum\limits_{i = 0}^n A_i f(x_i) + \frac{h^{n + 2}f^{(n + 1)}(\xi)}{(n + 1)!}\int_{-1}^{n + 1} t(t - 1)\cdots(t - n)dt,
    $$

    if $n$ is odd and $f \in C^{n + 1}[a, b]$,

    where

    $$
        A_i = \int_a^b L_i(x) dx = \int_a^b \prod\limits_{\substack{j = 0 \\ j \ne i}}^n \frac{(x - x_j)}{(x_i - x_j)} dx.
    $$

    <div align="center">
    <figure>
    	<img src="../Pic/chap4_7.png" alt="chap4_7" style="width:500px"/>
        <figcaption>(n + 1)-point open Newton-Cotes formulae</figcaption>
    </figure>
    </div>

!!! plane ""
    $n = 0$ **Midpoint rule**

    $$
        \int_{x_{-1}}^{x_1}f(x)dx = 2hf(x_0) + \frac{h^2}{3}f''(\xi)
        \text{where some } x_{-1} < \xi < x_1.
    $$
### Composite Numerical Integration

**Motivation:** Although the Newton-Cotes gives a better and better approximation as $n$ increases, since it's based on interpolating polynomials, it also owns the *oscillatory* nature of high-degree polynomials.

Similarly, we discuss a **piecewise** approach to numerical integration with low-order Newton-Cotes formulae. *These are the techniques most often applied*.

!!! theorem "Theorem 4.2 | Composite Trapezoidal rule"
    $f \in C^2[a, b]$, $h = (b - a) /n$, and $x_j = a + jh$, $j = 0, 1, \dots, n$. Then $\exists\ \mu \in (a, b)$, s.t.

    $$
        \int_a^b f(x)dx = \frac{h}{2}\left[f(a) + 2 \sum\limits_{j = 1}^{n - 1}f(x_j) + f(b)\right] - \frac{b - a}{12}h^2 f''(\mu).
    $$

    <div align="center">
    	<img src="../Pic/chap4_8.png" alt="chap4_8" style="width:500px"/>
    </div>

!!! theorem "Theorem 4.3 | Composite Simpson's rule"
    $f \in C^2[a, b]$, $h = (b - a) /n$, and $x_j = a + jh$, $j = 0, 1, \dots, n$. Then $\exists\ \mu \in (a, b)$, s.t.

    $$
        \small
        \int_a^b f(x)dx = \frac{h}{3}\left[f(a) + 2 \sum\limits_{j = 1}^{(n / 2) - 1}f(x_{2j}) + 4 \sum\limits_{j = 1}^{n / 2}f(x_{2j - 1}) + f(b)\right] - \frac{b - a}{180}h^4 f^{(4)}(\mu).
    $$

    <div align="center">
    	<img src="../Pic/chap4_9.png" alt="chap4_9" style="width:500px"/>
    </div>

!!! theorem "Theorem 4.4 | Composite Midpoint rule"
    $f \in C^2[a, b]$, $h = (b - a) / (n + 2)$, and $x_j = a + (j + 1)h$, $j = -1, 0, \dots, n + 1$. Then $\exists\ \mu \in (a, b)$, s.t.

    $$
        \int_a^b f(x)dx = 2h \sum\limits_{j = 0}^{n / 2}f(x_{2j}) + \frac{b - a}{6} h^2 f''(\mu).
    $$

    <div align="center">
    	<img src="../Pic/chap4_10.png" alt="chap4_10" style="width:500px"/>
    </div>

!!! note "Stability"
    Composite integration techniques are all **stable** w.r.t roundoff error.

    ??? example "Example: Composite Simpson's rule"
        Suppose $f(x_i)$ is apporximated by $\tilde f(x_i)$ with

        $$
            f(x_i) = \tilde f(x_i) + e_i.
        $$

        Then the accumulated error is

        $$
            e(h) = \left|\frac{h}{3}\left[e_0 + 2\sum\limits_{j = 1}^{(n / 2) - 1}e_{2j} + 4\sum\limits_{j = 1}^{n / 2}e_{2j-1} + e_n\right]\right|.
        $$

        Suppose $e_i$ are uniformly bounded by $\varepsilon$, then

        $$
            e(h) \le \frac{h}{3}\left[\varepsilon + 2 \left(\frac{n}{2} - 1\right) + 4 \frac{n}{2} \varepsilon + \varepsilon \right] = nh\varepsilon = (b - a)\varepsilon.
        $$

        That means even though divide an interval to more parts, the roundoff error will not increase, which is quite stable.

#### Romberg Integration

Romberg integration combine the **Composite Trapezoidal rule** and **Richardson's extrapolation** to derive a more useful approximation.

Suppose we divide the interval $[a, b]$ into $m_1 = 1$, $m_2 = 2$, $\dots$, and $m_n = 2^{n - 1}$ subintervals respectively. For each division, then the step size $h_k$ is $(b - a) / m_k = (b - a) / 2^{k - 1}$.

Then we use $R_{k, 1}$ to denote the composite trapezoidal rule,

$$
\small
    R_{k, 1} = \int_a^b f(x) dx = \frac{h_k}{2} \left[f(a) + f(b) + 2 \left(\sum\limits_{i = 1}^{2^{k - 1} - 1} f(a + ih_k)\right)\right] - \frac{(b - a)}{12}h^2_kf''(\mu_k).
$$

Mathematically, we have the recursive formula,

$$
    R_{k, 1} = \frac{1}{2}\left[R_{k - 1, 1} + h_{k - 1}\sum\limits_{i = 1}^{2^{k - 2}}f(a+(2i-1)h_k)\right].
$$


<div align="center">
	<img src="../Pic/chap4_11.png" alt="chap4_11" style="width:600px"/>
</div>

!!! theorem "Theorem 4.5"
    the Composite Trapezoidal rule can represented by an alternative error term in the form

    $$
        \int_a^b f(x) dx - R_{k, 1} = \sum\limits_{i = 1}^{\infty} K_i h^{2i}_k,
    $$

    where $K_i$ depends only on $f^{(2i-1)}(a)$ and $f^{(2i-1)}(b)$.

This nice theorem makes Richardson's extrapolation available to reduce the truncation error! Similar to **Differentiation with Richardson's Extrapolation**, we have the following formula.

!!! success "Romberg Integration"
    
    $$
        R_{k, j} = R_{k, j - 1} + \frac{R_{k, j - 1} - R_{k - 1, j - 1}}{4^{j - 1} - 1},
    $$

    with an $O(h^{2j}_k)$ approximation.

    <div align="center">
    	<img src="../Pic/chap4_12.png" alt="chap4_12" style="width:400px"/>
    </div>

#### Adaptive Quadrature Methods

**Motivation:** On the premise of equal spacing, in some cases, the left half of the interval is well approximated, and maybe we only need to subdivide the right half to approximate better. Here we introduce the **Adaptive quadrature methods** based on the Composite Simpson's rule.

!!! plane ""
    First, we want to derive, if we apply Simpson's rule in two subinterval and add them up, *how much precision does it improve* compared to only applying Simpson's rule just in the whole interval.

From Simpson's rule, we have

$$
    \int_a^b f(x) dx = S(a, b) - \frac{h^5}{90}f^{(4)}(\mu),
$$

where

$$
    S(a, b) = \frac{h}{3}[f(a) + 4f(a + h) + f(b)].
$$

If we divide $[a, b]$ into two subintervals, applying Simpson's rule respectively (namely apply Composite Simpson's rule with $n = 4$ and step size $h / 2$), we have

$$
    \int_a^b f(x) dx = S\left(a, \frac{a + b}{2}\right) + S\left(\frac{a + b}{2}, b\right) - \frac{1}{16}\left(\frac{h^5}{90}\right)f^{(4)}(\tilde \mu).
$$

Moreover, assume $f^{(4)}(\mu) \approx f^{(4)}(\tilde \mu)$, then we have

$$
    S\left(a, \frac{a + b}{2}\right) + S\left(\frac{a + b}{2}, b\right) - \frac{1}{16}\left(\frac{h^5}{90}\right)f^{(4)}(\tilde \mu) \approx S(a, b) - \frac{h^5}{90}f^{(4)}(\mu),
$$

so

$$
    \frac{h^5}{90}f^{(4)}(\mu) \approx \frac{16}{15}\left[S(a, b) - S\left(a, \frac{a + b}{2}\right) - S\left(\frac{a + b}{2}, b\right)\right].
$$

Then,

$$
\begin{aligned}
    \left|\int_a^b f(x) dx - S\left(a, \frac{a + b}{2}\right) - S\left(\frac{a + b}{2}, b\right)\right|
    = \left|\frac{1}{16}\left(\frac{h^5}{90}\right)f^{(4)}(\tilde \mu)\right|
    \\ \approx \frac{1}{15} \left|S(a, b) - S\left(a, \frac{a + b}{2}\right) - S\left(\frac{a + b}{2}, b\right)\right|.
\end{aligned}
$$

This result means that the subdivision approximates $\int_a^b f(x) dx$ about **15** times better than it agree with $S(a, b)$. Thus suppose we have a tolerance $\varepsilon$ across the interval $[a, b]$. If

$$
    \left|S(a, b) - S\left(a, \frac{a + b}{2}\right) - S\left(\frac{a + b}{2}, b\right)\right| < 15\varepsilon,
$$

then we expect to have

$$
    \left|\int_a^bf(x)dx - S\left(a, \frac{a + b}{2}\right) - S\left(\frac{a + b}{2}, b\right)\right| < \varepsilon,
$$

and the subdivision is thought to be a better approximation to $\int_a^bf(x)dx$.

!!! success "Conclusion"
    Suppose we have a tolerance $\varepsilon$ on $[a, b]$, and we expect the tolerance is uniform. Thus at the subinterval $[p, q] \subseteq [a, b]$, with $q - p = k(b - a)$, we expect the tolerance as $k\varepsilon$.

    Moreover, suppose the approximation of Simpson's rule on $[p, q]$ is $S$ while the approxiamtion of Simpson's rule on $[p, (p + q) / 2]$ and $[(p + q) / 2, q]$ are $S_1$ and $S_2$ respectively. 

    Then **the criterion to subdivide** is that

    $$
        |S_1 + S_2 - S| < M \cdot k \varepsilon.
    $$

    where $M$ is often taken as **10** but not **15**, which we derive above, since it also consider the error between $f^{(4)}(\mu)$ and $f^{(4)}(\tilde \mu)$.

### Gaussian Quadrature

Instead of equal spacing in the Newton-Cotes formulae, the selection of the points $x_i$ also become variables. **Gaussian Quadrature** is aimed to construct a formula $\sum\limits_{k = 0}^n A_kf(x_k)$ to approximate $\int_a^b w(x)f(x)dx$ of precision degree $2n + 1$ with $n + 1$ points, where $w(x)$ is a weight function. (Compare to the equally spaced strategy only have a precision of around $n$).

That means, to determine $x_i$ and $A_i$ (totally $2n + 2$ unknowns) such that the formula is accurate for $f(x) = 1, x, \dots, x^{2n + 1}$ (totally $2n + 2$ equations). The selected points $x_i$ are called **Gaussian points**.

!!! bug "Problem"
    Theoretically, since we have $2n + 2$ unknowns and $2n + 2$ eqautions, we can solve out $x_i$ and $A_i$. But the equations are **not linear**!

Thus we give the following theorem to find Gaussian points without solving the nonlinear eqautions. [Recap](../Chap_8/#solution_1) the definition of weight function and **orthogonality** of polynomials, and the construction of the set of orthogonal polynomials.


!!! theorem "Theorem 4.6"
    $x_0, \dots, x_n$ are Gaussian point iff $W(x) = \prod\limits_{k = 0}^n (x - x_k)$ is orthogonal to all the polynomials of degree no greater than $n$ on interval $[a,b]$ w.r.t the weight function $w(x)$.

??? proof

    $\Rightarrow$ 
    
    if $x_0, \dots x_n$ are Gaussian points, then the degree of precision of the formula $\int_a^b w(x)f(x)dx \approx \sum\limits_{k = 0}^n A_k f(x_k)$ is at least $2n + 1$.

    Then $\forall\ P(x) \in \Pi_n$,\ \ $\text{deg}(P(x)W(x)) \le 2n + 1$. Thus

    $$
        \int_a^b w(x)P(x)W(x)dx = \sum\limits_{k = 0}^n A_k P(x_k)\underbrace{W(x_k)}_{0} = 0.
    $$

    $\Leftarrow$

    $\forall\ P(x) \in \Pi_{2n + 1}$, let $P(x) = W(x)q(x) + r(x),\ \ q(x), r(x) \in \Pi_{n}$, then

    $$
    \begin{aligned}
        \int_a^b w(x)P(x) dx &= \int_a^b w(x)W(x)q(x)dx + \int_a^b w(x)r(x)dx \\
        &= \sum\limits_{k = 0}^n A_k r(x_k) = \sum\limits_{k = 0}^n A_k P(x_k).
    \end{aligned}
    $$

Recap that the set of orthogonal polynomials $\{\varphi_0, \dots, \varphi_n, \dots\}$ is linearly independent and $\varphi_{n + 1}$ is orthogonal to any polynomials of degree no greater than $n$.

Thus we can take $\varphi_{n + 1}(x)$ to be $W(x)$ and **the roots of $\varphi_{n + 1}(x)$** are the Gaussian points.

!!! success "Genernal Solution"
    **Problem:** Assume
    
    $$
        \int_a^b w(x)f(x)dx \approx \sum\limits_{i = 0}^n A_k f(x_k).
    $$

    **Step.1** Construct the set of orthogonal polynomial on the interval $[a, b]$ by Gram-Schimidt Process from $\varphi_0(x) \equiv 1$ to $\varphi_{n}(x)$.

    **Step.2** Find the roots of $\varphi_{n}(x)$, which are the Gaussian points $x_0, \dots, x_n$.

    **Step.3** Solve the linear systems of the equation given by the precision for $f(x) = 1, x, \dots, x^{2n + 1}$, and obtain $A_0, \dots, A_n$.

Although the method above is theoretically available, but it's tedious. But we have some special solutions which have been calculated. With some transformations, we can make them to solve the general problem too.

#### Legendre Polynomials

A typical set of orthogonal functions is Legrendre Polynomials.

!!! note "Legrendre Polynomials"
    $$
        P_k(x) = \frac{1}{2^k k!} \frac{d^k}{dx^k}(x^2 - 1)^k,
    $$
    
    or equally defined recursively by

    $$
    \begin{aligned}
        & P_0(x) = 1,\ P_1(x) = x, \\
        & P_{k + 1}(x) = \frac{1}{k + 1}\left((2k + 1)x P_k(x) - k P_{k - 1}(x)\right).
    \end{aligned}
    $$

!!! theorem "Property"

    - $\{P_n(x)\}$ are orthogonal on $[-1, 1]$, w.r.t the weight function
        
        $$
            w(x) \equiv 1.
        $$

        $$
            (P_j, P_k) = \left\{
            \begin{aligned}
                & 0, && k \ne l, \\
                & \frac{2}{2k + 1}, && k = l.
            \end{aligned}
            \right.
        $$

    - $P_n(x)$ is a **monic** polynomial of degree $n$.
    - $P_n(x)$ is symmetric w.r.t the origin.
    - The $n$ roots of $P_n(x)$ are all on $[-1, 1]$.

The first few of them are

$$
\begin{aligned}
    P_0(x) &= 1, \\
    P_1(x) &= x, \\
    P_2(x) &= x^2 - \frac13, \\
    P_3(x) &= x^3 - \frac35 x, \\
    P_4(x) &= x^4 - \frac67 x^2 + \frac{3}{35}.
\end{aligned}
$$

The following table gives the pre-calculated values.

<div align="center">
	<img src="../Pic/chap4_13.png" alt="chap4_13" style="width:300px"/>
</div>

And from interval $[-1, 1]$ to $[a, b]$, we have a linear map

$$
    t = \frac{2x - a - b}{b - a} \Leftrightarrow x = \frac12 [(b - a)t + a + b].
$$

<div align="center">
	<img src="../Pic/chap4_14.png" alt="chap4_14" style="width:600px"/>
</div>

Thus we have

$$
    \int_a^b f(x) dx = \int_{-1}^1 f\left(\frac{(b - a)t + (b + a)}{2}\right)\frac{b - a}{2}dt.
$$

The formula using the roots of $P_{n + 1}(x)$ is called the **Gauss-Legendre** quadrature formula.

??? example
    Approxiamte $\int_1^{1.5} e^{-x^2}dx$ (exact value to 7 decimal places is 0.1093643).

    **Solution.**

    $$
        \int_1^{1.5} e^{-x^2} = \frac14 \int_{-1}^1 e^{-(t + 5)^2 / 16}dt,
    $$

    For $n = 2$,

    $$
        \int_1^{1.5} e^{-x^2} \approx \frac14 [e^{-(0.57735 + 5)^2 / 16} + e^{-(-57735 + 5)^2 / 16}] = 0.1094003.
    $$

    For $n = 3$,

    $$
    \begin{aligned}
        \int_1^{1.5} e^{-x^2} &\approx \frac14 [0.55556e^{-(0.77460 + 5)^2 / 16} + 0.88889e^{-(5)^2 / 16} 
        \\ & \ \ \ \ + 0.55556e^{-(-0.77460 + 5)^2 / 16}]
        \\ & = 0.1093642.
    \end{aligned}
    $$

#### Chebyshev Polynomials

Also, [Chebyshev polynomials](../Chap_8/#chebyshev-polynomials) are typical set of orthogonal polynomials too. We don't discuss much about it there.

The formula using the roots of $T_{n + 1}(x)$ is called the **Gauss-Chebyshev** quadrature formula.