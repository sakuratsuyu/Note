# Chapter 9 | Approximating Eigenvalues

## Power Method

The Power Method is an *iterative* technique used to determine the **dominant eigenvalue** of a matrix (the eigenvalue with the largest magnitude).

Suppose $A \in M_n(\mathbb{R})$ with eigenvalues satisfying $|\lambda_1| \gt |\lambda_2| \ge \dots \ge |\lambda_n|$ and their corresponding **linearly independent** eigenvectors $\mathbf{v}_\mathbf{1}, \dots, \mathbf{v}_\mathbf{n}$.

!!! note "Original Method"
    **Step.1** Start from any $\mathbf{x}^{(0)} \ne \mathbf{0}$ and $(\mathbf{x}^{(0)}, \mathbf{v}_\mathbf{1}) \ne 0$, and suppose $\mathbf{x}^{(0)} = \sum\limits_{j = 1}^n\beta_j\mathbf{v}_\mathbf{j}$, $\beta_1 \ne 0.$

    **Step.2** $\mathbf{x}^{(k)} = A \mathbf{x}^{(k - 1)} = \sum\limits_{j = 1}^n\beta_j\lambda_j^k\mathbf{v}_\mathbf{j} = \lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}\ \overset{k \rightarrow \infty}{=\!=\!=\!=}\ \lambda_1^k\beta_1\mathbf{v}_\mathbf{1}$.

    **Step.3** $A\mathbf{x}^{(k)} \approx \lambda_1^k\beta_1A\mathbf{v}_\mathbf{1} \approx \lambda_1\mathbf{x}^{(k)}$, thus

    $$
        \lambda_1 = \frac{\mathbf{x}^{(k + 1)}_i}{\mathbf{x}^{(k)}_i}, \mathbf{v}_\mathbf{1} = \frac{\mathbf{x}^{(k)}}{\lambda_1^k\beta_1}.
    $$

**Motivation for Normalization:** In the original method, if $|\lambda| > 1$ then $\mathbf{x}^{(k)}$ diverges. If $|\lambda| < 1$ then $\mathbf{x}^{(k)}$ converges to $0$. Both cases are not suitable for actual computing. Thus we need normalization to make sure $||\mathbf{x}||_\infty = 1$ at each step to guarantee the *stability*.

!!! success "Normalization"

    Let $\mathbf{u}^{(k-1)} = \dfrac{\mathbf{x}^{(k-1)}}{||\mathbf{x}^{(k-1)}||_\infty}, 
    \mathbf{x}^{(k)} = A\mathbf{u}^{(k - 1)}$,

    then
    
    $$
    \begin{aligned}
        & \mathbf{u}^{(k)} =
        \frac{\mathbf{x}^{(k)}}{||\mathbf{x}^{(k)}||_\infty} =
        \frac{\lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}}{\left|\left|\lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}\right|\right|_\infty}
        \ \overset{k \rightarrow \infty}{=\!=\!=\!=}\ \frac{\mathbf{v}_\mathbf{1}}{||\mathbf{v}_\mathbf{1}||_\infty},
        \\
        & \mathbf{x}^{(k)} =
        \frac{A^k\mathbf{x}_\mathbf{0}}{||A^{k - 1}\mathbf{x}_\mathbf{0}||} =
        \frac{\lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}}{\left|\left|\lambda_1^{k - 1} \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^{k - 1}\mathbf{v}_\mathbf{j}\right|\right|_\infty} \ \overset{k \rightarrow \infty}{=\!=\!=\!=}\ 
        \lambda_1 \frac{\mathbf{v}_\mathbf{1}}{||\mathbf{v}_\mathbf{1}||_\infty}=\lambda_1 \mathbf{u}^{(k)}.
    \end{aligned}
    $$

    Thus 
    
    $$
    \begin{aligned}
        & \lambda_1 = \frac{\mathbf{x}_i^{(k)}}{\mathbf{u}_i^{(k)}},\ \ \text{ or more directly }, \lambda_1 = \mathbf{x}^{(k)}_{p_k},\ \ \text{ where } \mathbf{u}^{(k)}_{p_k} = 1 = ||\mathbf{u}^{(k)}||_\infty, \\
        & \hat{\mathbf{v}_\mathbf{1}} = \frac{\mathbf{v}_\mathbf{1}}{||\mathbf{v}_\mathbf{1}||_\infty}= \mathbf{u}^{(k)}.
    \end{aligned}
    $$

