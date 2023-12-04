# Lecture 7

## Variant of Turing Machine

There are some variants of the original Turing machine (TM), but they can be proved to be equivalent to TM.

### Multitape Turing Machine

!!! definition

    A $k$-tape Turing machine is a 5-tuple $M = (K, \Sigma, \delta, s, H)$, where the only difference from TM is

    $$
        \delta: (K - H) \times \Sigma^k \rightarrow K \times (\{\leftarrow, \rightarrow\} \cup (\Sigma - \{\triangleright\})^k).
    $$

!!! tip

    The idea to prove the equivalence between multitape TM and TM is to treat each element of the single tape of TM as a set of the elements on the corresponding position on the $k$-tapes.

### Two-way Infinite Tape Turing Machine

!!! definition

    A two-way infinite tape Turing machine is a 5-tuple $M = (K, \Sigma, \delta, s, H)$, where the only difference from TM is

    - $\Sigma$ no longer contains the left end symbol $\triangleright$.

!!! tip

    The idea to prove the equivalence is to treat the two-way infinite tape TM as a 2-tape Turing machine.

### Multi Head Turing Machine

Just multiple heads to move.

### Two-dimensional Tape Turing Machine

Build a mapping of integer to a 2-tuple of integer.

### Random Access Turing Machine

The step of movement of the head can be multiple.

---

Well, all of the variants above are trivial. The most important variant is the following one, non-deterministic TM.

## Non-deterministic Turing Machine

!!! definition

    A **non-deterministic Turing machine (NTM)** is a 5-tuple $M = (K, \Sigma, \Delta, s, H)$, where

    - $K$ is a finite set of states.
    - $\Sigma$ is the tape alphabet, containing the left end symbol $\triangleright$ the blank $\sqcup$.
    - $s \in K$ is the initial state.
    - $H \subseteq K$ is a set of halting state.
    - $\Delta$ is a **transition relation**. It describes in the current state, when read a symbol, what will the next state be and the head action be (move or write).

        $$
            \delta: (K - H) \times \Sigma \rightarrow K \times (\{\leftarrow, \rightarrow\} \cup (\Sigma - \{\triangleright\})).
        $$

        - Also, there is a limitation of $\delta$.

            $$
                \forall q \in K - H, \exists p \in K,\ \ s.t.\  \delta(q, \triangleright) = (p, \rightarrow)
            $$

!!! definition

    The definition of configuration and yields are the same as DTM.

!!! definition

    An NTM $M$ with input alphabet $\Sigma_0$ **semidecides** $L \subseteq \Sigma_0^*$ if $\forall w \in \Sigma_0^*$, $w \in L$ iff $(s, \triangleright \underline{\sqcup} w) \vdash_M^* (h, \dots)$ for some $h \in H$.

!!! definition

    An NTM $M$ with input alphabet $\Sigma_0$ **decides** $L \subseteq \Sigma_0^*$ if

    - $\exists N \in \mathbb{N},\ \forall w \in \Sigma_0^*, \text{ there is no configuration } C,\ \ s.t.\ (s, \triangleright \underline{\sqcup} w) \vdash_M^N C$.
    - $w \in L$ iff $(s, \triangleright \underline{\sqcup} w) \vdash_M^* (y, \dots)$.

    ??? tip

        You can similarly imagine the yields of NTM as a tree, these conditions are to say that the height of the tree is finite and some branch either accepts or rejects $w$.

!!! theorem

    Every NTM can be simulated by a DTM.

??? proof "Proof (sketch)"

    an NTM semidecides $L$ --> a DTM semidecides $L$.

    Since an NTM yields as a tree, we can use a DTM to simulate it by BFS. Specifically, we use a 3-tape DTM.
    
    - The first one stores the input $w$ and do nothing.
    - The second one simulates the NTM.
    - The third one enumerates the choice of BFS.


## Church-Turing Thesis

!!! theorem "Church-Turing Thesis"

    Algorithms are equivalent to Turing machines. Since algorithms solve decision problems and Turing machines decide language. We can also say decision problems are equivalent to language.

### Descriptions of TM

1. Formal definition $M = (K, \Sigma, \delta, s, H)$.
2. Implement-level description. Diagram.
3. High-level description. Pseudo code.

