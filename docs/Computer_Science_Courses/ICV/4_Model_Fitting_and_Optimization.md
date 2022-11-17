# Lecture 4 Model Fitting and Optimization

## Optimization

$$
\begin{align}
& \text{Minimize } & f_0(x) \\
& \text{Subject to } &f_i(x) & \le 0,\ i = 1, \dots, m \\
& & g_i(x) & = 0,\ i = 1,\dots, p
\end{align}
$$

-   $x \in \mathbb{R}^n$ is a vector variable to be chosen.
-   $f_0$ is the **objective function** to be minimized.
-   $f_1, \dots, f_m$ are the **inequality constraint functions.**
-   $g_1, \dots, g_p$ are the **equality constraint functions.**

### Model Fitting

A typical approach: Minimize the **Mean Square Error (MSE)**

$$
\hat x = \mathop{\arg\min}\limits_x \sum\limits_i(b_i - a_i^Tx)^2
$$

### Reasons to choose MSE

!!! note ""
	**Key Assumptions:** MSE = MLE with Gaussian noise

From **Maximum Likelihood Estimation (MLE)**, the data is assumed to be with **Gaussian noise**.

$$
b_i = a_i^Tx + n,\ n \sim G(0, \sigma)
$$

The likelihood of observing $(a_i, b_i)$ is 

$$
P[(a_i, b_i)|x] = P[b_i - a_i^Tx] \propto \exp\left(-\frac{(b_i - a_i^Tx)^2}{2\sigma^2}\right)
$$

!!! note 
	If the data points are **independent**,
	
	$$
	\begin{align}
	P[(a_1, b_1)(a_2, b_2)\dots|x] & = \prod\limits_iP[(a_i, b_i)|x] = \prod\limits_iP[b_i - a_{i^{Tx]}} \\
	& \propto \exp\left(-\frac{\sum_i(b_i - a_i^Tx)^2}{2\sigma^2}\right) = \exp\left(-\frac{||Ax-b||^2_2}{2\sigma^2}\right)
	\end{align}
	$$
	
	$$
	\begin{align}
	\hat x &= \mathop{\arg\max}\limits_x P[(a_1, b_1)(a_2, b_2)\dots|x] \\ &= \mathop{\arg\max}\limits_x \exp\left(-\frac{||Ax-b||^2_2}{2\sigma^2}\right) 
	= \mathop{\arg\min}\limits_x||Ax - b||_2^2
	\end{align}
	$$

---

## Numerical Methods

### Analytical Solution 解析解

The derivative of $||Ax-b||^2_2$ is $2A^T(Ax - b)$, let it be 0. Then we get $\hat x$ satisfying

$$
A^TAx = A^Tb
$$

But, if no analytical solution ...

### Approximate Solution 近似解

!!! success "Method"
	1.  $x \leftarrow x_0$
	2.  $\text{while not converge}$
		1.  $p \leftarrow \text{descending_direction(x)}$
		2.  $\alpha \leftarrow \text{descending_step(x)}$
		3.  $x \leftarrow x + \alpha p$

### Gradient Descent (GD)

!!! note ""
	### Steepest Descent Method
	
	$$
	F(x_0 + \Delta x) \approx F(x_0) + J_F\Delta x
	$$
	
	-   Direction
		- $\Delta x = -J^T_F$
	-   Step
		-   To minimize $\phi(a)$
		<div align="center">
			<img src="../Pic/lec4_0.png" alt="lec4_0" style="width:300px"/>
		</div>	
	
			!!! success "Backtracking Algorithm"
				-   Initialize $\alpha$ with a large value.
				-   Decrease $\alpha$ until $\phi(\alpha)\le\phi(0) + \gamma\phi'(0)\alpha$.
				
				<div align="center">
					<img src="../Pic/lec4_1.png" alt="lec4_1" style="width:300px"/>
				</div>	
	
	-   Advantage
		-   Easy to implement
		-   Perform well when far from the minimum
	
	-   Disadvantage
		-   Converge slowly when near the minimum, which wastes a lot of computation

!!! note ""
	### Newton Method
	
	$$
	F(x_0 + \Delta x) \approx F(x_0) + J_F\Delta x + \frac12\Delta x^TH_F\Delta x
	$$
	
	-  $\Delta x = -H_F^{-1}J^T_F$
	-   Advantage
		-   Faster convergence
	-   Disadvantage
		-   Hessian matrix requires a lot of computation

