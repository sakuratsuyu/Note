# Chapter 9 | Approximating Eigenvalues

## Power Method

The Power Method is an *iterative* technique used to determine the **dominant eigenvalue** of a matrix (the eigenvalue with the largest magnitude).

Suppose $A \in M_n(\mathbb{R})$ with eigenvalues satisfying $|\lambda_1| \gt |\lambda_2| \ge \dots \ge |\lambda_n|$ and their corresponding **linearly independent** eigenvectors $\mathbf{v}_\mathbf{1}, \dots, \mathbf{v}_\mathbf{n}$.

!!! note "Original Method"
    1. Start from any $\mathbf{x}^{(0)} \ne \mathbf{0}$ and $(\mathbf{x}^{(0)}, \mathbf{v}_\mathbf{1}) \ne 0$, and suppose $\mathbf{x}^{(0)} = \sum\limits_{j = 1}^n\beta_j\mathbf{v}_\mathbf{j}$, $\beta_1 \ne 0.$
    2. $\mathbf{x}^{(k)} = A \mathbf{x}^{(k - 1)} = \sum\limits_{j = 1}^n\beta_j\lambda_j^k\mathbf{v}_\mathbf{j} = \lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}\ \overset{k \rightarrow \infty}{=\!=\!=\!=}\ \lambda_1^k\beta_1\mathbf{v}_\mathbf{1}$.
    3. $A\mathbf{x}^{(k)} \approx \lambda_1^k\beta_1A\mathbf{v}_\mathbf{1} \approx \lambda_1\mathbf{x}^{(k)}$, thus

    $$
        \lambda_1 = \frac{\mathbf{x}^{(k + 1)}_i}{\mathbf{x}^{(k)}_i}, \mathbf{v}_\mathbf{1} = \frac{\mathbf{x}^{(k)}}{\lambda_1^k\beta_1}.
    $$

**Motivation for Normalization:** In the original method, if $|\lambda| > 1$ then $\mathbf{x}^{(k)}$ diverges. If $|\lambda| < 1$ then $\mathbf{x}^{(k)}$ converges to 0. Both cases are not suitable for actual computing. Thus we need normalization to make sure $||\mathbf{x}||_\infty = 1$ at each step to guarantee the *stableness*.

!!! success "Normalization"

    Let $\mathbf{u}^{(k-1)} = \frac{\mathbf{x}^{(k-1)}}{||\mathbf{x}^{(k-1)}||_\infty}, 
    \mathbf{x}^{(k)} = A\mathbf{u}^{(k - 1)}$,

    then
    
    $$
    \begin{align}
        & \mathbf{u}^{(k)} =
        \frac{\mathbf{x}^{(k)}}{||\mathbf{x}^{(k)}||_\infty} =
        \frac{\lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}}{\left|\left|\lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}\right|\right|_\infty}
        \ \overset{k \rightarrow \infty}{=\!=\!=\!=}\ \frac{\mathbf{v}_\mathbf{1}}{||\mathbf{v}_\mathbf{1}||_\infty}
        \\
        & \mathbf{x}^{(k)} =
        \frac{A^k\mathbf{x}_\mathbf{0}}{||A^{k - 1}\mathbf{x}_\mathbf{0}||} =
        \frac{\lambda_1^k \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\mathbf{v}_\mathbf{j}}{\left|\left|\lambda_1^{k - 1} \sum\limits_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^{k - 1}\mathbf{v}_\mathbf{j}\right|\right|_\infty} \ \overset{k \rightarrow \infty}{=\!=\!=\!=}\ 
        \lambda_1 \frac{\mathbf{v}_\mathbf{1}}{||\mathbf{v}_\mathbf{1}||_\infty}=\lambda_1 \mathbf{u}^{(k)}.
    \end{align}
    $$

    Thus 
    
    $$
        \lambda_1 = \frac{\mathbf{x}_i^{(k)}}{\mathbf{u}_i^{(k)}}, \hat{\mathbf{v}_\mathbf{1}} = \frac{\mathbf{v}_\mathbf{1}}{||\mathbf{v}_\mathbf{1}||_\infty}= \mathbf{u}^{(k)}.
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

Examine $\textbf{x}^{(k)} = \lambda_1^k \sum_{j = 1}^n\beta_j\left(\frac{\lambda_j}{\lambda_1}\right)^k\textbf{v}_\textbf{j}$> We find that $\left(\frac{\lambda_j}{\lambda_1}\right)$ determines the rate of convergence, especially $\left|\frac{\lambda_2}{\lambda_1}\right|$.

**Target:** Make $\left|\frac{\lambda_2}{\lambda_1}\right|$ as small as possible.

??? example
    Let $p = \frac12 (\lambda_2 + \lambda_n)$, and $B = A - pI$, then $B$ has the eigenvalues

    $$
        \lambda_1 - p, \lambda_2 - p, \dots, \lambda_n - p.
    $$

    And since

    $$
        \left|\frac{\lambda_2 - p}{\lambda_1 - p}\right| < \left|\frac{\lambda_2}{\lambda_1}\right|,
    $$

    the iteration for finding the eigenvalues of $B$ converges much faster than that of $A$.

    But how to find $p$? ...

### Inverse Power Method

If $A$ has  eigenvalues satisfying $|\lambda_1| \ge |\lambda_2| \ge \dots \gt |\lambda_n|$, then $A^{-1}$ has

$$
    \left|\frac{1}{\lambda_n}\right| \gt \left|\frac{1}{\lambda_{n-1}}\right| \ge \cdots \ge \left|\frac{1}{\lambda_1}\right|.
$$

The dominant eigenvalue of $A^{-1}$ is the eigenvalue with the **smallest magnitude** of $A$.

!!! success "A way to find eigenvalue $\lambda$ closest to a given value $p$"
    
    Use power method for matrix $(A - qI)^{-1}$, which has the eigenvalues

    $$
        \left|\frac{1}{\lambda_1 - q}\right| \gt \left|\frac{1}{\lambda_2 - q}\right| \ge \cdots \ge \left|\frac{1}{\lambda_n - q}\right|.
    $$

    where $\lambda_1$ is the closest to $p$.