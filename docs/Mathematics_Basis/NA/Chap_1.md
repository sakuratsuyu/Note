# Chapter 1 | Mathematical Preliminaries
## Error

### Truncation Error

the error involved using a truncated or finite summation.

###  Roundoff Error

the error produced when performing real number calculations. It occurs because the arithmetic performed in a machine involved numbers with a finite number of digits.

!!! note "Chopping & Rounding"
	Given a real number $y = 0.d_1d_2\dots d_kd_{k+1}\dots \times 10^N$, the floating-point representation of $y$ is $fl(y)$:

	$$
		fl(y) = \left\{
			\begin{align}
				& 0.d_1d_2\dots d_k \times 10^N, & {\tt Chopping} \\
				& {\tt chop}\left(y + 5 \times 10^{n - (k + 1)}\right). & {\tt Rounding}
			\end{align}
		\right.
	$$

!!! definition
	If $p^*$ is an approximation to $p$, then **absolute error** is $|p - p*|$ and **relative error** is $\frac{|p - p^*|}{|p|}$.

	The number $p^*$ is said to be approximate to $p$ to $t$ **significant digits* if $t$ is the largest nonnegative integer for which

	$$
		\frac{|p - p^*|}{|p|} < 5 \times 10^{-t}
	$$

??? example
	For the floating-point representation of $y$, the relative error is
	
	$$
		\left|\frac{y - fl(y)}{y}\right|.
	$$

	for chopping representation,

	$$
		\left|\frac{y - fl(y)}{y}\right| = \left|\frac{0.d_{k + 1}d_{k + 2}\dots}{0.d_1d_2\dots}\right| \times 10^{-k} \le \frac{1}{0.1} \times 10^{-k} = 10^{-k + 1}.
	$$

	for rounding representation,

	$$
		\left|\frac{y - fl(y)}{y}\right| \le \frac{0.5}{0.1} \times 10^{-k} = 0.5 \times 10^{-k + 1}.
	$$

### Effect of Error

- Subtraction may reduce significant digits. *e.g.* 0.1234 - 0.1233 = 0.001
- Division by small number of multiplication by large number magnify the abosolute error without modifying the relative error.

### Some Solutions to Reduce Error

??? example "Quadratic Formula"
	the roots of $ax^2 + bx + c = 0$ is 

	$$
		x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}.
	$$

	Sometimes $b$ is closer to $\sqrt{b^2 - 4ac}$, which may cause the subtraction to reduce significant digits. <u>An alternate way</u> is to modify the formula to

	$$
		x = \frac{-2c}{b \pm \sqrt{b^2 - 4ac}}.
	$$

	But it may cause the division by small number. So it's a **tradeoff** to use one of the two formulae above.

!!! note "Horner's Method 秦九韶算法"
	$$
	\begin{align}
		f(x) &= a_nx^n + a_{n-1}x^{n-1} + \dots + a_1x + a_0 
		\\ &= (\dots((a_nx+a_{n-1})x+a_{n-2})x+\dots+a_1)x+a_0
	\end{align}
	$$

## Stable Algorithms and Convergence

!!! definition
	An algorithm that satisfies that small changes in the initial data produce correspondingly small changes in the final results is called **stable**; otherwise it is **unstable**.  An algorithm is called **conditionally stable** if it is stable only for certain choices of initial data.

	Suppose $E_0 > 0$ denotes an initial errors, $E_n$ denotes the magnitude of an error after $n$ subsequent operations
	
	- **Linear growth of errors** $E_n \approx C n E_0$
		- unavoidable and acceptable
	- **Exponential growth of errors** $E_n \approx C^n E_0$
		- <u>unacceptable</u>

??? example
	the recursive equation $p_n = \frac{10}{3}p_{n - 1} - p_{n - 2}$ has the solution
	
	$$
		p_n = c_1 \left(\frac13\right)^n + c_23^n.
	$$

	If $p_0 = 1, p_1 = \frac13$, then the solution is

	$$
		p_n = \left(\frac13\right)^n.
	$$

	Suppose we have **five-digit rounding** representation, then $\hat p_0 = 1.0000$, $\hat p_1 = 0.33333$, and the solution is 

	$$
		\hat p_n = 1.0000 \left(\frac13\right)^n - 0.12500 \times 10^{-5} \cdot 3^n.
	$$

	Then

	$$
		p_n - \hat p_n = 0.12500 \times 10^{-5} \cdot 3^n
	$$

	grow **exponentially** with $n$.

	On the other hand, the recursive equation $p_n = 2p_{n - 1} - p_{n - 2}$ has the solution

	$$
		p_n = c_1 + c_2n
	$$

	If $p_0 = 1, p_1 = \frac13$, then the solution is

	$$
		p_n = 1 - \frac23 n.
	$$

	Suppose we have **five-digit rounding** representation, then $\hat p_0 = 1.0000$, $\hat p_1 = 0.33333$, and the solution is 

	$$
		\hat p_n = 1.0000 - 0.66667 n.
	$$

	Then

	$$
		p_n - \hat p_n = \left(0.66667 - \frac23\right) n
	$$

	grow **linearly** with $n$.

!!! tip "Error of floating-point number (IEEE 754 standard)"
	#### Range of normal representation

	Single-Precision

	- Smallest $\text{0/1\ 00000001\ 00\dots00}$
		- $\pm 1.0 \times 2^{-126} \approx \pm 1.2 \times 10^{-38}$
	- Largest $\text{0/1\ 11111110\ 11\dots11}$
		- $\pm 2.0 \times 2^{127} \approx \pm 3.4 \times 10^{38}$

	For Double-Precision, smallest $\pm 1.0 \times 2^{-1022} \approx \pm 2.2 \times 10^{-308}$, largest$\pm 2.0 \times 2^{1023} \approx \pm 1.8 \times 10^{308}$

	#### Relative precision
	- Single $2^{-23}$
		- Equivalent to $23 \times \log_{10}2 \approx 6$decimal digits of precision（6 位有效数字）
	- Double $2^{-52}$
		- Equivalent to $52 \times \log_{10}2 \approx 16$decimal digits of precision（16 位有效数字）