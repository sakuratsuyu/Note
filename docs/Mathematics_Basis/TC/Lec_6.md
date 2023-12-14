# Lecture 6

FA and PDA, as we mentioned in previous lectures, can only accept a few of the languages. Now we are going to give a stronger automata, the Turing machine.

## Turing Machine

!!! definition

    A **deterministic Turing machine (DTM)** is a 5-tuple $M = (K, \Sigma, \delta, s, H)$, where

    - $K$ is a finite set of states.
    - $\Sigma$ is the tape alphabet, containing the left end symbol $\triangleright$ the blank $\sqcup$.
    - $s \in K$ is the initial state.
    - $H \subseteq K$ is a set of halting state.
    - $\delta$ is a **transition function**. It describes in the current state, when read a symbol, what will the next state be and the head action be (move or write).

        $$
            \delta: (K - H) \times \Sigma \rightarrow K \times (\{\leftarrow, \rightarrow\} \cup (\Sigma - \{\triangleright\})).
        $$

        - Also, there is a limitation of $\delta$.

            $$
                \forall q \in K - H, \exists p \in K,\ \ s.t.\  \delta(q, \triangleright) = (p, \rightarrow)
            $$

!!! definition

    A **configuration** of a Turing machine is a member of the set

    $$
        K \times \triangleright (\Sigma - \{\triangleright\})^* \times (\{e\} \cup (\Sigma - \{\triangleright\})^* (\Sigma - \{\triangleright, \sqcup\}))
    $$

    Specially, $(q, \triangleright w \underline{a} u)$ is a halting configuration if $q \in H$.

!!! definition

    - **Yields in one step**: $(q_1, \triangleright w_1 \underline{a_1} u_1) \vdash_M (q_2, \triangleright w_2 \underline{a_2} u_2)$ if either of the following cases.
        - **Writing**: $\delta(q_1, a_1) = (q_2, a_2), w_2 = w_1, u_2 = u_1$.
        - **Moving Left**: $\delta(q_1, a_1) = (q_2, \leftarrow), w_1 = w_2 q_2, u_2 = a_1 u_1$ (Specially, $u_2 = e$ if $a_1 = \sqcup, u_1 = e$).
        - **Moving Right**: $\delta(q_1, a_1) = (q_2, \rightarrow), w_2 = w_1 a_1, u_1 = a_2 u_2$ (Specially, $u_1 = e$ if $a_2 = \sqcup, u_2 = e$).
    - **Yields in $N$ steps**: $(q_1, \triangleright w_1 \underline{a_1} u_1) \vdash_M^N (q_2, \triangleright w_2 \underline{a_2} u_2)$ if
    
    $$
    (q_1, \triangleright w_1 \underline{a_1} u_1) \underbrace{\vdash_M \cdots \vdash_M}_{N \text{ steps}} (q_2, \triangleright w_2 \underline{a_2} u_2).
    $$
    
    - **Yields**: $(q_1, \triangleright w_1 \underline{a_1} u_1) \vdash_M^* (q_2, \triangleright w_2 \underline{a_2} u_2)$ if $(q_1, \triangleright w_1 \underline{a_1} u_1) \vdash_M \cdots \vdash_M (q_2, \triangleright w_2 \underline{a_2} u_2)$

        - either $(q_1, \triangleright w_1 \underline{a_1} u_1) = (q_2, \triangleright w_2 \underline{a_2} u_2)$.
        - or $(q_1, \triangleright w_1 \underline{a_1} u_1) \vdash_M \cdots \vdash_M (q_2, \triangleright w_2 \underline{a_2} u_2)$ in some $k$($k \in \mathbb{N}^*$) steps.

Now let's fix $\Sigma$, we give some simple Turing Machine examples.

