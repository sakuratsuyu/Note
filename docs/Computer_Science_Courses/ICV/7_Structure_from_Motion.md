# Lecture 7 Structure from Motion (SfM)

## Camera Calibration 相机标定

<div align="center">
	<img src="../Pic/lec7_0.png" alt="lec7_0" style="width:600px"/>
</div>

相机标定的过程，就是从世界坐标系向像素坐标系转换的过程. 需要注意的四个坐标系：

- **世界坐标系 (World Coordinates)**
- **相机坐标系 (Camera Coordinates)**
- **图像坐标系 (Image Plane)**
- **像素坐标系 (Image Sensor)**

其中，前两个坐标系的转换矩阵参数被称为 **相机外参**；后三个坐标系的转换矩阵参数被称为 **相机内参**.

### Principle Analysis 原理分析

#### Coordinate Transformation

从世界坐标系到相机坐标系的变换.

<div align="center">
	<img src="../Pic/lec7_1.png" alt="lec7_1" style="width:600px"/>
</div>

##### 特点

刚体变换，只有旋转和平移，对应旋转矩阵 $R$（$R$ 是 **单位正交矩阵 (Orthonormal)**) 和平移向量 $c_w$.

$$
\mathbf{x}_c = R(\mathbf{x}_w - \mathbf{c}_w) = R \mathbf{x}_w - R \mathbf{c}_w \overset{\Delta}{=\!=} R \mathbf{x}_w + \mathbf{t}, \text{ where } \mathbf{t } = -R \mathbf{c}_w.
$$

故这个变换也可以等价地用 $R$ 和 $\mathbf{t}$ 来表征.

$$
\mathbf{x}_c = \begin{bmatrix} x_c \\ y_c \\ z_c \end{bmatrix}
=
\begin{bmatrix}
r_{11} & r_{12} & r_{13} \\
r_{21} & r_{22} & r_{23} \\
r_{31} & r_{32} & r_{33} \\
\end{bmatrix}
\begin{bmatrix}
x_w \\ y_w \\ z_w
\end{bmatrix}
+
\begin{bmatrix}
t_x \\ t_y \\ t_z
\end{bmatrix}
$$

同样考虑齐次坐标系

$$
\mathbf{\tilde x}_c = \begin{bmatrix} x_c \\ y_c \\ z_c \\ 1\end{bmatrix}
=
\begin{bmatrix}
r_{11} & r_{12} & r_{13} & t_x \\
r_{21} & r_{22} & r_{23} & t_y\\
r_{31} & r_{32} & r_{33} & t_z\\
0 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
x_w \\ y_w \\ z_w \\ 1
\end{bmatrix}
$$

!!! definition  "Extrinsic Matrix (外参矩阵)"
	
	$$
	M_{ext} =
	\begin{bmatrix}
	R_{3\times 3} & \mathbf{t} \\
	\mathbf{0}_{1\times 3} & 1
	\end{bmatrix}
	=
	\begin{bmatrix}
	r_{11} & r_{12} & r_{13} & t_x \\
	r_{21} & r_{22} & r_{23} & t_y\\
	r_{31} & r_{32} & r_{33} & t_z\\
	0 & 0 & 0 & 1
	\end{bmatrix}
	$$
	
	也可以写作
	
	$$
	M_{ext} =
	\begin{bmatrix}
	R_{3\times 3} & \mathbf{t} \\
	\end{bmatrix}
	=
	\begin{bmatrix}
	r_{11} & r_{12} & r_{13} & t_x \\
	r_{21} & r_{22} & r_{23} & t_y\\
	r_{31} & r_{32} & r_{33} & t_z\\
	\end{bmatrix}
	$$

#### Perspective Projection

从相机坐标系到图像坐标系的变换.

<div align="center">
	<img src="../Pic/lec7_2.png" alt="lec7_2" style="width:400px"/>
</div>

