# Lecture 2

!!! definition

    A **non-deterministic finite automata (NFA)** is $M = (K, \Sigma, \Delta, s, F)$, where

    - $K$ is a finite set of states.
    - $\Sigma$ is the input alphabet.
    - $s \in k$ is initial state.
    - $F \subseteq k$ is the set of final states.
    - $\Delta$ is a transition **relation**. 

    $$
        \Delta \subseteq K \times (\Sigma \cup \{e\}) \times K
    $$

    Configurations and yields are defined similarly to DFA.

    $M$ **accepts** $w \in \Sigma^*$ if $(s, w) \vdash_M^* (q, e)$ for some $q \in F$.

    For $L(M) = \{ w \in \Sigma^*: M \text{ accepts } w \}$, we say $M$ **accpets** $L(M)$.

The difference between DFA and NFA is that NFA allows

- more than one choice for next state.
- e-transition.

<div align="center">
<figure>
    <img src="../imgs/1.png" style="width:300px"/>
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

    ```mermaid
    flowchart LR
        start(( )) --> q1((q1))
        q1 -- a, b --> q1
        q1 -- b --> q2((q2))
        q2 -- a, b --> q3(((q3)))

        style start fill:#000,stroke-width:0px
        style q1 stroke-width:0px
        style q2 stroke-width:0px
        style q3 fill:#bbf,stroke:#333,stroke-width:2px
    ```

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

    Thus, DFA $M'$ accpets $w$ $\Leftrightarrow$ NFA $M$ accpets $w$.

!!! example

    !!! plane ""

        **NFA**

        ```mermaid
        flowchart LR
            start(( )) --> q0((q0))
            q0 -- a --> q0
            q0 -- b --> q1(((q1)))
            q1 -- e --> q0

            style start fill:#000,stroke-width:0px
            style q0 stroke-width:0px
            style q1 fill:#bbf,stroke:#333,stroke-width:2px
        ```

    !!! plane ""

        **DFA**

        ```mermaid
        flowchart LR
            start(( )) --> Q0(("{q0}"))
            Q0 -- a --> Q0
            Q0 -- b --> Q1((("{q0, q1}")))
            Q1 -- a --> Q0
            Q1 -- b --> Q1

            style start fill:#000,stroke-width:0px
            style Q0 stroke-width:0px
            style Q1 fill:#bbf,stroke:#333,stroke-width:2px
        ```

        ```mermaid
        flowchart LR
            Q0((("{q1}"))) -- a, b --> Q1(("Φ"))
            Q1 -- a, b --> Q1

            style Q1 stroke-width:0px
            style Q0 fill:#bbf,stroke:#333,stroke-width:2px
        ```

Since the equivalence of NFA and DFA, so a language is regular if it's accepted by some NFA. Now we can prove the following theorem by NFA.

!!! theorem

    If $A$ and $B$ are regular, so is $A \cdot B$ (or $A \circ B$).

!!! proof

    !!! plane ""

        ```mermaid
        ---
        title: Idea
        ---
        flowchart LR
            start(( )) --> startA
            Q0A -- e --> startB
            Q1A -- e --> startB
            style start fill:#000,stroke-width:0px

            subgraph M_circ
            subgraph M_A
                startA(( )) -- ... --> Q0A((( )))
                startA(( )) -- ... --> Q1A((( )))
                style Q0A fill:#bbf,stroke:#333,stroke-width:2px
                style Q1A fill:#bbf,stroke:#333,stroke-width:2px
            end

            subgraph M_B
                startB(( )) -- ...  --> Q0B((( )))
                startB(( )) -- ...  --> Q1B((( )))
                style Q0B fill:#bbf,stroke:#333,stroke-width:2px
                style Q1B fill:#bbf,stroke:#333,stroke-width:2px
            end
            end
        ```

    Since $A$ and $B$ are regular, thus there exist NFAs $M_A = (K_A, \Sigma, \Delta_A, s_A, F_A)$ and $M_B = (K_B, \Sigma, \Delta_B, s_B, F_B)$ which accpets $A$ and $B$ respectively.

    We construct an NFA $M_\circ = (K_\circ, \Sigma, \Delta_\circ, s_\circ, F_\circ)$, where

    - $K_\circ = K_A \cup K_B$.
    - $s_\circ = s_A$.
    - $F_\circ = F_B$.
    - $\Delta_\circ = \Delta_A \cup \Delta_B \cup \{(q, e, s_B) | q \in F_A\}$.

!!! theorem

    If $A$ is regular, so is $A^*$.

    !!! plane ""

        ```mermaid
        ---
        title: Idea
        ---
        flowchart LR
            start(( )) --> s
            s(( )) --> startA
            Q0A -- e --> startA
            Q1A -- e --> startA
            style start fill:#000,stroke-width:0px

            subgraph M
                startA(( )) -- ... --> Q0A((( )))
                startA(( )) -- ... --> Q1A((( )))
                style Q0A fill:#bbf,stroke:#333,stroke-width:2px
                style Q1A fill:#bbf,stroke:#333,stroke-width:2px
            end
        ```