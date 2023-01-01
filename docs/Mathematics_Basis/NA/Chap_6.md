# Chapter 6 | Direct Methods for Solving Linear Systems

## Linear Systems of Equations

### Gaussian Elimination with Backward Substitution

$$
    A\mathbf{x} = \mathbf{b}
$$

Let $A^{(1)} = A, \mathbf{b}^{(1)} = \mathbf{b}$.

#### Elimination

For Step $k\ (1\le k \le n-1)$, if $a^{(k)}_{kk}\ne0$ (**pivot element**), compute $m_{ik} = \dfrac{a^{(k)}_{ik}}{a^{(k)}_{kk}}$ and

$$
\left\{
\begin{aligned}
    a_{ij}^{(k+1)} = a_{ij}^{(k)} - m_{ik}a_{kj}^{(k)} \\
    b_i^{(k+1)} = b_i^{(k)} - m_{ik}b_k^{(k)}
\end{aligned}
,\ \ \text{ where } i, j = k+1, \dots, n.
\right.
$$

After $n-1$ steps,

$$
\begin{bmatrix}
    a^{(1)}_{11} & a^{(1)}_{12} & \cdots & a^{(1)}_{1n} \\
    & a^{(2)}_{22} & \cdots & a^{(2)}_{2n} \\
    & & \cdots & \vdots \\
    & & & a^{(n)}_{nn} \\
\end{bmatrix}
\begin{bmatrix}
    x_1 \\
    x_2 \\
    \vdots \\
    x_n
\end{bmatrix}
=
\begin{bmatrix}
    b^{(1)}_1 \\
    b^{(2)}_2 \\
    \vdots \\
b^{(n)}_n
\end{bmatrix}.
$$

#### Backward Substitution

Then,

$$
x_n = \frac{b_n^{(n)}}{a^{(n)}_{nn}},\ \ x_i = \frac{1}{a_{ii}^{(i)}}\left(b^{(i)}_i - \sum_{j = i + 1}^n a^{(i)}_{ij} x_j\right),\ \ \text{ where }i = n-1, \dots, 1.
$$

### Complexity

Recap that we have

$$
    \sum\limits_{i = 1}^n 1 = n,\ \
    \sum\limits_{i = 1}^n i = \frac{n(n+1)}{2},\ \
    \sum\limits_{i = 1}^n i^2 = \frac{n(n+1)(2n+1)}{6}.\ \
$$

For Elimination,

*Multiplications/divisions*

$$
    \sum\limits_{k=1}^{n-1}((n - k) + (n - k)(n - k + 2)) = \frac{n^3}{3} + \frac{n^2}{2} - \frac{5}{6}n.
$$

*Addtion/subtraction*

$$
    \sum\limits_{k = 1}^{n-1}(n - k)(n - k + 1) = \frac{n^3}{3} - \frac{n}{3}.
$$

For Backward-substitution,

*Multiplications/divisions*

$$
    1 + \sum\limits_{k=1}^{n-1}(n - k + 1) = \frac{n^2}{2} + \frac{n}{2}.
$$

*Addtion/subtraction*

$$
    \sum\limits_{i = 1}^{n - 1}((n - i + 1) + 1) = \frac{n^2}{2} - \frac{n}{2}.
$$

In total,

*Multiplications/divisions*

$$
    \frac{n^3}{3} + n^2 - \frac{n}{3}.
$$

*Addtion/subtraction*

$$
\frac{n^3}{3} + \frac{n^2}{2}-\frac{5n}{6}.
$$

## Pivoting Strategies

**Motivation:** For Gaussian Elimination with Backward Substituion, if the pivot element $a_{kk}^{(k)}$ is small compared to $a_{ik}^{(k)}$, then $m_{ik}$ is large with high **roundoff error**. Thus we need some transformation to improve the accuracy.

### Partial Pivoting (a.k.a Maximal Column Pivoting)

Determine the smallest $p \ge k$ such that

$$
    \left|a_{pk}^{(k)}\right| = \max_{k \le i \le n} \left|a_{ik}^{(k)}\right|,
$$

and interchange row $p$ and row $k$ .

*Requires* $O(N^2)$ additional **comparisons**.

### Scaled Partial Pivoting (a.k.a Scaled-Column Pivoting)

Determine the smallest $p \ge k$ such that

$$
    \frac{\left|a_{pk}^{(k)}\right|}{s_p} = \max\limits_{k \le i \le n} \frac{\left|a_{ik}^{(k)}\right|}{s_i},
$$

and interchange row $p$ and row $k$, where $s_i = \max\limits_{1 \le j \le n} \left|a_{ij}\right|$.

(Simply put, place the element in the pivot position that is largest relative to the entries in its 
row.)

*Requires* $O(N^2)$ additional **comparisons** and $O(N^2)$ **divisions**.

### Complete Pivoting (a.k.a Maximal Pivoting)

Search all the entries $a_{ij}$ for $i,j = k, \dots,n$ to find the entry with the largest magnitude. **Both row and column** interchanges are performed to bring this entry to the pivot position.

*Requires* $O\left(\dfrac{1}{3}N^3\right)$ additional **comparisons**.

## LU Factorization

Considering the matrix form of Gaussian Elimination, for total $n-1$ steps, we have

$$
L_{n-1}L_{n-2}\dots L_1[A\ \textbf{b}] = 
\begin{bmatrix}
    a^{(1)}_{11} & a^{(1)}_{12} & \cdots & a^{(1)}_{1n} & b_1^{(1)} \\
    & a^{(2)}_{22} & \cdots & a^{(2)}_{2n} & b_2^{(2)} \\
    & & \ddots & \vdots & \vdots \\
    & & & a^{(n)}_{nn} & b_n^{(n)} \\
\end{bmatrix},
$$

where

$$
L_k =
\begin{bmatrix}
    1 & 0 & \cdots & \cdots & \cdots & 0 \\
    0 & \ddots & \ddots & \ddots & \ddots & \vdots \\
    \vdots & \ddots & 1 & \ddots & \ddots & \vdots\\
    \vdots & \ddots & -m_{k+1, k} & \ddots & \ddots & \vdots\\
    \vdots & \ddots& \vdots & \ddots & \ddots & 0 \\
    0 & \cdots & -m_{n, k} & \cdots & \cdots & 1
\end{bmatrix}.
$$

It's simple to compute that

$$
L_k^{-1} =
\begin{bmatrix}
    1 & 0 & \cdots & \cdots & \cdots & 0 \\
    0 & \ddots & \ddots & \ddots & \ddots & \vdots \\
    \vdots & \ddots & 1 & \ddots & \ddots & \vdots\\
    \vdots & \ddots & m_{k+1, k} & \ddots & \ddots & \vdots\\
    \vdots & \ddots& \vdots & \ddots & \ddots & 0 \\
    0 & \cdots & m_{n, k} & \cdots & \cdots & 1
\end{bmatrix}.
$$

Thus we let

$$
L_1^{-1}L_2^{-1}\dots L_{n-1}^{-1} = 
\begin{bmatrix}
    1 & 0 & \cdots & \cdots & \cdots & 0 \\
    m_{2,1} & 1 & \ddots & \ddots & \ddots & \vdots \\
    \vdots & \ddots & 1 & \ddots & \ddots & \vdots\\
    \vdots & \ddots & \ddots & \ddots & \ddots & \vdots\\
    \vdots & \ddots &\ddots& \ddots & 1 & 0\\
    m_{n,1} & \cdots & \cdots & \cdots & m_{n, n-1} & 1
\end{bmatrix}
= L,
$$

and

$$
U = \begin{bmatrix}
    a^{(1)}_{11} & a^{(1)}_{12} & \cdots & a^{(1)}_{1n} \\
    0 & a^{(2)}_{22} & \cdots & a^{(2)}_{2n} \\
    \vdots & \ddots & \ddots & \vdots \\
    0 & \cdots & 0 & a^{(n)}_{nn} \\
\end{bmatrix}.
$$

Then we get

$$
    A = LU.
$$

!!! theorem "Theorem 6.0"
    If Gaussian elimination can be performed on the linear system $A\mathbf{x} = \mathbf{b}$ *without row interchanges*, then the matrix $A$ can be factored into the product of **a lower-triangular matrix** $L$ and **an upper-triangular matrix** $U$ .
    
    If $L$ has to be **unitary**, then the factorization is **unique**.


## Special Types of Matrices

### Strictly Diagonally Dominant Matrix 严格主对角占优矩阵

!!! definition "Definition 6.0"
    The $n \times n$ matrix $A$ is said to be **strictly diagnoally dominant** when

    $$
        |a_{ii}| \gt \sum\limits_{\substack{j=1 \\ j\ne i}}^{n}|a_{ij}|,\text{ for each } i = 1, \dots, n.
    $$

!!! theorem "Theorem 6.1"
    A strictly diagonally dominant matrix is **nonsingular**. And Gaussian elimination can be performed **without** row or column interchanges, and computations will be **stable** with respect to the growth of roundoff errors.（满秩、无需交换行列、误差稳定）

### Positive Definite Matrix 正定矩阵

??? definition "Definition 6.1 (Recap)"
    A matrix $A$ is **positive definite** if it's **symmetric** and if $\forall\ (\mathbf{0} \ne) \mathbf{x} \in \mathbb{R}^n$, $\mathbf{x}^tA\mathbf{x} > 0$.

??? theorem "Theorem 6.2"
    If $A$ is an $n \times n$ positive definite matrix, then

    - $A$ is nonsingular;
    - $a_{ii} > 0$, for each $i = 1, 2, \dots, n$;
    - $\max\limits_{1 \le k, j \le n}|a_{kj}| \le \max\limits_{1 \le i \le n}|a_{ii}|$;
    - $(a_{ij})^2 < a_{ii}a_{jj}$, for each $i \ne j$.

#### Choleski's Method (LDLt factorization)

Further decompose $U$ to $D\tilde U$.

<div align="center">
	<img src="../Pic/chap6_0.png" alt="chap6_0 " style="width:500px"/>
</div>

$A$ is symmetric $\Rightarrow$ $L = \tilde U^t$.

Thus

$$
    A = LU = LD\tilde U = LDL^t.\ \ (下三角矩阵乘对角矩阵再乘其转置)
$$

Let

$$
D^{1/2} = 
\begin{bmatrix}
    \sqrt{u_{11}} & & & \\
    & \sqrt{u_{22}} & & \\
    & & \ddots & \\
    & & & \sqrt{u_{nn}}
\end{bmatrix},
$$

and $\widetilde{L} = LD^{1/2}$.

Then

$$
    A = \tilde L \tilde L^t.\ \ (下三角矩阵乘其转置)
$$

### Tridiagonal Linear System 三对角矩阵

!!! definition "Definition 6.2"
    An $n \times n$ matrix $A$ is called a **band matrix** if $\exists\ p, q$ $(1 < p, q < n)$, s.t. whenever $i + p \le j$ or $j + q \le i$, $a_{ij} = 0$. And $w = p + q - 1$ is called the **bandwidth**.

    Specially, if $p = q = 2$, then $A$ is called **tridiagonal**, with the following form,

    $$
    \begin{bmatrix}
        b_1 & c_1 & & & \\
        a_2 & b_2 & c_2 & & \\
        & \ddots & \ddots & \ddots \\
        & & a_{n-1} & b_{n-1} & c_{n-1} \\
        & & & a_n & b_n \\
    \end{bmatrix}
    $$

#### Crout Factorization

$$
A = LU = 
\begin{bmatrix}
    l_{11} \\
    l_{21} & l_{22} \\
    & \ddots & \ddots \\
    & & \ddots & \ddots \\
    & & & l_{n, n- 1} & l_{n, n}
\end{bmatrix}
\begin{bmatrix}
    1 & u_{12}\\
    & 1 & u_{23} \\
    & & \ddots & \ddots \\
    & & & \ddots & u_{n-1,n}\\
    & & & & 1 
\end{bmatrix}.
$$

the time complexity is $O(N)$.