## Pseudo Code

The input of pseudo code is actually the encoding of the computation object. We need to first discuss about encoding. Here are some facts.

!!! plain ""

    - Any finite set can be encoded.
    - Any finite collection of finite sets can be encoded.

    For any compuatation object $O$, we use $\text{``}O\text{''}$ or $\langle O \rangle$ to denote its encoding.

Thus FA, PDA and TM can be encoded, since they are finite collections of finite sets.

!!! example

    Make a TM that decides $L = \{\langle G \rangle : G \text{ is a connected graph}\}$.

    $M$ = on input $\langle G \rangle$.

    0. **(Default, can be omitted)** if the input is illegal, then reject, else decode $\langle G \rangle$.
    1. select a node of $G$ and mark it.
    2. repeat the following until no new node is marked.
    3. &nbsp;&nbsp;&nbsp;&nbsp; for each marked node
    4. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mark all of its neighbor.
    5. if all the nodes are marked,
    6. &nbsp;&nbsp;&nbsp;&nbsp; accept,
    7. else,
    8. &nbsp;&nbsp;&nbsp;&nbsp; reject.

### Decidable Problems (Recursive Languages)

!!! example

    **R1**  $A_\text{DFA} = \{\langle D, w \rangle : D \text{ is a DFA 
    that accepts } w\}$.

    !!! plane ""

        $M_{R1}$ = on input $\langle D, w \rangle$

        1. run $D$ on $w$.
        2. if $D$ accepts $w$.
        3. &nbsp;&nbsp;&nbsp;&nbsp; accept $\langle D, w \rangle$,
        4. else,
        5. &nbsp;&nbsp;&nbsp;&nbsp; reject $\langle D, w \rangle$.

    **R2**
    
    $$
        A_\text{NFA} = \{\langle N, w \rangle : N \text{ is a NFA that accepts } w\}
    $$

    !!! plane ""

        $M_{R2}$ = on input $\langle N, w \rangle$

        1. build a DFA $D$ equivalent to $N$.
        2. run $M_{R1}$ on $\langle D, w \rangle$.
        3. output the result of $M_{R1}$.

    **R3** 
    
    $$
        A_\text{REX} = \{\langle R, w \rangle : R \text{ is a regular expression with } w \in L(R)\}
    $$

    !!! plane ""

        $M_{R2}$ = on input $\langle R, w \rangle$

        1. build an NFA $N$ equivalent to $R$.
        2. run $M_{R2}$ on $\langle N, w \rangle$.
        3. output the result of $M_{R1}$.
    
    **R4** $E_\text{DFA} = \{\langle D \rangle : D \text{ is a DFA with } L(D) = \emptyset\}$.

    !!! plane ""

        $M_{R4}$ = on input $\langle D \rangle$

        1. if $D$ has no final state,
        2. &nbsp;&nbsp;&nbsp;&nbsp; accept,
        3. else,
        4. &nbsp;&nbsp;&nbsp;&nbsp; run BFS on the diagram, starting with the inital state.
        5. if there exists a path from $s$ to final state,
        6. &nbsp;&nbsp;&nbsp;&nbsp; reject,
        7. else,
        8. &nbsp;&nbsp;&nbsp;&nbsp; accept.


    **R5** $EQ_\text{DFA} = \{\langle D_1, D_2 \rangle : D_1, D_2 \text{ are DFAs with } L(D_1) = L(D_2)\}$.

    !!! plane ""

        $M_{R5}$ = on input $\langle R, w \rangle$

        1. construct $D_3$ such that $L(D_3) = L(D_1) \oplus L(D_2)$ (symmetric difference).
        2. run $M_{R4}$ on $\langle D_3 \rangle$.
        3. output the result of $M_{R4}$.

!!! plane ""

    ## Reduction

    In the examples above, we use the idea of reduction (归约). Take R1 and R2 as example. The equivalence of DFA and NFA guarantees that

    $$
    \langle N, w \rangle \in A_{\text{NFA}} \text{ iff } \langle D, w \rangle \in A_{\text{DFA}}.
    $$

    > We will further discuss reduction in the next lecture.