# Lecture 6

FA and PDA, as we mentioned in previous lectures, can only accept a few of the languages. Now we are going to give a stronger automata, the Turing machine.

!!! definition

    A deterministic Turing machine is a 5-tuple $M = (K, \Sigma, \delta, s, H)$, where

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
                \forall q \in K - H, \exists p \in K,\ \ s.t.\  \delta(q, \triangleleft) = (p, \rightarrow)
            $$

!!! definition

    A configuration of a Turing machine is a member of the set

    $$
        K \times \triangleright (\Sigma - \{\triangleright\})^* \times (\{e\} \cup (\Sigma - \{\triangleright\})^* (\Sigma - \{\triangleright, \sqcup\}))
    $$

    Specially, $(q, \triangleleft w \underline{a} u)$ is a halting configuration if $q \in H$.

!!! definition

    - **Yields in one step**: $(q_1, \triangleright w_1 \underline{a_1} u_1) \vdash_M (q_2, \triangleright w_2 \underline{a_2} u_2)$ if either of the following cases.
        - **Writing**: $\delta(q_1, a_1) = (q_2, a_2), w_2 = w_1, u_2 = u_1$.
        - **Moving Left**: $\delta(q_1, a_1) = (q_2, \leftarrow), w_1 = w_2 q_2, u_2 = a_1 u_1$ (Specially, $u_2 = e$ if $a_1 = \sqcup, u_1 = e$).
        - **Moving Right**: $\delta(q_1, a_1) = (q_2, \rightarrow), w_2 = w_1 a_1, u_1 = a_2 u_2$ (Specially, $u_1 = e$ if $a_2 = \sqcup, u_2 = e$).
    - **Yields**: $(q_1, \triangleright w_1 \underline{a_1} u_1) \vdash_M^* (q_2, \triangleright w_2 \underline{a_2} u_2)$ if

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

!!! example

