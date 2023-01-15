# Lecture 1 Introduction

### Review of Linear Algrebra

#### Affine Transformations 仿射变换

Affine map combines linear map and translation.

$$
\begin{bmatrix}
x' \\
y'
\end{bmatrix}
=
\begin{bmatrix}
a & b \\
c & d
\end{bmatrix}
\begin{bmatrix}
x \\
y
\end{bmatrix}
+
\begin{bmatrix}
t_x \\
t_y
\end{bmatrix} .
$$

Using homogenous coordinates (齐次坐标)

$$
\begin{bmatrix}
x' \\
y' \\
1
\end{bmatrix}
=
\begin{bmatrix}
a & b & t_x \\
c & d & t_y \\
0 & 0 & 1
\end{bmatrix}
\begin{bmatrix}
x \\
y \\
1
\end{bmatrix}.
$$

#### Eigenvectors and Eigenvalues

- The eigenvalues of symmetric matrices are real numbers.
- The eigenvalues of positive definite matrices are positive numbers.