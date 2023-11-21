# Lecture 6 Image Stitching

## Image Warping

!!! info

	- Image filtering changes **intensity** of image.
	- Image warping (翘曲) changes **shape** of image.

### 2D Transformations

!!! plane ""
	#### Affine Transformations 仿射变换

	$$
	\begin{bmatrix}
	x' \\
	y' \\
	1
	\end{bmatrix}
	=
	\begin{bmatrix}
	a & b & c \\
	d & e & f \\
	0 & 0 & 1
	\end{bmatrix}
	\begin{bmatrix}
	x \\
	y \\
	1
	\end{bmatrix} 
	$$

	$$
	\begin{aligned}
	x' &= ax + by + c, \\
	y' &= dx + ey + f.
	\end{aligned}
	$$

	For these equations, the **degree of freedom (自由度)** is $6$, so we need *at least* $6$ equations, which is $3$ pairs of points, to solve out $a, b, c, d, e, f$.

!!! plane ""
	#### Projective Transformation (Homography) 单应变换

	$$
	\begin{bmatrix}
		x' \\
		y' \\
		1
	\end{bmatrix}
	\cong
	\begin{bmatrix}
		h_{00} & h_{01} & h_{02} \\
		h_{10} & h_{11} & h_{12} \\
		h_{20} & h_{21} & h_{22} \\
	\end{bmatrix}
	\begin{bmatrix}
		x \\
		y \\
		1.
	\end{bmatrix} 
	$$

	$$
	\begin{aligned}
		x' = \frac{h_{00}x + h_{01}y + h_{02}}{h_{20}x + h_{11}y + h_{12}}, \\
		y' = \frac{h_{10}x + h_{11}y + h_{12}}{h_{20}x + h_{11}y + h_{12}}.
	\end{aligned}
	$$

	By convention, we have a **constraint** of one of the two options below:
	
	- The vector norm (向量范数) $||(h_{00}, h_{01}, \dots, h_{22})^T||$ is $1$.
	- $h_{22} = 1$.

	Consider the constraint above, for these equation, the degree of freedom is **8**, so we need *at least* $8$ equations, namely $4$ pairs of points, to solve out $h_{ij}$.

#### Summary of Different Transformations

<div align="center">
	<img src="../imgs/lec6_0.png" alt="lec6_0" style="width:600px"/>
</div>

### Implementation

For convenience and maneuverability, we need a function that implies the general warping instead of different warping functions at different pixels.

#### Forward Warping (Not so good)

Suppose that an image function $f:(x, y) \rightarrow (r, g, b)$ transforms with $T:(x, y) \rightarrow (x', y')$ to a new image function $g:(x', y') \rightarrow (r, g, b)$.

<div align="center">
	<img src="../imgs/lec6_1.png" alt="lec6_1" style="width:600px"/>
</div>

!!! question "If the transformed pixed lands inside the pixels"

	<div align="center">
		<img src="../imgs/lec6_2.png" alt="lec6_2" style="width:600px"/>
	</div>

	**Problem** :fontawesome-solid-robot: It's quite complicated to solve it.

#### Inverse Warping

Why not consider inversely?

<div align="center">
	<img src="../imgs/lec6_3.png" alt="lec6_3" style="width:600px"/>
</div>