!!! tip "Remark"
    - For multiple eigenvalues $\lambda_1 = \lambda_2 = \dots = \lambda_r$,

    $$
        \mathbf{x}^{(k)} = \lambda_1^k\left(
        \sum_{j = 1}^r\beta_j\mathbf{v}_\mathbf{j} +
        \sum_{j = r + 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j} 
        \right)\ \overset{k \rightarrow \infty}{=\!=\!=\!=}\ 
        \lambda_1^k\sum_{j = 1}^r\beta_j\mathbf{v}_\mathbf{j}
    $$

    - The method fails to converge if $\lambda_1 = -\lambda_2$.
    - [Aitken's $\Delta^2$ procedure](../Chap_2/#aitkens-delta2-method) can be used to speed up the convergence.

### Rate of Convergence

Examine $\textbf{x}^{(k)} = \lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\dfrac{\lambda_j}{\lambda_1}\right)^k\textbf{v}_\textbf{j}$. We find that $\left(\dfrac{\lambda_j}{\lambda_1}\right)^k$ determines the rate of convergence, especially $\left|\dfrac{\lambda_2}{\lambda_1}\right|^k$.

Thus, suppose

$$
    \mu^{(k)} = \mathbf{x}^{(k)}_{p_k},\ \ \text{ where } \mathbf{u}^{(k)}_{p_k} = 1 = ||\mathbf{u}^{(k)}||_\infty, \\
$$

Then there is a constant $L$, s.t. for some large $m$,

$$
    |\mu^{(m)} - \lambda_1| \approx L \left|\frac{\lambda_2}{\lambda_1}\right|^m,
$$

which implies that

$$
    \lim\limits_{m \rightarrow \infty} \frac{|\mu^{(m + 1)} - \lambda_1|}{|\mu^{(m)} - \lambda_1|} \approx \left|\frac{\lambda_2}{\lambda_1}\right| < 1.
$$

Hence the seqence $\{\mu^{(m)}\}$ converges **linearly** to $\lambda_1$ and Aitken's $\Delta^2$ procedure can be applied.

!!! success "Aitken's $\Delta^2$ procedure"
    Initially set $\mu_0 = 0$, $\mu_1 = 0$.

    For each step $k$,

    - set $\mu = \mathbf{x}^{(k)}_p$, where $\mathbf{u}^{(k - 1)}_p = 1$.
    - set the predicted eigenvalue to $\lambda_1$ be
    
    $$
        \hat\mu = \mu_0 - \frac{(\mu_1-\mu_0)^2}{\mu - 2\mu_1 + \mu_0}.
    $$

    - set $\mu_0 = \mu_1$, $\mu_1 = \mu$.

**Target:** Make $\left|\dfrac{\lambda_2}{\lambda_1}\right|$ as small as possible.

??? example
    Let $p = \dfrac12 (\lambda_2 + \lambda_n)$, and $B = A - pI$, then $B$ has the eigenvalues

    $$
        \lambda_1 - p, \lambda_2 - p, \dots, \lambda_n - p.
    $$

    And since

    $$
        \left|\frac{\lambda_2 - p}{\lambda_1 - p}\right| < \left|\frac{\lambda_2}{\lambda_1}\right|,
    $$

    the iteration for finding the eigenvalues of $B$ converges much faster than that of $A$.

    But how to find $p$ ...?

### Inverse Power Method

