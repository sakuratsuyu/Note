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
x' &= ax + by + c \\
y' &= dx + ey + f
\end{aligned}
$$

自由度 (degree of freedom) 为 **6**，所以我们需要至少 3 组点，也就是 6 个方程，以能够求解出 $a, b, c, d, e, f$.


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
1
\end{bmatrix} 
$$

$$
\begin{aligned}
x' = \frac{h_{00}x + h_{01}y + h_{02}}{h_{20}x + h_{11}y + h_{12}}
y' = \frac{h_{10}x + h_{11}y + h_{12}}{h_{20}x + h_{11}y + h_{12}}
\end{aligned}
$$

Constraint: 令 $||(h_{00}, h_{01}, \dots, h_{22})||$ (向量范数) 规定为 $1$，或者令 $h_{22}$ 为 $1$.

考虑到以上的限制条件 (constraint)，自由度 (degree of freedom) 为 **8**，所以我们需要至少 4 组点，也就是 8 个方程，以能够求解出 $h_{ij}$.

#### Summary
<div align="center">
	<img src="../Pic/lec6_0.png" alt="lec6_0" style="width:600px"/>
</div>

### Implementation

出于方便和可操作性，我们需要一个表征整体翘曲的函数 $T$ 而不是对每个像素点采取不同的翘曲策略.

#### Forward Warping (Not so good)

假设图像函数 $f:(x, y) \rightarrow (r, g, b)$ 经过了变换 $T: (x, y) \rightarrow (x', y')$ 得到新的图像函数 $g:(x', y') \rightarrow (r, g, b)$.

<div align="center">
	<img src="../Pic/lec6_1.png" alt="lec6_1" style="width:600px"/>
</div>

!!! question "If the transformed pixed lands inside the pixels"
	<div align="center">
		<img src="../Pic/lec6_2.png" alt="lec6_2" style="width:600px"/>
	</div>
	- Quite complicated to solve it.

#### Inverse Warping

Why not consider inversely?

<div align="center">
	<img src="../Pic/lec6_3.png" alt="lec6_3" style="width:600px"/>
</div>

!!! question "If the transformed pixed lands inside the pixels"
	<div align="center">
		<img src="../Pic/lec6_4.png" alt="lec6_4" style="width:600px"/>
	</div>

	**Solution** :fontawesome-solid-check: [2D Interpolation!](../3_Image_Processing/#2d-interpolation)

## Image Stitching

$$
\begin{bmatrix} x' \\ y' \\ 1 \end{bmatrix}
\cong T
\begin{bmatrix} x \\ y \\ 1 \end{bmatrix}
$$

### [Image Matching](../5_Image_Matching_and_Motion_Estimation/#image-matching)

通过图像匹配得到匹配点，每个匹配点可以提供一个以上形式的矩阵乘法等式.

### Find $T$ for Image Wraping

!!! plane ""
	### Affine Transformations
	
	对于每个匹配，
	
	$$
	\begin{aligned}
	x' = ax + by + c \\
	y' = dx + ey + f
	\end{aligned}
	$$
	
	矩阵形式为
	
	$$
	\begin{bmatrix} x' \\ y' \end{bmatrix}
	= 
	\begin{bmatrix} x & y & 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & x & y & 1 \end{bmatrix}
	\begin{bmatrix} a \\ b \\ c \\ d \\ e \\ f \end{bmatrix}
	$$
	
	对于 $n$ 个匹配，得到以下方程组
	
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
	\end{bmatrix}
	$$
	
	也即
	
	$$
	\mathbf{A}_{2n \times 6} \times \mathbf{t}_{6 \times 1} = \mathbf{b}_{2n \times 1}
	$$
	
	!!! note
		虽然选择 3 组点是能够解出 $a, b, c, d, e, f$ 的最少数量，但是很可能存在部分行是线性相关从而导致奇异矩阵，退化为没有唯一解.
		
		 所以为了能够得到 $a, b, c, d, e, f$ 的值，采用的方式是取较多的点然后通过最小二乘法计算，也即让 $\mathbf{t}$ 最小化 $||\mathbf{A} \mathbf{t} - \mathbf{b}||$.
	
	!!! success "Method of Least Square"
		$$
		\begin{aligned}
		\mathbf{A^{T}At} &= \mathbf{A^{T}b} \\
		t &= \mathbf{A^{T}A^{-1}A^{T}b}
		\end{aligned}
		$$

!!! plane ""
	### Projective Transformations
	
	类似地，对于每个匹配，
	
	$$
	\begin{aligned}
	x_i'(h_{20}x_i + h_{21} y_i + h_{22}) = h_{00}x_i + h_{01}y_i + h_{02} \\
	y_i'(h_{20}x_i + h_{21} y_i + h_{22}) = h_{10}x_i + h_{11}y_i + h_{12} \\
	\end{aligned}
	$$
	
	矩阵形式为
	
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
	
	对于 $n$ 个匹配，得到以下方程组
	
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
	\end{bmatrix}
	$$
	
	也即
	
	$$
	\mathbf{A}_{2n \times 9} \times \mathbf{t}_{9 \times 1} = \mathbf{b}_{2n \times 1}
	$$
	
	同样地，我们要最小化 $||\mathbf{Ah - 0}|| = \mathbf{||Ah||}$.
	
	!!! tip "Contraint: $||\mathbf{h}|| = 1$"
		如果使用的是向量范数为 $1$ 的限制，那么我们只需要确定 $\mathbf{h}$ 的方向 $\mathbf{\hat h}$.
		
		数学上可以证明解 $\mathbf{\hat h}$ 是 $\mathbf{A^{T}A}$ 最小特征值对应的特征向量.

### Robustness

!!! question "Outliers"
	图像匹配也不是完美的，可能有部分错误的匹配点成为孤立点 (outliner).

!!! success "Solution: [RANSAC](../4_Model_Fitting_and_Optimization/?h=ransa#ransac-random-sample-concensus)"
	- 每次随机取 $s$ 组匹配点.
	- 通过选取的匹配点计算出变换矩阵 $T$.
	- 在所有的匹配点中，统计在一定误差范围内符合变换 $T$ 的点 (inlier) 的数量作为得分.
	- 重复 $N$ 次，取得分最高的变换 $T_0$.
	- **(Better Step)** 对所有大致符合变换 $T_0$ 的匹配点再次计算一个平均的变换矩阵 $T$.

## Summary

How to make image stitching?

1. Input Images.
2. Feature Matching.
3. Compute transformation matrices $T$ with RANSAC.
4. Warp image 2 to image 1.

!!! info "Extension: Panaroma and Cylindrical Projection"
	<div align="center">
		<img src="../Pic/lec6_5.png" alt="lec6_5" style="width:600px"/>
	</div>
	!!! bug "Problem: Drift"
		<div align="center">
			<img src="../Pic/lec6_6.png" alt="lec6_6" style="width:600px"/>
		</div>
	!!! success "Solution"
		- Small vertical errors accumulate over time.
		- Apply correction s.t. the sum of drift is 0.
		
		也就是拍摄全景图时尽可能减少上下抖动.