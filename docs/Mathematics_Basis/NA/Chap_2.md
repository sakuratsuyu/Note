# Chapter 2 | Solution of Equations in One Variable

## Bisection Method

!!! theorem "Theorem 2.0"
    Suppose that $f \in C[a, b]$ and $f(a)\cdot f(b) \lt 0$. The Bisection method generates a sequence $\{p_n\}$ $(n = 0, 1, 2,\dots)$ approximating a zero $p$ of $f$ with
    
    $$
        |p_n-p| \le \frac{b - a}{2^n},\ \ \text{ when }n \ge 1
    $$

### Key Points for Algorithm Implementation

- $mid = a + (b - a)\ /\ 2, \text{but not } mid = (a + b)\ /\ 2$, for accuracy and not exceeding the limit of range.
- $sign(FA)\cdot sign(FM)\gt 0, \text{but not }FA\cdot FM \gt 0$, for saving time.

### Pros & Cons

**Pros**

- Simple premise, only requires a continuous $f$.
- Always converges to a solution.

**Cons**

- Slow to converge, and a good intermediate approximation can be inadvertently discarded.
- Cannot find multiple roots and complex roots.

## Fixed-Point Iteration

$$
    f(x) = 0 \leftrightarrow x = g(x)
$$

!!! theorem "Theorem12.1 | Fixed-Point Theorem"
    Let $g \in C[a,b]$ be such that $g(x) \in [a,b], \forall x \in [a, b]$. Suppose $g'$ exists on $(a,b)$ and that a constant $k$ $(0\lt k \lt 1)$ exists, s.t.
    
    $$
        \forall\ x \in (a,b),\ \ |g'(x)| \le k.
    $$
    
    Then $\forall\ p_0 \in[a,b]$, the sequence $\{p_n\}$ defined by
    
    $$
        p_n=g(p_{n-1})
    $$
    
    **converges** to the **unique** fixed-point $p\in [a,b]$.
.
!!! theorem "Corollary 2.2"
    $$
    \begin{aligned}
        |p_n - p| &\le k^n \max\{p_0 = a, b - p_0\}, \\
        |p_n - p| &\le \frac{k^n}{1 - k}|p_1 - p_0|.
    \end{aligned}
    $$
    
    $\Rightarrow$ The smaller $k$ is, the faster it converges.

<div align="center">
	<img src="../Pic/chap2_0.png" alt="chap2_0 " style="width:800px"/>
</div>

## Newton's Method (Newton-Raphson Method)

Newton's method is an improvement of common fixed-point iteration method above.