If $A$ has  eigenvalues satisfying $|\lambda_1| \ge |\lambda_2| \ge \dots \gt |\lambda_n|$, then $A^{-1}$ has

$$
    \left|\frac{1}{\lambda_n}\right| \gt \left|\frac{1}{\lambda_{n-1}}\right| \ge \cdots \ge \left|\frac{1}{\lambda_1}\right|.
$$

The dominant eigenvalue of $A^{-1}$ is the eigenvalue with the **smallest magnitude** of $A$.

!!! success "A way to find eigenvalue $\lambda$ closest to a given value $q$"
    
    Use power method for matrix $(A - qI)^{-1}$, which has the eigenvalues

    $$
        \left|\frac{1}{\lambda_1 - q}\right| \gt \left|\frac{1}{\lambda_2 - q}\right| \ge \cdots \ge \left|\frac{1}{\lambda_n - q}\right|.
    $$

    where $\lambda_1$ is the closest to $q$.

Also, inverse power method can sometimes accelerate to solve $\lambda_1$ of $A$. By initialize $q$ with

$$
    q =\frac{\mathbf{x}^{(0)t}A\mathbf{x}^{(0)}}{\mathbf{x}^{(0)t}\mathbf{x}^{(0)}}.
$$

This choice is considered by the property of eigenvalue $\lambda$ if $\mathbf{x}$ is an eigenvector of $A$.

$$
    \lambda =\frac{\mathbf{x}^{t}A\mathbf{x}}{\mathbf{x}^{t}\mathbf{x}} = \frac{\mathbf{x}^{t}A\mathbf{x}}{||\mathbf{x}||^2_2}.
$$

### Wielandt Deflation

Our target is now to solve the eigenvalue of the second largest magnitude associated with its eigenvector. We introduce **deflation techniques** here, which forming a new matrix $B$ with eigenvalue $0, \lambda_2, \dots, \lambda_n$, where $\lambda_1$ is replaced by $0$.

!!! theorem "Theorem 9.0"
    Suppose $\lambda_1, \dots, \lambda_n$ are eigenvalues of $A$ associated with eigenvectors $\mathbf{v}^{(1)}, \dots, \mathbf{v}^{(n)}$, and $\lambda_1$ has multiplicity $1$. Let $\mathbf{x}$ be a vector with $\mathbf{x}^{t}\mathbf{v}^{(1)} = 1$. Then the matrix

    $$
        B = A - \lambda_1\mathbf{v}^{(1)}\mathbf{x}^t
    $$

    has eigenvalues $0, \lambda_2, \dots, \lambda_n$ with associated eigenvectors $\mathbf{v}^{(1)}, \mathbf{w}^{(2)}, \dots, \mathbf{w}^{(n)}$, where $\mathbf{v}^{(i)}$ and $\mathbf{w}^{(i)}$ are related by the equation

    $$
        \mathbf{v}^{(i)} = (\lambda_i - \lambda_1) \mathbf{w}^{(i)} + \lambda_1(\mathbf{x}^t\mathbf{w}^{(i)})\mathbf{v}^{(1)}.
    $$

With the **Theorem 9.0**, the only thing we need to do is to choose vector $\mathbf{x}$. **Wielandt deflation** chooses $\mathbf{x}$ by the following formula.

$$
    \mathbf{x} = \frac{1}{\lambda_1 v_i^{(1)}}(a_{i1}, \dots, a_{in})^t,
$$

where $v_i^{(1)}$ is a nonzero coordinate of the eigenvector $\mathbf{v}^{(1)}$ and $a_{i1}, \dots a_{in}$ are the entries of *i*-th row of $A$. It's easy to verify that

$$
    \mathbf{x}^t\mathbf{v}^{(1)} = \frac{1}{\lambda_1 v_i^{(1)}}(\lambda_1 v_i^{(1)}) = 1.
$$

