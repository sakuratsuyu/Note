# Algorithm Analysis

!!! definition
    An **algorithm** is a finite set of instructions that, if followed, accomplishes a particular task. In addtion, all algorithms must satisfy the following criteria:

    - Input (zero or more) and Output (at least one).
    - Definiteness: clear and unambiguous.
    - Finiteness: termination after finite number of steps.
    - Effectiveness.

    *NOTE:* A **program** does not have to be finite. *e.g.* an operating system.

### Running Time

The most important resource to analyze is the running time. It consists of two parts

- Machine and Compiler-Dependent run times.
- **Time and Space Complexities** (Machine and Complier-Independent).

In FDS, we mainly consider the **average time complexity** $T_\text{avg}(N)$ and the **worst time complexity** $T_\text{worst}(N)$ as functions of input size $N$.

!!! note "Genernal Rules"
    - **FOR LOOPS** the *statements inside* the loop *times* the number of *iterations*.
    - **NESTED FOR LOOPS** the *statements* *multiplied* by the *product of the size*.
    - **CONSECUTIVE STATEMENTS** just *add*.
    - **IF/ELSE** running time of the test *plus* the *larger* of the running time of S1 and S2.

        ```
        if (Condition) {
            S1;
        } else {
            S2;
        }
        ```

### Asymptotic Notation

!!! definition
    - $T(N) = O(f(N))$ if there are positive constants $c$ and $n_0$ s.t.

    $$
        \forall\ N \ge n_0,\ \ T(N) \le c \cdot f(N).
    $$

    - $T(N) = \Omega(g(N))$ if there are positive constants $c$ and $n_0$ s.t.

    $$
        \forall\ N \ge n_0,\ \ T(N) \ge c \cdot g(N).
    $$
   
    - $T(N) = \Theta(h(N))$ iff 

    $$
        T(N) = O(h(N)) = \Omega(h(N)).
    $$

    - $T(N) = o(p(N))$ if

    $$
        T(N) = O(p(N)),\ \ T(N) \ne \Theta(p(N)).
    $$

!!! theorem "Rules"
    - If $T_1(N) = O(f(N))$ and $T_2(N) = O(g(N))$, then

        $$
        \begin{aligned}
            T_1(N) + T_2(N) &= \max(O(f(N)), O(g(N))), \\
            T_1(N) \cdot T_2(N) &= O(f(N) \cdot g(N)). \\
        \end{aligned}
        $$

    - If $T(N)$ is a polynomial of degree $k$, then $T(N) = \Theta(N^k)$.


!!! example
    The recurrent equations for the time complexities of programs $P1$ and $P2$ are:

    $$
    \begin{aligned}
        & P1: T(1)=1,T(N)=T(N/3)+1, \\
        & P2: T(1)=1,T(N)=3T(N/3)+1.
    \end{aligned}
    $$

    Find $T(N)$ for $P1$ and $P2$ respectively.

    **Solution.**

    For $P1$,

    $$
    \begin{aligned}
        T(N) &= T(N / 3) + 1 = T(N / 3^k) + k \overset{k = \log N}{=\!=\!=\!=\!=} T(1) + \log N = O(\log N).
    \end{aligned}
    $$

    For $P2$,

    $$
    \begin{aligned}
        T(N) &= 3T(N / 3) + 1 = 3^k T(N / 3^k) + 1 + k + \cdots + 3^{k - 1}
        \\ & = 3^kT(N / 3^k) + O(3^k) \overset{k = \log N}{=\!=\!=\!=\!=} N \cdot T(1) + O(N) = O(N).
    \end{aligned}
    $$
    