!!! question "If the transformed pixed lands inside the pixels"
	<div align="center">
		<img src="../imgs/lec6_4.png" alt="lec6_4" style="width:600px"/>
	</div>

	**Solution** :fontawesome-solid-check: [2D Interpolation!](../3_Image_Processing/#2d-interpolation)

## Image Stitching

$$
\begin{bmatrix} x' \\ y' \\ 1 \end{bmatrix}
\cong T
\begin{bmatrix} x \\ y \\ 1 \end{bmatrix}.
$$

### Image Matching

By [image matching](../5_Image_Matching_and_Motion_Estimation/#image-matching) we can obtain the matching points. Each pair of matching points can provide a matrix multiplication of the form shown above.

### Find $T$ for Image Wraping

!!! plane ""
	#### Affine Transformations
	
	For each matching,
	
	$$
	\begin{aligned}
		x' = ax + by + c, \\
		y' = dx + ey + f.
	\end{aligned}
	$$
	
	The matrix form is
	
	$$
		\begin{bmatrix} x' \\ y' \end{bmatrix}
		= 
		\begin{bmatrix} x & y & 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & x & y & 1 \end{bmatrix}
		\begin{bmatrix} a \\ b \\ c \\ d \\ e \\ f \end{bmatrix}.
	$$

	For $n$ matchs, we have the following equations,
	
	$$
	\begin{bmatrix}
		x_1 & y_1 & 1 & 0 & 0 & 0 \\
		0 & 0 & 0 & x_1 & y_1 & 1 \\
		x_2 & y_2 & 1 & 0 & 0 & 0 \\
		0 & 0 & 0 & x_2 & y_2 & 1 \\
		\vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\
		x_n & y_n & 1 & 0 & 0 & 0 \\
		0 & 0 & 0 & x_n & y_n & 1 \\
	\end{bmatrix}
	\begin{bmatrix} a \\ b \\ c \\ d \\ e \\ f \end{bmatrix}
	= 
	\begin{bmatrix}
		x_1' \\
		y_1' \\
		x_2' \\
		y_2' \\
		\vdots \\
		x_n' \\
		y_n'
	\end{bmatrix},
	$$
	
	namely,
	
	$$
	\mathbf{A}_{2n \times 6} \times \mathbf{t}_{6 \times 1} = \mathbf{b}_{2n \times 1}.
	$$
	
	!!! note
		Although $3$ pairs are the least number to solve out $a, b, c, d, e, f$, there may be some linear dependent equations, which leads to a nonsingular matrix and degenerates the case that there is no unique solution.
		
		Thus, in order to get the value of $a, b, c, d, e, f$, the most used method is sampling more points and calculate by MSE, namely determining $t$ to minimize $||\mathbf{A} \mathbf{t} - \mathbf{b}||$.
	
	!!! success "Method of Least Square"
		$$
		\begin{aligned}
			\mathbf{A^{T}At} &= \mathbf{A^{T}b}, \\
			t &= \mathbf{A^{T}A^{-1}A^{T}b}.
		\end{aligned}
		$$

!!! plane ""
	#### Projective Transformations

	Similarly, for each matching,
	
	$$
	\begin{aligned}
		x_i'(h_{20}x_i + h_{21} y_i + h_{22}) = h_{00}x_i + h_{01}y_i + h_{02}, \\
		y_i'(h_{20}x_i + h_{21} y_i + h_{22}) = h_{10}x_i + h_{11}y_i + h_{12}.
	\end{aligned}
	$$
	
	The matrix form is
	
	$$
	\begin{bmatrix}
		x_i & y_i & 1 & 0 & 0 & 0 & -x_i'x_i & -x_i'y_i & -x_i'\\
		0 & 0 & 0 & x_i & y_i & 1 & -y_i'x_i & -y_i'y_i & -y_i'
	\end{bmatrix}
	\begin{bmatrix}
		h_{00} \\ h_{01} \\ h_{02} \\ h_{10} \\ h_{11} \\ h_{12} \\ h_{20} \\ h_{21} \\ h_{22}
	\end{bmatrix}
	=
	\begin{bmatrix}
		0 \\ 0
	\end{bmatrix}
	$$

	For $n$ matchs, we have the following equations,
	
	$$
	\begin{bmatrix}
		x_1 & y_1 & 1 & 0 & 0 & 0 \\
		0 & 0 & 0 & x_1 & y_1 & 1 \\
		x_2 & y_2 & 1 & 0 & 0 & 0 \\
		0 & 0 & 0 & x_2 & y_2 & 1 \\
		\vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\
		x_n & y_n & 1 & 0 & 0 & 0 \\
		0 & 0 & 0 & x_n & y_n & 1 \\
	\end{bmatrix}
	\begin{bmatrix} a \\ b \\ c \\ d \\ e \\ f \end{bmatrix}
	= 
	\begin{bmatrix}
		x_1' \\
		y_1' \\
		x_2' \\
		y_2' \\
		\vdots \\
		x_n' \\
		y_n'
	\end{bmatrix},
	$$
	
	namely,
	
	$$
		\mathbf{A}_{2n \times 9} \times \mathbf{t}_{9 \times 1} = \mathbf{b}_{2n \times 1}.
	$$

	Similarly, we need to minimize $||\mathbf{Ah - 0}|| = \mathbf{||Ah||}$.
	
	!!! tip "For contraint: $||\mathbf{h}|| = 1$"
		If we use the contraint $||\mathbf{h}|| = 1$, we only need to determine the direction of $\mathbf{h}$, denoted by $\mathbf{\hat h}$.
		
		Mathematically, we can prove that $\mathbf{\hat h}$ is the corresponding eigenvector of the minimum eigenvalue $\mathbf{A^{T}A}$.

### Robustness

!!! question "Outliers"
	Image matching is not perfect, and there may be some wrong matching points to be **outlier (孤立点)**.

!!! success "Solution: [RANSAC](../4_Model_Fitting_and_Optimization/?h=ransa#ransac-random-sample-concensus)"

	- Each time randomly select $s$ sets of matching points.
	- Calculate the transform matrix $T$ by the selected matching points.
	- Among all matching points, count the number of inliers that approximately fit the transformation $T$ in a range of error as its score.
	- Repeat $N$ times and then select the transformation $T_0$ that has the maximum score.
	- **(Better Step)** For all matching points that approximately fit the transformation $T_0$, calculate an average transform matrix $T$.

## Summary

How to make image stitching?

1. Input Images.
2. Feature Matching.
3. Compute transformation matrices $T$ with RANSAC.
4. Warp image 2 to image 1.

!!! info "Extension: Panaroma and Cylindrical Projection"

	<div align="center">
		<img src="../imgs/lec6_5.png" alt="lec6_5" style="width:600px"/>
	</div>

	!!! bug "Problem: Drift"

		<div align="center">
			<img src="../imgs/lec6_6.png" alt="lec6_6" style="width:600px"/>
		</div>

	!!! success "Solution"
		- Small vertical errors accumulate over time.
		- Apply correction s.t. the sum of drift is 0.
		
		Namely reduce the up and down shake when capturing panoroma.