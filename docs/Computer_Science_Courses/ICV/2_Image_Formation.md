# Lecture 2 Image Formation

## Camera and Lens

### Pinhole Camera

A barrier to block off most of the rays. The opening is the **aperture 光圈**.
<div align="center">
	<img src="../Pic/lec2_0.png" alt="lec2_0" style="width:600px"/>
</div>

**Flaws**

- Less light gets through.
- Diffraction effects (衍射).

### Lens 透镜

<div align="center">
	<img src="../Pic/lec2_1.png" alt="lec2_1" style="width:500px"/>
</div>

$$
\frac{1}{i} + \frac{1}{o} = \frac{1}{f}.
$$

#### Focal length $f$  焦距

If $o = \infty$, then $f = i$.

#### Magnification $m$ 放大率

$$
m = \frac{h_i}{h_o}.
$$

<div align="center">
	<img src="../Pic/lec2_2.png" alt="lec2_2" style="width:500px"/>
</div>

#### Field of View (FOV) 视野

**Factor**

-  Focal Length.
	- Longer focal length, Narrower angle of view. Vice versa.

<div align="center">
	<img src="../Pic/lec2_3.png" alt="lec2_3" style="width:200px"/>
</div>

!!! note 
	50mm / 46° (and full frame) is the most similar FOV with human eyes. Thus 50mm lens is called **standard lens** (标准镜头).
	
	- telephoto lens (长焦镜头，望远镜头): 视野小, 放大率大.
	- short focal lens (短焦镜头，广角镜头); 视野大, 放大率小.
-  Sensor Size
	- Bigger sensor size, Wider angle of view. Vice versa.

<div align="center">
	<img src="../Pic/lec2_4.png" alt="lec2_4" style="width:500px"/>
</div>

### Aperture 光圈

The representation of aperture is its Diameter $D$.

**F-Number**

$$
N = \frac{f}{D} \text{ (mostly greater than 1, around 1.8 \sim 22)}.
$$

### Lens Defocus

<div align="center">
	<img src="../Pic/lec2_5.png" alt="lec2_5" style="width:500px"/>
</div>

Blur Circle Diameter (光斑半径)

