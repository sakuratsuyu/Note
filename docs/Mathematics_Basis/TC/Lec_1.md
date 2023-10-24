# Lecture 1

## Introduction

### 1.Automata theory

- finite automata
- pushdown automata
- Turing machines
    - [Church-Turing Thesis](https://en.wikipedia.org/wiki/Church%E2%80%93Turing_thesis)

### 2. Compuatability Theory

### 3. Complexity theory:  hardness and complexity class.


## Problem

!!! definition

    **Optimization Problem**

    e.g. Given $G: (V, E, W)$, what is the minimum spanning tree?

    **Search Problem**

    e.g. Given $G$ and an integer $k$, find a spanning tree whose weight is at most $k$ or tells such a tree not exist.

    **Decision Problem**

    e.g. Given $G$ and $k$, is there a spanning tree with weight at most $k$?

    **Counting Problem**

    e.g. Given $G$ and $k$, what is the number of spanning trees with weight at most $k$?

Since decision problem is the easiest among these four, and it's relatively easy to answer (just yes or no), **the problem we discuss is limited to decision problem**. If decision problem is hard, so as others.

If we specify $G$ and $k$ of the decision problem above, we have an **instance** of the problem. If the answer of the instance is **yes**, then we call it **yes-instance**, otherwise **no-instance**.

For computer, we need to encode the problem to make computer understand. So the decision problem above is encoded to

!!! plane ""

    Given a string $W$, is $w \in \{\text{encode}<G, k>: <G, k> \text{is a yes-instance}\}$?

So we abstract the problem to a set, which we call a **language**.

!!! definition "Definition | Alphabet and String"

    An **alphabet** $\Sigma$ is a *finite* set of symbols. e.g. $\Sigma = \{0 , 1\}$, $\Sigma = \emptyset$.

    A **string** is a *finite* sequence of symbols from some $\Sigma$.
    
    - The **length** of a string $|w|$ is the number of symbols in $w$.
    - Specially, we use $e$ to denote an empty string with $|e| = 0$.

    $\Sigma^i$ is the set of all strings of length $i$ over $\Sigma$.

    - e.g. for $\Sigma = \{0, 1\}$, $\Sigma^0 = \{e\}$, $\Sigma^1 = \{0, 1\}$, $\Sigma^2 = \{00, 01, 10, 11\}$.

    - Specially, $\Sigma^* = \bigcup\limits_{i \ge 0} \Sigma^i$, $\Sigma^+ = \bigcup\limits_{i \ge 1} \Sigma^i$.

!!! definition "Definition | Operation of String"

    - **concatnation**
        - $u = a_1\dots a_n, v = b_1\dots b_m$, $w = uv = a_1\dots a_nb_1\dots b_m$.

    - **exponentiation**
        - $w^i = \underbrace{w \cdots w}_{i\  \text{times}}$.

    - **reversal**
        - $w = a_1\dots a_n$, $w^R = a_n\dots a_1$.

!!! definition "Definition | Language"

    A **language** over $\Sigma$ is a subset $L \subseteq \Sigma^*$.


!!! theorem "Thesis"

    Decision problems is equivalent to languages. 

## Finite Automata


<div align="center">
<figure>
    <img src="../imgs/0.png" style="width:600px"/>
    <figcaption> state diagram </figcaption>
</figure>
</div>

The circle with an arrow pointing to it is **initial state** and the double circle is **final state**. Initial state is unique while final state can be several.

!!! definition

    A **deterministic finite automata (DFA)** is $M = (K, \Sigma, \delta, s, F)$, where

    - $K$ is a finite set of states.
    - $\Sigma$ is the input alphabet.
    - $s \in k$ is initial state.
    - $F \subseteq k$ is the set of final states.
    - $\delta$ is a transition **function**. It describes in the current state, when read a symbol, what will the next state be.

    $$
        \delta: K \times \Sigma \rightarrow K.
    $$

!!! definition

    A **configuration** is an element of $K \times \Sigma^*$ (current state and unread input). It pairs the current state the machine is in with the remaining input that it still has to process.

    **Yields** represents the transition from one configuration to another.

    - **Yields in one step** is a transition to the next state over 1 symbol of input. This is indicated by the yields or right tack symbol: $\vdash$. For a specific automata $M$, we denote it as $\vdash_M$.

        - $(q, w) \vdash_M (q', w')$ if $w = aw'$ for some $a \in \Sigma$ and $\delta(q, a) = q'$.
    
    - For abbreviating the transition across multiple steps, we use $\vdash_M^*$ (**Yields**).

        - $(q, w) \vdash_M^* (q', w')$ if $(q, w) = (q', w')$ or $(q, w) \vdash_M \cdots \vdash_M (q', w')$.
    
??? example

    For the automata in upper part of the state diagram above, if the configuration is $(q_0, 1001)$. We can describe the yields as

    $$
        (q_0, 1001) \vdash_M (q_0, 001) \vdash_M (q_1, 01) \vdash_M (q_2, 1) \vdash_M (q_2, e)
    $$

!!! definition

    $M$ **accepts** $w \in \Sigma^*$ if $(s, w) \vdash_M^* (q, e)$ for some $q \in F$.

    For $L(M) = \{ w \in \Sigma^*: M \text{ accepts } w \}$, we say $M$ **accpets** $L(M)$.


!!! definition

    A language is **regular（正则的）** if it is accepted by some FA (finite automata).

!!! definition

    **Regular Operations**

    If $A$ and $B$ are languages,

    - Union $A \cup B = \{w | w \in A \text{ or } w \in B\}$.
    - Concatnation $A \cdot B = \{ab | a \in A \text{ and } b \in B\}$.
    - Kleene Star $A^* = \{w_1w_2\cdots w_k| w_i \in A \text{ and } k \ge 0\}$.

!!! theorem

    If $A$ and $B$ are regular, so is $A \cup B$.

    ??? proof

        $\exists M_A = (K_A, \Sigma, \delta_A, s_A, F_A)$ accpets $A$, and $\exists M_B = (K_B, \Sigma, \delta_B, s_B, F_B)$ accpets $A$.

        We construct $\exists M_\cup = (K_\cup, \Sigma, \delta_\cup, s_\cup, F_\cup)$ where

        - $K_\cup = K_A \times K_B$.
        - $s_\cup = (s_A, s_B)$.
        - $F_\cup = \{(q_A, q_B) \in K_A \times K_B | q_A \in F_A \text{ or } q_B \in F_B\}$.
        - $\delta_\cup$: for any $q_A \in K_A$, $q_B \in K_B$, $a \in \Sigma$,

            $$
                \delta((q_A, q_B), a) = (\delta_A(q_A, a), \delta_B(q_B, a))
            $$

        Then $M_\cup$ accepts $A \cup B$.

!!! theorem

    If $A$ and $B$ are regular, so is $A \cap B$.
    If $A$ is regular, so is $\overline{A}$.