!!! note "" 
	### Gauss-Newton Method
	
	For $\hat x = \mathop{\arg\min}\limits_x ||Ax-b||^2_2 \overset{\Delta}{=\!=}\mathop{\arg\min}\limits_x||R(x)||^2_2$, expand $R(x)$.
	
	$$
	\begin{align}
	||R(x_k+\Delta x)||^2_2 &\approx ||R(x_k) + J_R\Delta x||^2_2 \newline 
	&= ||R(x_k)||^2_2 + 2R(x_k)^TJ_R\Delta x + \Delta x^TJ^T_RJ_R\Delta x
	\end{align}
	$$
	
	- $\Delta x = -(J_R^TJ_R)^{-1}J_R^TR(x_k) = -(J_R^TJ_R)^{-1}J_F^T$
		-   Compared to Newton Method, $J_R^TJ_R$ is used to approximate $H_F$.
	
	-   Advantage
		-   No need to compute Hessian matrix
		-   Faster to converge
	
	-   Disadvantage
		-   $J^T_RJ_R$ may be singular.

!!! note ""
	### Levenberg-Marquardt (LM)
	
	- $\Delta x = -(J_R^TJ_R + \lambda I)^{-1}J_R^TR(x_k)$
		- $\lambda \rightarrow \infty$ Steepest Descent
		- $\lambda \rightarrow 0$ Gauss-Newton
	
	-   Advantage
		-   Start and converge quickly

!!! note "Local Minimum and Global Minimum"
	<div align="center">
		<img src="../Pic/lec4_2.png" alt="lec4_2" style="width:400px"/>
	</div>	

### Convex Optimization

!!! question "Remains"

---

## Robust Estimation

**Inlier** obeys the model assumption. **Outlier** differs significantly rom the assumption.

Outlier makes MSE fail. To reduce its effect, we can use other loss functions, called **robust functions.**

<div align="center">
	<img src="../Pic/lec4_3.png" alt="lec4_3" style="width:400px"/>
</div>	

### RANSAC (Random Sample Concensus)

The most powerful method to handle outliers.

!!! note  "Key ideas"
	-   The distribution of inliers is similar while outliers differ a lot.
	-   Use data point pairs to vote
	<div align="center">
		<img src="../Pic/lec4_4.png" alt="lec4_4" style="width:500px"/>
	</div>	

### ill-posed Problem 病态问题 / 多解问题

The solution is not unique. To make it unique:

-   L2 regularization
	-   Suppress redundant variables
	-   $\min_x||Ax-b||^2_2,\ s.t. ||x||_2 \le 1$  (the same as $\min_x||Ax-b||^2_2 + \lambda||x||_2$)

-   L1 regularization
	-   Make $x$ sparse
	-   $\min_x||Ax-b||^2_2,\ s.t. ||x||_1 \le 1$  (the same as $\min_x||Ax-b||^2_2 + \lambda||x||_1$)

## Graphcut and MRF

!!! note
	**A key idea:** Neighboring pixels tend to take the same label.

!!! note ""
	Images as Graphs
	
	-   A vertex for each pixel
	-   An edge between each pair, weighted by the **affinity or similarity** between its two vertices
		-   Pixel Dissimilarity $S(\textbf{f}_i, \textbf{f}_j) = \sqrt{\sum_k(f_{ik} - f_{jk})^2}$
		-   Pixel Affinity $w(i, j) = A(\textbf{f}_i, \textbf{f}_j) = \exp\left(\frac{-1}{2\sigma^2}S(\textbf{f}_i, \textbf{f}_j)\right)$
	-   Graph Notation $G = (V, E)$
		-   $V$: a set of vertices
		-   $E$: a set of edges

### Graph Cut

Cut $C=(V_A, V_B)$ is a parition of vertices $V$ of a graph $G$ into two disjoint subsets $V_A$ and $V_B$.

**Cost of Cut** $\text{cut}(V_A, V_B) = \sum_{u\in V_A, v\in V_B} w(u, v)$

<div align="center">
	<img src="../Pic/lec4_5.png" alt="lec4_5" style="width:300px"/>
</div>	

#### Problem with min-cut

Bias to cut small, isolated segments

<div align="center">
	<img src="../Pic/lec4_6.png" alt="lec4_6" style="width:600px"/>
</div>	

**Solution: Normalized cut**

Compute how strongly verices $V_A$ are associated with vertices$V$

$$
\text{assoc}(V_A, V) =  \sum_{u\in V_A, v\in V} w(u, v)
$$

$$
\text{NCut}(V_A, V_B) = \frac{\text{cut}(V_A, V_B)}{\text{assoc}(V_A, V)} + \frac{\text{cut}(V_A, V_B)}{\text{assoc}(V_B, V)}
$$

### Markow Random Field (MRF)

Graphcut is an exception of MRF.

!!! question