$$
b = \frac{D}{i'}|i' -i|, b \propto D \propto \frac{1}{N}
$$

### Focusing 对焦

<div align="center">
	<img src="../Pic/lec2_6.png" alt="lec2_6" style="width:600px"/>
</div>

#### Depth of Field (DoF) 景深

<div align="center">
	<img src="../Pic/lec2_7.png" alt="lec2_7" style="width:600px"/>
</div>


$$
{\tt DoF} = o_2 - o_1 = \frac{2of^2cN(o-f)}{f^4-c^2N^2(o-f)^2}.
$$

From the equation above, we can find that **DoF is almost proportional to $N$**, and thus the Larger aperture, the Smaller F-Number and the Smaller DoF.

#### How to blur the background

-  Large aperture.
-  Long focal length.
-  Near foreground.
-  Far background.

## Geometric Image Formation（定位）

!!! note "Camera model"
	<div align="center">
		<img src="../Pic/lec2_8.png" alt="lec2_8" style="width:400px"/>
	</div>

$$
\begin{bmatrix}
u \\
v
\end{bmatrix}
=
\begin{bmatrix}
f \frac{x}{z} \\
f \frac{y}{z}
\end{bmatrix}.
$$

### Homogeneous Coordinates / Projective Coordinates

Suppose that $\begin{bmatrix} x \\ y \\ w \end{bmatrix}$is the same as $\begin{bmatrix} x/w \\ y/w \\ 1 \end{bmatrix}$, then we get

$$
\begin{bmatrix}
f & 0 & 0 & 0 \\
0 & f & 0 & 0 \\
0 & 0 & 1 & 0
\end{bmatrix}
\begin{bmatrix}
x \\
y \\
z \\
1
\end{bmatrix}
= 
\begin{bmatrix}
fx \\
fy \\
z \\
\end{bmatrix}
\cong
\begin{bmatrix}
f\frac{x}{z} \\
f\frac{y}{z} \\
1
\end{bmatrix}.
$$

We can also put the image plane in front of the camera (opposite to the previous picture).

<div align="center">
	<img src="../Pic/lec2_9.png" alt="lec2_9" style="width:400px"/>
</div>
	
### Perspective Projection

- Preserevd - Straight lines are still straight
- Lost - Length and Angle

#### Vanishing Points

<div align="center">
	<img src="../Pic/lec2_10.png" alt="lec2_10" style="width:500px"/>
</div>
<div align="center">
	<img src="../Pic/lec2_11.png" alt="lec2_11" style="width:500px"/>
</div>

!!! note "Properties"
	- Any wo parallel lines have the same vanishing point **v.**
		- **v** can be outside the image frame or at infinity.
	- Line from **C** to **v** is parallel to the lines.

#### Vanishing Lines

Multiple vanishing points

The direction of the vanishing line tells us the orientation of the plane.

<div align="center">
	<img src="../Pic/lec2_12.png" alt="lec2_12" style="width:500px"/>
</div>

#### Distortion

- Converging verticals

<figure markdown> 
	<div align="center">
		<img src="../Pic/lec2_13.png" alt="lec2_13" style="width:800px"/>
	</div>
	<figcaption>Problem and Solution (View Camera 移轴相机)</figcaption>
</figure>

- Exterior columns appear bigger
	- Due to lens flaws
	<div align="center">
		<img src="../Pic/lec2_14.png" alt="lec2_14" style="width:300px"/>
	</div>
- Radial distortion
	- Due to imperfect lens

<div align="center">
	<img src="../Pic/lec2_15.png" alt="lec2_15" style="width:800px"/>
</div>

$$
\begin{aligned}
r^2 &= {x'}_n^{2} + {y'}_n^{2} \\
{x'}_d &= {x'}_n(1 + \kappa_1r^2 + \kappa_2r^4) \\
{y'}_d &= {y'}_n(1 + \kappa_1r^2 + \kappa_2r^4) \\
\end{aligned}
$$

!!! success "Solution"
	Take a photo of a grid at the same point and then use the mathmatics to calculate and correct radial distortion.

#### Orthographic Projection

<div align="center">
	<img src="../Pic/lec2_16.png" alt="lec2_16" style="width:400px"/>
</div>

$$
\begin{bmatrix}
1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 \\
0 & 0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
x \\
y \\
z \\
1
\end{bmatrix}
= 
\begin{bmatrix}
x \\
y \\
1 \\
\end{bmatrix}
\Rightarrow
(x, y)
$$

### Photometric Image Formation（定颜色/亮度）

#### Image Sensor

-   CMOS
-   CCD (Charge Coupled Device)

#### Shutter

Shutter speed controls exposure time.

#### Color Sensing

-   Color Spaces
	-   RGB
	-   HSV

-   Practical Color Sensing: **Bayer Filter**

<div align="center">
	<img src="../Pic/lec2_17.png" alt="lec2_17" style="width:800px"/>
</div>

#### Shading 着色

<div align="center">
	<img src="../Pic/lec2_18.png" alt="lec2_18" style="width:300px"/>
</div>

##### BRDF (Bidirectional Reflectance Distribution Function)

<div align="center">
	<img src="../Pic/lec2_19.png" alt="lec2_19" style="width:600px"/>
</div>

$$
L_r(\hat{\textbf{v}_r};\lambda) = \int L_i(\hat{\textbf{i}_r};\lambda)f_r(\hat{\textbf{v}_r}, \hat{\textbf{v}_i}, \hat{\textbf{n}}; \lambda)\cos^+\theta_i\ d\hat{\textbf{v}_i}
$$

##### Diffuse (Lambertian) Reflection

-   Shading independent of view direction

<div align="center">
	<img src="../Pic/lec2_20.png" alt="lec2_20" style="width:600px"/>
</div>

##### Specular Term

-   Intensity depends on view direction

<div align="center">
	<img src="../Pic/lec2_21.png" alt="lec2_21" style="width:600px"/>
</div>

##### Blinn-Phong Reflection Model

<div align="center">
	<img src="../Pic/lec2_22.png" alt="lec2_22" style="width:800px"/>
</div>

$$
L = L_a + L_d + L_s = k_aI_a + k_d(I/r^2)\max(0, \textbf{n}\cdot\textbf{l}) + k_s(I/r^2)\max(0, \textbf{n}\cdot\textbf{h})^p
$$