!!! example

    !!! plane ""

        **Symbol writing machine**
        
        $M_a = (\{s, h\}, \Sigma, \delta, s, \{h\})$ ($a \in \Sigma - \{\triangleright\}$), where

        - $\forall b \in \Sigma - \{\triangleright\}$, $\delta(s, b) = (h, a)$.
        - $\delta(s, \triangleright) = \delta(s, \rightarrow)$.
        

    !!! plane ""

        **Heading moving machine**

        $M_\leftarrow = (\{s, h\}, \Sigma, \delta, s, \{h\})$, where

        - $\forall b \in \Sigma - \{\triangleright\}$, $\delta(s, b) = (h, \leftarrow)$.
        - $\delta(s, \triangleright) = \delta(s, \rightarrow)$.

        $M_\rightarrow = (\{s, h\}, \Sigma, \delta, s, \{h\})$, where

        - $\forall b \in \Sigma$, $\delta(s, b) = (h, \rightarrow)$.

We call $M_a$, $M_\leftarrow$ and $M_\rightarrow$ basic machines, sometimes we abbreviate them to $a$, $L$, $R$.

For simplicity, we introduce the following symbols.

!!! plane ""

    !!! plane ""

        <div align="center" style="text-align: center">
            <span style="vertical-align: middle">
                <img src="../imgs/22.svg" style="height:50px; vertical-align: middle"/>
                <span> ---\> </span>
                <img src="../imgs/23.svg" style="height:20px; vertical-align: middle"/>
            </span>
        </div>
        
    !!! plane ""

        <div align="center" style="text-align: center">
            <span style="vertical-align: middle">
                <img src="../imgs/24.svg" style="height:200px; vertical-align: middle"/>
                <span> ---\> </span>
                <img src="../imgs/25.svg" style="height:50px; vertical-align: middle"/>
            </span>
        </div>

    And some abbreviations.

    - $R_\sqcup$ find the next blank symbol on the right. 
    - $L_\sqcup$ find the next blank symbol on the left.
    - $R_{\overline{\sqcup}}$ find the next non-blank symbol on the right.
    - $L_{\overline{\sqcup}}$ find the next non-blank symbol on the left.

    <div align="center">
        <img src="../imgs/26.svg" style="height:40px"/>
    </div>

!!! example

    **Left-shifting Machine** $S_\leftarrow$

    $$
        \forall w \in (\Sigma - \{\triangleright, \sqcup\})^*, \exists h \in H,\ \ s.t.\ \ (s, \triangleright\sqcup\sqcup w \sqcup) \vdash_M^*(h, \triangleright\sqcup w\sqcup).
    $$

    <div align="center">
        <img src="../imgs/27.svg" style="height:200px"/>
    </div>

## Language Recognization

!!! definition

    **input alphabet**: $\Sigma_0 \subseteq (\Sigma - \{\triangleright, \sqcup\})$.

    **input configuration**: $(s, \triangleright \underline{\sqcup} w)$.

    !!! plane ""

        For $L(M) = \{ w \in \Sigma_0^*: (s, \triangleright \underline{\sqcup} w) \vdash_M^* (h, \dots), h \in H \}$, we say $M$ **semidecides** $L(M)$ and $L(M)$ is **recursively enumerable / recognizable**.


    !!! plane ""
        
        Suppose a Turing machine $M = (K, \Sigma_0, \delta, s, \{y, n\})$, we say $M$ **decides** a language $L \subseteq \Sigma_0$ if

        - $\forall w \in L, (s, \triangleright \underline{\sqcup} w) \vdash_M^* (y, \dots)$, we say $M$ accepts $w$.
        - $\forall w \in \Sigma_0^* - L, (s, \triangleright \underline{\sqcup} w) \vdash_M^* (n, \dots)$, we say $M$ rejects $w$.

        and $L$ is **recursive / decidable**.

!!! theorem

    If $L$ is recursive, then $L$ must be recursively enumerable.

## Function Computation

!!! definition

    $\forall w \in \Sigma_0^*$, if $(s, \triangleright \underline{\sqcup} w) \vdash_M^* (h, \triangleright \underline{\sqcup} y)$ for some $h \in H$ and some $y \in \Sigma_0^*$, we say $y$ is the output of $M$ on $w$, denoted by $y = M(w)$.

    Let $f : \Sigma_0^* \rightarrow \Sigma_0^*$, we say $M$ **computes** $f$ if

    $$
        \forall w \in \Sigma_0^*,\ \ M(w) = f(w).
    $$

    and $f$ is **recursive / computable**.

!!! example

    Show that $\{a^nb^nc^n | n \ge 0\}$ is recursive.