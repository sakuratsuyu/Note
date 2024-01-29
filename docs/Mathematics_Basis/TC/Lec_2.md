# Lecture 2

## Non-deterministic finite automata

!!! definition

    A **non-deterministic finite automata (NFA)** is $M = (K, \Sigma, \Delta, s, F)$, where

    - $K$ is a finite set of states.
    - $\Sigma$ is the input alphabet.
    - $s \in k$ is initial state.
    - $F \subseteq k$ is the set of final states.
    - $\Delta$ is a transition **relation**. 

        $$
            \Delta \subseteq (K \times (\Sigma \cup \{e\})) \times K
        $$

    Configurations and yields are defined similarly to DFA.

    $M$ **accepts** $w \in \Sigma^*$ if $(s, w) \vdash_M^* (q, e)$ for some $q \in F$.

    For $L(M) = \{ w \in \Sigma^*: M \text{ accepts } w \}$, we say $M$ **accepts** $L(M)$.

The difference between DFA and NFA is that NFA allows

- more than one choice for next state.
- e-transition.

<div align="center">
<figure>
    <img src="../imgs/2.svg" style="width:200px"/>
    <figcaption> state diagram of NFA </figcaption>
</figure>
</div>

!!! tip "Insight | A Magic"

    We assume that NFA always makes the right guess.

!!! example

    Construct an FA that accepts

    $$
        L = \{w \in \{a, b\}^* | \text{ the second symbol from the end of $w$ is $b$.}\}
    $$

    <div align="center">
    <figure>
        <img src="../imgs/3.svg" style="width:300px"/>
    </figure>
    </div>

!!! theorem

    DFA is equvilent to NFA.

    - $\forall \text{ DFA } M', \exist \text{ NFA } M,\ s.t.\ L(M) = L(M').$
    - $\forall \text{ NFA } M, \exist \text{ DFA } M',\ s.t.\ L(M) = L(M').$

!!! proof

    The first claim is trivial. For the second claim,

    !!! plane ""

        **Idea** DFA $M'$ simulates "tree-like computation" of NFA $M$.
    
    $\forall \text{ NFA } M' = (K, \Sigma, \Delta, s, F)$, we construct a DFA $M' = (K', \Sigma, \delta, s', F')$, where

    - $K' = 2^K = \{Q | Q \subseteq K\}$.
    - $F' = \{Q \subseteq K | Q \cap F \neq \emptyset\}$.
    - $s' = E(s)$, where $E(q) = \{p \in K | (q, e) \vdash_M^* (p, e) \}$, $\forall q \in K$.
    - $\forall Q \in K', a \in \Sigma,\ \ \delta(Q, a) = \bigcup\limits_{q \in Q} \bigcup\limits_{p : (q, a, p) \in \Delta} E(p)$.

    Then we claim that $\forall p, q \in K, w \in \Sigma^*, (p, w) \vdash_M^* (q, e) \text{ iff } (E(p), w) \vdash_{M'}^* (Q, e), \text{ where } q \in Q$. (We can prove it by induction on $|w|$)

    Thus, DFA $M'$ accepts $w$ $\Leftrightarrow$ NFA $M$ accepts $w$.

!!! example

    !!! plane ""

        **NFA**

        <div align="center">
        <figure>
            <img src="../imgs/4.svg" style="width:200px"/>
        </figure>
        </div>

    !!! plane ""

        **DFA**

        <div align="center">
        <figure>
            <img src="../imgs/5.svg" style="width:300px"/>
        </figure>
        </div>

## Closure Property (Cont.)

Since the equivalence of NFA and DFA, so a language is regular if it's accepted by some NFA. Now we can prove the following theorem by NFA.

!!! theorem

    If $A$ and $B$ are regular, so is $A \cdot B$.

!!! proof

    !!! plane ""
        
        <div align="center">
        <figure>
            <img src="../imgs/6.svg" style="width:500px"/>
        </figure>
        </div>

    Since $A$ and $B$ are regular, thus there exist NFAs $M_A = (K_A, \Sigma, \Delta_A, s_A, F_A)$ and $M_B = (K_B, \Sigma, \Delta_B, s_B, F_B)$ which accepts $A$ and $B$ respectively.

    We construct an NFA $M_\circ = (K_\circ, \Sigma, \Delta_\circ, s_\circ, F_\circ)$, where

    - $K_\circ = K_A \cup K_B$.
    - $s_\circ = s_A$.
    - $F_\circ = F_B$.
    - $\Delta_\circ = \Delta_A \cup \Delta_B \cup \{(q, e, s_B) | q \in F_A\}$.

!!! theorem

    If $A$ is regular, so is $A^*$.

    !!! plane ""
        
        <div align="center">
        <figure>
            <img src="../imgs/7.svg" style="width:300px"/>
        </figure>
        </div>