Moreover, by this definition, the *i*-th row of $B$ consists *entirely of zero entries*. This means that the *i*-th coordinate of eigenvector $\mathbf{w}$ is $0$. Consequently *i*-th column of $B$ makes no contribution for calculating eigenvector. Thus we can replace $B$ by an $(n - 1)\times(n - 1)$ matrix $B'$, which deletes the *i*-th row and *i*-th column and has eigenvalues $\lambda_2, \dots, \lambda_n$.

!!! success "Wielandt Deflation"
    **Step.1** Find $\lambda_1$, the eigenvalue of the largest magnitude, and its associated eigenvector $\mathbf{v}^{(1)}$ by Power Method.

    **Step.2** Choose $\mathbf{x}$ and Construct $B = A - \lambda_1 \mathbf{v}^{(1)} \mathbf{x}^{(t)}$.

    **Step.3** Delete *i*-th row and *i*-th column, which gives $B'$.

    **Step.4** Find $\lambda_2$ and its associated eigenvector $\mathbf{w}^{(2)}$ of $B'$ by Power Method.

    **Step.5** Use the formula of **Theorem 9.0** to get the associated eigenvector $\mathbf{v}^{(2)}$ of $A$.

    $$
        \mathbf{v}^{(2)} = (\lambda_2 - \lambda_1) \mathbf{w}^{(2)} + \lambda_1(\mathbf{x}^t\mathbf{w}^{(2)})\mathbf{v}^{(1)}.
    $$

!!! example
    Find the eigenvalue of the second largest magnitude and its associated eigenvector of

    $$
        A = \begin{bmatrix}
            -4 & 14 & 0 \\
            -5 & 13 & 0 \\
            -1 & 0 & 2
        \end{bmatrix}.
    $$

    **Solution.**

    **Step.1** Find $\lambda_1 = 6$ and its associated eigenvector $\mathbf{v}^{(1)} = \left(1, \dfrac{5}{7}, -\dfrac14\right)^t$ by Power Method of $A$.

    **Step.2** Choose $i = 1$, then
    
    $$
        \mathbf{x} = \frac{1}{6 \times 1}(-4, 14, 0)^t = \left(-\frac23, \frac83, 0\right)^t,
    $$

    $$
        B = A - \lambda_1\mathbf{v}^{(1)}\mathbf{x}^t = \begin{bmatrix}
            0 & 0 & 0 \\
            -\frac{15}{7} & 3 & 0 \\
            -2 & \frac72 & 2
        \end{bmatrix}.
    $$

    **Step.3** Delete the *i*-th row and *i*-th column,

    $$
        B' = \begin{bmatrix}
            3 & 0 \\
            \frac72 & 2
        \end{bmatrix}.
    $$

    **Step.4** Find $\lambda_2 = 3$ and its associated eigenvector $\mathbf{w}^{(2)'} = \left(\dfrac{2}{7}, 1\right)^t$ by Power Method of $B'$.

    **Step.5** Add the dimension of $\mathbf{w}^{(2)'}$ and $\mathbf{w}^{(2)} = \left(0, \dfrac{2}{7}, 1\right)^t$.

    $$
    \begin{aligned}
        \mathbf{v}^{(2)} &= (\lambda_2 - \lambda_1) \mathbf{w}^{(2)} + \lambda_1(\mathbf{x}^t\mathbf{w}^{(2)})\mathbf{v}^{(1)}
        \\ &= (3 - 6)\left(0, \dfrac{2}{7}, 1\right)^t + 6\left[\left(-\frac23, \frac83, 0\right)\left(0, \dfrac{2}{7}, 1\right)^t\right]\left(1, \dfrac{5}{7}, -\dfrac14\right)^t
        \\ &= (4, 2, -4)^t \overset{\text{Normalized by } ||\cdot||_\infty}{=\!=\!=\!=\!=\!=\!=\!=\!=\!=\!=\!=\!=} (1, 0.5, -1)^t.
    \end{aligned}
    $$