!!! theorem "Theorem 2.3"
    Let $f\in C^2[a,b]$ and $\exists\ p\in[a,b]$, s.t. $f(p) = 0$ and $f'(p) \ne 0$, then $\exists\ \delta \gt 0$, $\forall\ p_0 \in [p - \epsilon, p + \epsilon]$, s.t. the sequence $\{p_n\}_{n = 1}^\infty$ defined by 
    
    $$
        p_n = p_{n-1} - \frac{f(p_{n-1})}{f'(p_{n-1})}
    $$
    
    converges to $p$. 

## Error Analysis for Iterative Methods

!!! definition "Definition 2.0"
    Suppose $\{p_n\}$ is a sequence that converges to $p$, and $\forall n$, $p_n \ne p$. If positive constants $\alpha$ and $\lambda$ exist with
    
    $$
        \lim_{n \rightarrow \infty} \frac{|p_{n + 1} - p|}{|p_n - p|^\alpha} = \lambda,
    $$

    then $\{p_n\}$ **conveges to $p$ of order $\alpha$**, **with asymptotic error constant $\lambda$**.

    Specially,

    - If $\alpha = 1$, the sequence is called **linearly** convergent.
    - If $\alpha = 2$, the sequence is called **quadratically** convergent.

!!! theorem "Theorem 2.4"
    The common fixed-point iteration method ($g'(p) \ne 0$) with the premise in **Fixed-Point Theorem** is **linearly** convergent.

??? proof
    $$
        \lim_{n\rightarrow \infty}\frac{|p_{n+1} - p|}{|p_n - p|} = \lim_{n\rightarrow \infty}\frac{g'(\xi)|p_n - p|}{|p_n - p|} = |g'(p)|.
    $$

!!! theorem "Theorem 2.5"
    The Newton's method $(g'(p)=0)$ is *at least* **quadratically** convergent.

??? proof
    $$
    \begin{aligned}
        & 0 = f(p) = f(p_n) + f'(p_n)(p - p_n) + \frac{f''(\xi _n)}{2!}(p - p_n)^2 \\
        & \Rightarrow p = \underbrace{p_n - \frac{f(p_n)}{f"(p_n)}}_{p_{n+1}} - \frac{f''(\xi _n)}{2!f'(p_n)}(p - p_n)^2 \\
        & \Rightarrow \frac{|p_{n+1} - p|}{|p_n - p|^2} = \frac{f''(\xi _n)}{2f'(p_n)}, \\ 
        & \lim_{n\rightarrow \infty}\frac{|p_{n+1} - p|}{|p_n - p|^2} = \frac{f''(p_n)}{2f'(p_n)}.
    \end{aligned}
    $$

More commonly,

!!! theorem "Theorem 2.6"
    Let $p$ be a fixed point of $g(x)$. If there exists some constant $\alpha \ge 2$ such that $g\in C^\alpha [p-\delta, p+\delta]$, $g'(p)=\dots=g^{(\alpha-1)}(p)=0$, $g^{(\alpha)}(p)=0$. Then the iterations with $p_n = g(p_{n-1})$, $n \ge 1$, is of order $\alpha$.

### Multiple Roots Situation

Notice that from the proof above, Newton's method is quadratically convergent if $f'(p_n) \ne 0$. If $f'(p) = 0$, then the equation has multiple roots at $p$.

If $f(x) = (x - p)^mq(x)$ and $q(p)\ne 0$, for Newton's Method, 

$$
    g'(p) = \frac{f(p)f''(p)}{f'(p)^2} = \left.\frac{f(x)f''(x)}{f'(x)^2}\right|_{x=p} = \dots =1 - \frac{1}{m} \lt 1
$$

It is still convegent, but *not quadratically*.

??? success "A way to speed it up"
    Let

    $$
        \mu (x) = \frac{f(x)}{f'(x)},
    $$
    
    then $\mu (x)$ has the same root as $f(x)$ but no multiple roots anymore. And
    
    $$
        g(x) = x - \frac{\mu (x)}{\mu'(x)} = x - \frac{f(x)f'(x)}{f'(x)^2 - f(x)f''(x)}.
    $$

    Newton's method can be used there again.

    #### Pros & Cons

    **Pros**

    - Quadratic convegence

    **Cons**

    - Requires additional calculation of $f''(x)$
    - The denominator consists of the difference of the two numbers both close to $0$.

## Accelerating Convergence

### Aitken's $\Delta^2$ Method

<div align="center">
	<img src="../Pic/chap2_1.png" alt="chap2_1 " style="width:400px"/>
</div>

!!! definition "Definition 2.1"
    **Forward Difference** $\Delta p_n = p_{n+1} - p_n$. Similarly $\Delta^kp_n = \Delta(\Delta^{k-1}p_n)$

Representing Aitken's $\Delta^2$ Method by forward difference, we have

$$
    \hat{p_n} = p_n - \frac{(\Delta p_n)^2}{\Delta^2p_n}.
$$

!!! theorem "Theorem 2.7"
    Suppose that $\{p_n\}$ is a sequence, $\lim\limits_{n\rightarrow \infty}p_n = p$, $\exists N$, s.t. $\forall\ n > N$, $(p_n - p)(p_{n+1} -p) \gt 0$. Then the sequence $\{\hat{p_n}\}$ converges to $p$ **faster** than $\{p_n\}$ in the sense that
    
    $$
        \lim_{n\rightarrow \infty}\frac{\hat{p_n} - p}{p_n - p} = 0.
    $$

The algorithm to implement it is called **Steffensen’s Acceleration**.