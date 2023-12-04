# Lecture 9

!!! example

    Show that $R_{TM} = \{\langle M \rangle : M \text{ is a TM with } L(M) \text{ being regular}\}$ is not recursive.

    !!! proof

        Suppose $M_1$ decides on $\overline{R_{TM}}$, then we construct $M_2$ runs on $H$.

        $M_2$ = on input $\langle M, w \rangle$,

        1. construct a TM $M'$ = on input $x$
            
            1. run $M$ on $w$
            2. run $U$ on $x$
        
            $$
                L(M') = \left\{
                \begin{aligned}
                    & \phi, && \text{if $M$ does not halt on $w$}, \\
                    & L(U) = H, && \text{if $M$ halts on $w$}.
                \end{aligned}
                \right.
            $$

            > NOTE that $\phi$ is regular, but $L(U) = H$ is not regular (because it's even not recursice).
        
        2. run $M_1$ on $\langle M' \rangle$.
        3. return the result of $M_1$.

        Since $M_2$ can not decide $H$, thus $M_1$ can not decide $\overline{R_{TM}}$. Therefore $\overline{R_{TM}}$ is not recursive and so is $R_{TM}$.

!!! example

    Show that $CF_{TM} = \{\langle M \rangle : M \text{ is a TM with } L(M) \text{ being context-free}\}$ is not recursive.

    !!! proof
    
        The same reduction pattern of $R_{TM}$. Since $\phi$ is context-free and $H$ not.

!!! example

    Show that $REC_{TM} = \{\langle M \rangle : M \text{ is a TM with } L(M) \text{ being recursive}\}$ is not recursive.

From the examples above, we can conclude some pattern of not recursive langauges.

## Rice's Theorem

!!! theorem

    Suppose $\mathcal{L}(P)$ is a **non-empty proper subset** of all **recursively enumarable** languages, then the following language is **NOT recursive**.

    $$
        R(P) = \{\langle M \rangle : M \text{ is a TM with } L(M) \in \mathcal{L}(P)\}.
    $$

!!! proof

    !!! plane ""
    
        **Case 1.** $\phi \notin \mathcal{L}(P)$

        There exists $A \in \mathcal{L}(P)$, so there exists a TM $M_A$ that semidecides $A$. Suppose $M_R$ decides $R(P)$, then we construct $M_H$ on $H$.

        $M_H$ = on input $\langle M, w \rangle$,

        1. construct a TM $M^*$ = on input $x$

            1. run $M$ on $w$
            2. run $M_A$ on $x$
        
            $$
                L(M^*) = \left\{
                \begin{aligned}
                    & \phi, && \text{if $M$ does not halt on $w$}, \\
                    & L(M_A) = A, && \text{if $M$ halts on $w$}.
                \end{aligned}
                \right.
            $$
        
        2. run $M_R$ on $\langle M^* \rangle$.
        3. return the result of $M_R$.


    !!! plane ""
    
        **Case 2.** $\phi \in \mathcal{L}(P)$

        Then $\phi \notin \overline{\mathcal{L}(P)}$, we can reduce $H$ to $\overline{R(P)}$ like in case 1. And thus $$R(P)$ is not recursive.

## Summary

!!! plane ""

    To prove a language $A$ **recursive**, we can prove

    - By definition: construct a Turing machine.
    - By reduction: $A \le \text{known recursive language}$.

!!! plane ""

    To prove a language $A$ **not recursive**, we can prove

    - By reduction: $\text{known recursive language} \le A$.
        - The mostly used language is $H$.
    
!!! plane ""

    To prove a language $A$ **recursively enumerable**, we can prove

    - By definition: construct a Turing machine.
    - By reduction: $A \le \text{known recursively enumerable language}$.

!!! plane ""

    To prove a language $A$ **not recursively enumerable**, we can prove

    - By reduction: $\text{known non-recursively enumerable language} \le A$.
    - By the following theorem.

!!! theorem

    If $A$ and $\overline{A}$ are recursively enumerable, then $A$ is recursive.

??? proof

    Since $A$ and $\overline{A}$ are recursively enumerable, then there exists $M_1$ and $M_2$ that semidecides $A$ and $\overline{A}$ respectively.

    Then we construct a $M_3$ that decides $A$.

    $M_3$ = on input $x$

    1. run $M_1$ and $M_2$ on $x$ in parallel.
    2. if $M_1$ halts on $x$,
    3. &nbsp;&nbsp;&nbsp;&nbsp; accept $x$.
    4. if $M_2$ halts on $x$,
    5. &nbsp;&nbsp;&nbsp;&nbsp; reject $x$.


!!! example

    Since $H$ is recursively enumerable and not recursive, then $\overline{H}$ is not recursively enumerable.


!!! example

    Show that $A = \{\langle M \rangle : M \text{ is a TM that halts on some input}\}$ is recursively enumerable.

    !!! proof

        $M_A$ = on input $\langle M \rangle$.

        1. for $i$ = $1, 2, 3, \dots$
        2. &nbsp;&nbsp;&nbsp;&nbsp; for $s$ = $s_1, s_2, \dots, s_i$ ($s_i \in L$)
        3. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run $M$ on $s$ for $i$ steps,
        4. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if $M$ halts on $s$ within $i$ steps,
        5. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;halt.

## Closure Property

!!! theorem

    If $A$ and $B$ are recursive langauges, then so as

    - $A \cup B$.
    - $A \cap B$.
    - $\overline{A}$.
    - $A \circ B$.
    - $A^*$.

    If $A$ and $B$ are recursively enumerable langauges, then so as

    - $A \cup B$.
    - $A \cap B$.
    - $A \circ B$.
    - $A^*$.

    > **NOTE** not so as $\overline{A}$, a counter example is $H$.

## Enumerator

There are some extra properties of Turing machine.

!!! definition

    A Turing machine $M$ **enumerates** a language $L$ if for some state $q$,

    $$
        L = \{w | (s, \triangleright \underline{\sqcup}) \vdash_M^* (q, \triangleright \underline{\sqcup}w) \}.
    $$

    And $L$ is **Turing enumerable**.

    > $M$ has no input.

!!! theorem

    A language $L$ is Turing enumerable iff it's recursively enumerable.

!!! proof

    If $L$ is finite, it's trivial. Assume $L$ is infinite,

    $\Rightarrow$. There exists a TM $M$ that enumerates $L$, we construct $M'$.

    $M'$ = on input $x$

    1. run $M$ to enumerate $L$.
    2. every time $M$ outputs a string $w$,
    3. &nbsp;&nbsp;&nbsp;&nbsp; if $w$ equals to $x$,
    4. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; halt.

    Then $M'$ semidecides $L$ and $L$ is recursively enumerable.

    $\Leftarrow$. There exists a TM $M$ that semidecides $L$, we construct $M'$.

    $M'$ = 

    1. for $i$ = $1, 2, 3, \dots$
    2. &nbsp;&nbsp;&nbsp;&nbsp; for $s$ = $s_1, s_2, \dots, s_i$ ($s_i \in L$)
    3. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; run $M$ on $s$ for $i$ steps.
    4. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if $M$ halts on $s$ within $i$ steps.
    5. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output $s$.

    > Here the "some state $q$" of $M'$ is the halting state.

!!! definition

    Let $M$ be a TM that enumerates $L$, then $M$ is **lexicographically enumerates** $L$ if whenever

    $$
        (q, \triangleright \underline{\sqcup}) w \vdash_M^+ (q, \triangleright \underline{\sqcup} w')
    $$

    we have $w'$ after $w$ in **lexicographical order**.

!!! theorem

    $L$ is lexicographically enumerable iff it's recursive.

!!! proof

    $\Leftarrow$. There exists $M$ decides $L$, we construct $M'$.

    $M'$ on input $x$
    
    1. enumerate all strings in lexicographical order.
    2. for each string $s$,
    3. &nbsp;&nbsp;&nbsp;&nbsp; run $M$ on $s$,
    4. &nbsp;&nbsp;&nbsp;&nbsp; if $M$ accepts $s$,
    5. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output $s$.

    $\Rightarrow$. There exists $M$ lexicographically enumerate $L$, we construct $M'$.

    $M'$ = on input $x$

    1. run $M$ to enumerate $L$.
    2. every time $M$ outputs a string $w$,
    3. &nbsp;&nbsp;&nbsp;&nbsp; if $w$ equals to $x$,
    4. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; accept $x$.
    5. reject $x$.