前面几个 Lecture 中已经讨论过这一部分[内容](../2_Image_Formation/#geometric-image-formation). 此处不再赘述.

$$
\begin{bmatrix}
x_i \\ y_i \\ 1
\end{bmatrix}
\cong
\begin{bmatrix}
f & 0 & 0 & 0 \\
0 & f & 0 & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
x_c \\
y_c \\
z_c \\
1
\end{bmatrix}
$$

#### Image Plane to Image Sensor Mapping

从图像坐标系到像素坐标系的变换.

!!! note "像素点 pixel"
	需要注意的是，由于相机自身的制作工艺和要求，像素点并不一定是正方形，而是矩形，与原图像相比具有一定的**缩放**. 这一点在视频的制作中也有所体现.
	
	此外，由于图像坐标系是从中心为原点，而像素坐标系是以左上角为原点的，坐标变换还需要一定的**平移*.

<div align="center">
	<img src="../Pic/lec7_3.png" alt="lec7_3" style="width:500px"/>
</div>

$$
\begin{align}
u &= m_x f \frac{x_c}{z_c} + c_x \\
v &= m_y f \frac{y_c}{z_c} + c_y
\end{align}
$$

结合以上两个变换，记 $f_x = m_x f$, $f_y = m_y f$.

则从相机坐标系到像素坐标系的变换为

$$
\mathbf{\tilde{u}}
=
\begin{bmatrix}
u \\ v \\ w
\end{bmatrix}
\cong
\begin{bmatrix}
f_x & 0 & c_x & 0 \\
0 & f_y & c_y & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
x_c \\
y_c \\
z_c \\
1
\end{bmatrix}
$$

!!! Definition "Intrinsic Matrix (内参矩阵)"
	
	$$
	M_{int} = 
	\begin{bmatrix}
	f_x & 0 & c_x & 0 \\
	0 & f_y & c_y & 0 \\
	0 & 0 & 1 & 0
	\end{bmatrix}
	$$
	
	也可以写作
	
	$$
	K = 
	\begin{bmatrix}
	f_x & 0 & c_x \\
	0 & f_y & c_y \\
	0 & 0 & 1
	\end{bmatrix}
	$$

!!! Note "Projection Matrix $P$"
	World to Camera
	
	$$
	\begin{bmatrix} x_c \\ y_c \\ z_c \\ 1\end{bmatrix}
	=
	\begin{bmatrix}
	r_{11} & r_{12} & r_{13} & t_x \\
	r_{21} & r_{22} & r_{23} & t_y\\
	r_{31} & r_{32} & r_{33} & t_z\\
	0 & 0 & 0 & 1
	\end{bmatrix}
	\begin{bmatrix}
	x_w \\ y_w \\ z_w \\ 1
	\end{bmatrix}
	$$
	
	$$
	\mathbf{\tilde u} = M_{int}\mathbf{\tilde x}_c
	$$
	
	Camera to Pixel
	
	$$
	\begin{bmatrix}
	u \\ v \\ w
	\end{bmatrix}
	\cong
	\begin{bmatrix}
	f_x & 0 & c_x & 0 \\
	0 & f_y & c_y & 0 \\
	0 & 0 & 1 & 0
	\end{bmatrix}
	\begin{bmatrix}
	x_c \\
	y_c \\
	z_c \\
	1
	\end{bmatrix}
	$$
	
	$$
	\mathbf{\tilde x}_c = M_{ext}\mathbf{\tilde x}_w
	$$
	
	故
	
	$$
	\mathbf{\tilde u} = M_{int}M_{ext} \mathbf{\tilde x}_w = P \mathbf{\tilde x}
	$$
	
	其中，$P$ 被称为投影矩阵 (Projection Matrix).
	
	$$
	\begin{bmatrix}
	u \\ v \\ w
	\end{bmatrix}
	\cong
	\begin{bmatrix}
	p_{11} & p_{12} & p_{13} & p_{14} \\
	p_{21} & p_{22} & p_{23} & p_{24} \\
	p_{31} & p_{32} & p_{33} & p_{34} \\
	p_{41} & p_{42} & p_{43} & p_{44} \\
	\end{bmatrix}
	\begin{bmatrix}
	x_w \\
	y_w \\
	z_w \\
	1
	\end{bmatrix}
	$$

### Implemetation

#### Step 1. Capture an image of an object with known geometry.

<div align="center">
	<img src="../Pic/lec7_4.png" alt="lec7_4" style="width:300px"/>
</div>

#### Step 2. Identify correspondences (Image Matching 图像匹配) between 3D scene points and image points.

<div align="center">
	<img src="../Pic/lec7_5.png" alt="lec7_5" style="width:400px"/>
</div>

#### Step 3. For each corresponding point $i$,  we get 

$$
\begin{bmatrix}
u^{(i)} \\ v^{(i)} \\ w^{(i)}
\end{bmatrix}
\cong
\begin{bmatrix}
p_{11} & p_{12} & p_{13} & p_{14} \\
p_{21} & p_{22} & p_{23} & p_{24} \\
p_{31} & p_{32} & p_{33} & p_{34} \\
p_{41} & p_{42} & p_{43} & p_{44} \\
\end{bmatrix}
\begin{bmatrix}
x_w^{(i)} \\
y_w^{(i)} \\
z_w^{(i)} \\
1
\end{bmatrix}
$$

$$
\begin{align}
u^{(i)} &= \frac{p_{11}x_w^{(i)} + p_{12}y_w^{(i)} + p_{13}z_w^{(i)} + p_{14}}{p_{31}x_w^{(i)} + p_{32}y_w^{(i)} + p_{33}z_w^{(i)} + p_{34}} \\
v^{(i)} &= \frac{p_{21}x_w^{(i)} + p_{22}y_w^{(i)} + p_{23}z_w^{(i)} + p_{24}}{p_{31}x_w^{(i)} + p_{32}y_w^{(i)} + p_{33}z_w^{(i)} + p_{34}} \\
\end{align}
$$

#### Step 4. Rearrange.

$$
\scriptsize
\begin{bmatrix}
x_w^{(1)} & y_w^{(1)} & z_w^{(1)} & 1 & 0 & 0 & 0 & 0 & -u_1x_w^{(1)} & -u_1y_w^{(1)} & -u_1z_w^{(1)} & -u_1 \\
0 & 0 & 0 & 0 &  x_w^{(1)} & y_w^{(1)} & z_w^{(1)} & 1 & -v_1x_w^{(1)} & -v_1y_w^{(1)} & -v_1z_w^{(1)} & -v_1 \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\ 
x_w^{(i)} & y_w^{(i)} & z_w^{(i)} & 1 & 0 & 0 & 0 & 0 & -u_ix_w^{(i)} & -u_iy_w^{(i)} & -u_iz_w^{(i)} & -u_i \\
0 & 0 & 0 & 0 &  x_w^{(i)} & y_w^{(i)} & z_w^{(i)} & 1 & -v_ix_w^{(i)} & -v_iy_w^{(i)} & -v_iz_w^{(i)} & -v_i \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\ 
x_w^{(n)} & y_w^{(n)} & z_w^{(n)} & 1 & 0 & 0 & 0 & 0 & -u_nx_w^{(n)} & -u_ny_w^{(n)} & -u_nz_w^{(n)} & -u_n \\
0 & 0 & 0 & 0 &  x_w^{(n)} & y_w^{(n)} & z_w^{(n)} & 1 & -v_nx_w^{(n)} & -v_ny_w^{(n)} & -v_nz_w^{(n)} & -v_n \\
\end{bmatrix}
\begin{bmatrix}
p_{11} \\ p_{12} \\ p_{13} \\ p_{14} \\
p_{21} \\ p_{22} \\ p_{23} \\ p_{24} \\
p_{31} \\ p_{32} \\ p_{33} \\ p_{34}
\end{bmatrix}
=
\begin{bmatrix}
0 \\ 0 \\ 0 \\ 0 \\
0 \\ 0 \\ 0 \\ 0 \\
0 \\ 0 \\ 0 \\ 0
\end{bmatrix}
$$

$$
i.e.\ A \mathbf{p} = 0
$$

#### Step 5 Solve for $P$.

类似地，我们可以给出一定的限制 constraint.

- Option 1. 令 $p_{34} = 1$.
- Option 2. 令 $||p|| = 1$.

得到自由度为 $11$，至少需要 6 组点.

并同样要最小化 $||\mathbf{Ap - 0}|| = \mathbf{||Ap||}$.

同样如果使用的是向量范数为 $1$ 的限制，那么我们只需要确定 $\mathbf{p}$ 的方向 $\mathbf{\hat p}$.  且 $\mathbf{\hat p}$ 是 $\mathbf{A^{T}A}$ 最小特征值对应的特征向量.

#### Step 6 From $P$ to Answers

由

$$
\begin{bmatrix}
p_{11} \\ p_{12} \\ p_{13} \\ p_{14} \\
p_{21} \\ p_{22} \\ p_{23} \\ p_{24} \\
p_{31} \\ p_{32} \\ p_{33} \\ p_{34}
\end{bmatrix}
=
\begin{bmatrix}
f_x & 0 & c_x & 0 \\
0 & f_y & c_y & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
r_{11} & r_{12} & r_{13} & t_x \\
r_{21} & r_{22} & r_{23} & t_y\\
r_{31} & r_{32} & r_{33} & t_z\\
0 & 0 & 0 & 1
\end{bmatrix}
$$

注意到

$$
\begin{bmatrix}
p_{11} \\ p_{12} \\ p_{13} \\
p_{21} \\ p_{22} \\ p_{23} \\
p_{31} \\ p_{32} \\ p_{33}
\end{bmatrix}
=
\begin{bmatrix}
f_x & 0 & c_x \\
0 & f_y & c_y \\
0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
r_{11} & r_{12} & r_{13} \\
r_{21} & r_{22} & r_{23} \\
r_{31} & r_{32} & r_{33} \\
\end{bmatrix}
= KR
$$

其中 $K$ 是上三角矩阵 (Upper Right Triangular Matrix)， $R$ 是单位正交矩阵 (Orthonormal Matrix).

**由 QR 分解 (QR Factorization) 可知，$K$ 与 $R$ 的解是唯一的.**

再由

$$
\begin{bmatrix}
p_{14} \\ p_{24} \\ p_{34}
\end{bmatrix}
=
\begin{bmatrix}
f_x & 0 & c_x \\
0 & f_y & c_y \\
0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
t_x \\ t_y \\ t_z
\end{bmatrix}
= K \mathbf{t}
$$

故可解得

$$
\mathbf{t} = K^{-1} 
\begin{bmatrix}
p_{14} \\ p_{24} \\ p_{34}
\end{bmatrix}
$$

!!! Bug "Problem: Distortion"
	<div align="center">
		<img src="../Pic/lec7_6.png" alt="lec7_6" style="width:600px"/>
	</div>
	
	实际上相机自身会具有一定的扭曲系数，我们在此**忽略**它的影响.

!!! Info "Perspective-n-Point Problem (PnP 问题)<a name="PnP"></a>"
	弱化一下条件，假设已知相机的内参（即矩阵 $K$），求相机的外参（即矩阵 $R$ 和 $\mathbf{t}$），也即相机姿态 (camera pose).
	
	#### Direct Linear Transform (DLT)
	
	即以上在相机标定中提到的方法，先求解矩阵 $P$，再通过 $K$ 得到 $R$ 和 $\mathbf{t}$.
	
	#### P3P
	
	<div align="center">
		<img src="../Pic/lec7_7.png" alt="lec7_7" style="width:200px"/>
	</div>
	
	即已知 $a, b, c, A, B, C$ 点坐标，求 $O$ 坐标.
	
	- 至少需要 $3$ 组点
	
	??? Note "Intermediates."
		- 由余弦定理
		
		$$
		\begin{align}
		OA^2 + OB^2 - 2 OA \cdot OB \cos \angle AOB &= AB^2 \\
		OA^2 + OC^2 - 2 OB \cdot OC \cos \angle BOC &= BC^2 \\
		OA^2 + OC^2 - 2 OA \cdot OC \cos \angle AOC &= AC^2
		\end{align}
		$$
		
		- 令 $x = \frac{OA}{OC}, y = \frac{OB}{OC}, v = \frac{AB^2}{OC^2}, u = \frac{BC^2}{AB^2}, w = \frac{AC^2}{AB^2}$，化简得
		
		$$
		\begin{align}
		(1 - u)y^2 - ux^2 - cos \angle BOC y + 2uxy \cos \angle AOB + 1 &= 0 \\
		(1 - w)x^2 - wy^2 - cos \angle AOC y + 2wxy \cos \angle AOB + 1 &= 0
		\end{align}
		$$
		
		- 以上方程组是二元二次方程组 (Binary Quadratic Equation)，有四组解.
			- 其中有两组解的 $O$ 坐标在 面$ABC$ 与 面$abc$ 之间，舍去.
	
	- 还需要一组额外的点来确定唯一解，故一共需要 $4$ 组点.
	
	#### PnP
	
	- 最小化**重投影误差** (Reprojection Error)
	
	$$
	\mathop{\arg\min\limits_{R, \mathbf{t}}} \sum\limits_i ||(p_i, K(RP_i + \mathbf{t})||^2
	$$
	
	其中，$p_i$ 是投影面上的二维坐标，$P_i$ 是空间内的三维坐标.
	
	- 通过 P3P 初始化，Gauss-Newton 法优化.
	
	#### EPnP
	
	- one of the most popluar methods.
	- time complexity $O(N)$.
	- high accuracy.
	
	大致方式是通过四组控制点的线性组合求解.
	
	<div align="center">
		<img src="../Pic/lec7_8.png" alt="lec7_8" style="width:300px"/>
	</div>

## Two-frame Structure from Motion

??? info "Stereo vision 立体视觉"
	Compute 3D structure of the scene and camera poses from views (images).

<div align="center">
	<img src="../Pic/lec7_9.png" alt="lec7_9" style="width:600px"/>
</div>

Two-frame SfM 意在解决这样一个问题：已知两张图像和相机内参矩阵 ($K_l(3 \times 3)$ 与 $K_r(3 \times 3)$)，求相机的位置以及所拍摄主体的三维位置坐标.

### Principle Induction 原理推导

!!! Theorem "Epipolar Geometry 对极几何"

	对极几何描述了一个三维点 $P$ 在两个视角的二维投影 $u_l, u_r$  之间的几何关系. 并通过这个几何关系建立两个摄像机之间的变换关系（即给出矩阵 $R$ 和 $\mathbf{t}$）.
	
	<div align="center">
		<img src="../Pic/lec7_10.png" alt="lec7_10" style="width:600px"/>
	</div>

!!! Definition

- **Epipole 对极点**：一台摄像机投影在另一台摄像机中的点. 如图中的 $e_l$ 和 $e_r$. 
	- 对给定的两台摄像机，$e_l$ 和 $e_r$ 是唯一的.
- **Epipolar Plane of Scene Point P 关于 P 点的对极面**：由 Scene Point $P$ 点和两个摄像机 $O_l$ 和 $O_r$ 形成的平面. 
	- 每个 scene point 有唯一对应的对极面.
	- 对极点在对极面上.

<div align="center">
	<img src="../Pic/lec7_11.png" alt="lec7_11" style="width:600px"/>
</div>

#### Essential Matrix $E$ 基本矩阵

对于一个对极面，以下等式关系成立：

$$
\begin{align}
\mathbf{n} = \mathbf{t} \times \mathbf{x}_l \\ \\
\mathbf{x}_l \cdot (\mathbf{t} \times \mathbf{x}_l) = 0
\end{align}
$$

其中 $\mathbf{n}$ 被称为 Normal Vector.

假设右边的摄像机相对左边的摄像机进行刚体变换 + 平移，即：

$$
\begin{align}
\mathbf{x}_l &= R \mathbf{x}_r + \mathbf{t} \\ \\
\begin{bmatrix}
x_l \\ y_l \\ z_l
\end{bmatrix}
&=
\begin{bmatrix}
r_{11} & r_{12} & r_{13} \\
r_{21} & r_{22} & r_{23} \\
r_{31} & r_{32} & r_{33}
\end{bmatrix}
\begin{bmatrix}
x_r \\ y_r \\ y_r
\end{bmatrix}
+
\begin{bmatrix}
t_x \\ t_y \\ t_z
\end{bmatrix}
\end{align}
$$

进一步演绎推理，得到：

$$
\begin{align}
\begin{bmatrix}
x_l & y_l & z_l
\end{bmatrix}
\begin{bmatrix}
t_yz_l - t_zy_l \\
t_zx_l - t_xz_l \\
t_xy_l - t_yx_l
\end{bmatrix}
= 0
& \text{, Cross-product definition} \\ \\
\begin{bmatrix}
x_l & y_l & z_l
\end{bmatrix}
\underbrace{
\begin{bmatrix}
0 & -t_z & t_y \\
t_z & 0 & -t_x \\
-t_y & t_x & 0
\end{bmatrix}
}_{T_\times}
\begin{bmatrix}
x_l \\ y_l \\ z_l
\end{bmatrix}
= 0
& \text{, Matrix-vector form}
\end{align}
$$

代入变换矩阵

$$
\small
\begin{bmatrix}
x_l & y_l & z_l
\end{bmatrix}
\left(
\underbrace{
\begin{bmatrix}
0 & -t_z & t_y \\
t_z & 0 & -t_x \\
-t_y & t_x & 0
\end{bmatrix}
}_{T_\times}
\underbrace{
\begin{bmatrix}
r_{11} & r_{12} & r_{13} \\
r_{21} & r_{22} & r_{23} \\
r_{31} & r_{32} & r_{33}
\end{bmatrix}
}_{R}
\begin{bmatrix}
x_r \\ y_r \\ y_r
\end{bmatrix}
+
\underbrace{
\begin{bmatrix}
0 & -t_z & t_y \\
t_z & 0 & -t_x \\
-t_y & t_x & 0
\end{bmatrix}
\begin{bmatrix}
t_x \\ t_y \\ t_z
\end{bmatrix}
}_{\mathbf{t} \times \mathbf{t} = \mathbf{0}}
\right)
= 0
$$

$$
\begin{bmatrix}
x_l & y_l & z_l
\end{bmatrix}
\underbrace{
\begin{bmatrix}
e_{11} & e_{12} & e_{13} \\
e_{21} & e_{22} & e_{23} \\
e_{31} & e_{32} & e_{33}
\end{bmatrix}
}_{\text{Essential Matrix } E}
\begin{bmatrix}
x_r \\ y_r \\ y_r
\end{bmatrix}
\text{, where }
E = T_\times R
$$

注意到 $T_\times$ 是反对称矩阵 (skew-symmetric matrix) 而 $R$ 是单位正交矩阵 (orthonomal matrix)，由 SVD 分解 (Singule Value Decomposition)，我们可以从 $E$ 唯一分解得到 $T_\times$ 和 $R$.

#### Fundemental Matrix $F$ 本真矩阵

由投影关系以及内参矩阵 $K$，得到：

$$
\small
\begin{align}
\text{Left Camera} && \text{Right Camera}
\\
z_l 
\begin{bmatrix}
u_l \\ v_l \\ 1
\end{bmatrix}
&=
\underbrace{
\begin{bmatrix}
f_x^{(l)} & 0 & o_x^{(l)} \\
0 & f_y^{(l)} & o_y^{(l)} \\
0 & 0 & 1
\end{bmatrix}
}_{K_l}
\begin{bmatrix}
x_l \\ y_l \\ z_l
\end{bmatrix}
&
z_r 
\begin{bmatrix}
u_r \\ v_r \\ 1
\end{bmatrix}
&=
\underbrace{
\begin{bmatrix}
f_x^{(r)} & 0 & o_x^{(r)} \\
0 & f_y^{(r)} & o_y^{(r)} \\
0 & 0 & 1
\end{bmatrix}
}_{K_r}
\begin{bmatrix}
x_r \\ y_r \\ z_r
\end{bmatrix}
\\
\mathbf{x}_l^T &=
\begin{bmatrix}
u_l & v_l & 1
\end{bmatrix}
z_l (K_l^{-1})^T
& \mathbf{x}_r &= 
K_r^{-1} z_r
\begin{bmatrix}
u_r \\ v_r \\ 1
\end{bmatrix}
\end{align}
$$

代入以上得到的：

$$
\mathbf{x}^T_l E \mathbf{x}_r = 0
$$

有

$$
\require{canel}
\begin{bmatrix}
u_l & v_l & 1
\end{bmatrix}
\cancel{z_l} (K_l^{-1})^T
E
K_r^{-1} \cancel{z_r}
\begin{bmatrix}
u_r \\ v_r \\ 1
\end{bmatrix}
= 0
$$

即

$$
\begin{bmatrix}
u_l & v_l & 1
\end{bmatrix}
F
\begin{bmatrix}
u_r \\ v_r \\ 1
\end{bmatrix}
= 0
\text{, where }
E = K_l^T F K_r
$$

### Implementation 实现

#### Step 1. Find a set ($m$ pairs) of corresponding features. 找到一组（$m$ 对）匹配点.

<div align="center">
	<img src="../Pic/lec7_12.png" alt="lec7_12" style="width:500px"/>
</div>

!!! tip "Least Number of Points"
	At least **8** pairs: $(u_l^{(i)}, v_l^{(i)})$ <--> $(u_r^{(i)}, v_r^{(i)})$
	NOTE that one pair only corresponds one equation. (not the same as before)

#### Step 2. Build linear systems and solve for $F$. 建立方程组并求解矩阵 $F$.

对于每组匹配 $i$，

$$
\begin{bmatrix}
u_l^{(i)} & v_l^{(i)} & 1
\end{bmatrix}
\begin{bmatrix}
f_{11} & f_{12} & f_{13} \\
f_{21} & f_{22} & f_{23} \\
f_{31} & f_{32} & f_{33}
\end{bmatrix}
\begin{bmatrix}
u_r^{(i)} \\ v_r^{(i)} \\ 1
\end{bmatrix}
= 0
$$

展开得，

$$
\small
\left( f_{11} u_r^{(i)} + f_{12} v_r^{(i)} + f_13 \right)u_l^{(i)} +
\left( f_{21} u_r^{(i)} + f_{22} v_r^{(i)} + f_23 \right)v_l^{(i)} +
f_{31} u_r^{(i)} + f_{32} v_r^{(i)} + f_33 = 0
$$

对所有选择的点，有

$$
\small
\begin{bmatrix}
u_l^{(1)}u_r^{(1)} & u_l^{(1)}v_r^{(1)} & u_l^{(1)} & v_l^{(1)}u_r^{(1)} & v_l^{(1)}v_r^{(1)} & v_l^{(1)} & u_r^{(1)} & v_r^{(1)} & 1 \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\ 
u_l^{(i)}u_r^{(i)} & u_l^{(i)}v_r^{(i)} & u_l^{(i)} & v_l^{(i)}u_r^{(i)} & v_l^{(i)}v_r^{(i)} & v_l^{(i)} & u_r^{(i)} & v_r^{(i)} & 1 \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\ 
u_l^{(m)}u_r^{(m)} & u_l^{(m)}v_r^{(m)} & u_l^{(m)} & v_l^{(m)}u_r^{(m)} & v_l^{(m)}v_r^{(m)} & v_l^{(m)} & u_r^{(m)} & v_r^{(m)} & 1 \\
\end{bmatrix}
\begin{bmatrix}
f_{11} \\ f_{12} \\ f_{13} \\
f_{21} \\ f_{22} \\ f_{23} \\
f_{31} \\ f_{32} \\ f_{33} \\
\end{bmatrix}
=
\begin{bmatrix}
0 \\ 0 \\ 0 \\ 0 \\ 0 \\ 0 \\ 0 \\ 0 \\ 0
\end{bmatrix}
$$

$$
A \mathbf{f} = \mathbf{0}
$$

同样地 ，我们可以给出一定的限制 constraint.

- Option 1. 令 $f_{33} = 1$.
- Option 2. 令 $||f|| = 1$.

得到自由度为 $8$，至少需要 8 组点.

并同样要最小化 $||\mathbf{Af - 0}|| = \mathbf{||Af||}$.

同样如果使用的是向量范数为 $1$ 的限制，那么解就是 $\mathbf{A^{T}A}$ 最小特征值对应的特征向量.

#### Step 3. Find $E$ and Extract $R, \mathbf{t}$

$$
E = K_l^T F K_r
$$

通过 SVD 分解，  $E = T_\times R$ 得到 $T_\times$ 和 $R$. 

$R$ 即为旋转矩阵，$\mathbf{t}$ 可以通过 $T_\times$ 直接得到.

#### Step 4. Find 3D Position of Scene Points

现在已经有以下等式

$$
\small
\begin{align}
\text{Left Camera}
\\
\begin{bmatrix}
u_l \\ v_l \\ 1
\end{bmatrix}
&=
\begin{bmatrix}
f_x^{(l)} & 0 & o_x^{(l)} & 0 \\
0 & f_y^{(l)} & o_y^{(l)} & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
x_l \\ y_l \\ z_l \\ 1
\end{bmatrix}
,\ 
\begin{bmatrix}
x_l \\ y_l \\ z_l \\ 1
\end{bmatrix}
=
\begin{bmatrix}
r_{11} & r_{12} & r_{13} & t_x \\
r_{21} & r_{22} & r_{23} & t_y \\
r_{31} & r_{32} & r_{33} & t_z \\
0 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
x_r \\ y_r \\ z_r \\ 1
\end{bmatrix}
\\
\begin{bmatrix}
u_l \\ v_l \\ 1
\end{bmatrix}
&=
\begin{bmatrix}
f_x^{(l)} & 0 & o_x^{(l)} & 0 \\
0 & f_y^{(l)} & o_y^{(l)} & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
r_{11} & r_{12} & r_{13} & t_x \\
r_{21} & r_{22} & r_{23} & t_y \\
r_{31} & r_{32} & r_{33} & t_z \\
0 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
x_r \\ y_r \\ z_r \\ 1
\end{bmatrix}
\\ \\
\normalsize
\mathbf{\tilde u}_l &= 
\normalsize
P_l \mathbf{\tilde x}_r
\\ \\
\small
\text{Right Camera}
\\
\begin{bmatrix}
u_r \\ v_r \\ 1
\end{bmatrix}
&=
\begin{bmatrix}
f_x^{(r)} & 0 & o_x^{(r)} & 0 \\
0 & f_y^{(r)} & o_y^{(r)} & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
x_r \\ y_r \\ z_r \\ 1
\end{bmatrix}
\\ \\
\normalsize
\mathbf{\tilde u}_l &= 
\normalsize
M_{int_r} \mathbf{\tilde x}_r
\end{align}
$$

由

$$
\small
\begin{bmatrix}
u_r \\ v_r \\ 1
\end{bmatrix}
=
\begin{bmatrix}
m_{11} & m_{12} & m_{13} & m_{14} \\
m_{21} & m_{22} & m_{23} & m_{24} \\
m_{31} & m_{32} & m_{33} & m_{34} \\
\end{bmatrix}
\begin{bmatrix}
x_r \\ y_r \\ z_r \\ 1
\end{bmatrix}
,\ 
\begin{bmatrix}
u_r \\ v_r \\ 1
\end{bmatrix}
=
\begin{bmatrix}
p_{11} & p_{12} & p_{13} & p_{14} \\
p_{21} & p_{22} & p_{23} & p_{24} \\
p_{31} & p_{32} & p_{33} & p_{34} \\
\end{bmatrix}
\begin{bmatrix}
x_r \\ y_r \\ z_r \\ 1
\end{bmatrix}
$$

整理得

$$
\underbrace{
\begin{bmatrix}
u_r m_{31} - m_{11} & u_r m_{32} - m_{12} & u_r m_{33} - m_{13} \\ 
v_r m_{31} - m_{21} & v_r m_{32} - m_{22} & v_r m_{33} - m_{23} \\ 
u_l p_{31} - p_{11} & u_l p_{32} - p_{12} & u_l p_{33} - p_{13} \\  
v_l p_{31} - p_{21} & v_l p_{32} - p_{22} & v_l p_{33} - p_{23}
\end{bmatrix}
}_{A_{4\times 3}}
\underbrace{
\begin{bmatrix}
x_r \\ y_r \\ z_r
\end{bmatrix}
}_{\mathbf{x}_r}
=
\underbrace{
\begin{bmatrix}
m_{14} - m_{34} \\
m_{24} - m_{34} \\  
p_{14} - p_{34} \\ 
p_{24} - p_{34}
\end{bmatrix}
}_{\mathbf{b}}
$$

由分析上解的唯一性，理论上有两行是线性相关的. 但是在实际取点中可能会存在一定的误差，所以为了最大化利用数据量，还是采用最小二乘法.

由最小二乘法得，

$$
\mathbf{x}_r = (A^TA)^{-1}A^T \mathbf{b}
$$

!!! Note "Non-linear Solution"
	上面的是通过解线性系统的方法，另一种想法是最小化**重映射误差 (reprojection error)**.
	
	$$
	\text{cost}(P) = \text{dist}(\mathbf{u}_l, \mathbf{\hat u}_l)^2 + \text{dist}(\mathbf{u}_r, \mathbf{\hat u}_r)^2 
	$$
	
	<div align="center">
		<img src="../Pic/lec7_13.png" alt="lec7_13" style="width:400px"/>
	</div>
	
	另外，通过这种方法我们也可以优化 $R$ 和 $\mathbf{t}$.

## Multi-frame Structure from Motion

与 Two-frame SfM 类似，已知 $m$ 张图像，$n$ 个三维点以及相机内参矩阵，求相机的位置以及所拍摄主体的三维位置坐标.

也就是对于以下等式：

$$
\mathbf{u}_j^{(i)} = P_{proj}^{(i)} \mathbf{P}_j
\text{, where } i = 1, \dots, m, j = 1, \dots, n
$$

由 $mn$ 个投影的二维点 $\mathbf{u}_j^{(i)}$求解 $m$ 个投影矩阵 $P_{proj}^{(i)}$ 与 $n$ 个三维点坐标 $P_j$.

### Solution: Sequential Structrue from Motion

#### Step 1. Initialize camera motion and scene structure. 初始化

首先选两张图做一次 Two-frame SfM.

<div align="center">
	<img src="../Pic/lec7_14.png" alt="lec7_14" style="width:300px"/>
</div>

#### Step 2. Deal with an addition view. 处理下一张图

对于每新增的一张图，

- 对于已经建立三维坐标的点：[PnP 问题](#PnP).

<div align="center">
	<img src="../Pic/lec7_15.png" alt="lec7_15" style="width:450px"/>
</div>

- 对于尚未建立三维坐标的点：做 Two-frame SfM.

<div align="center">
	<img src="../Pic/lec7_16.png" alt="lec7_16" style="width:300px"/>
</div>

#### Step 3. Refine structure and motion: Bundle Adjustment. 集束调整

处理完所有的图后，再通过一次**集束调整**（具体实现是 [LM 算法](../4_Model_Fitting_and_Optimization/?h=lm#levenberg-marquardt-lm)）对三维点坐标和相机参数做进一步优化，即最小化**重映射误差**（非线性最小二乘）：

$$
E(P_{proj}, \mathbf{P}) = \sum\limits_{i=1}^m \sum\limits_{j=1}^n \text{dist} \left( u_j^{(i)}, P_{proj}^{(i)} \mathbf{P}_j \right)^2
$$

## COLMAP

> COLMAP is a general-purpose **Structure-from-Motion (SfM)** and **Multi-View Stereo (MVS)** pipeline with a graphical and commandline interface. It offers a wide range of features for reconstruction of ordered and unordered image collections.

<div align="center">
	<img src="../Pic/lec7_17.png" alt="lec7_17" style="width:600px"/>
</div>

!!! Note ""
	Pipeline
	
	<div align="center">
		<img src="../Pic/lec7_18.png" alt="lec7_18" style="width:600px"/>
	</div>