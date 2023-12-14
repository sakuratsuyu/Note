# Lecture 8

Continue examples of Decidable Problems from the last lecture.

!!! example

    **C1** $A_\text{CFG} = \{\langle G, w \rangle : G \text{ is a CFG that generates } w\}$.

    !!! plane ""

        $M_{C1}$ = on input $\langle G, w \rangle$

        1. build an CFG $G'$ in CNF equivalent to $G$.
        2. enumerate all the derivations of length $2|w| - 1$.

            > Recap the property of CFG in CNF that
            > if $G$ generates a string of length $n \ge 1$, then the length of derivation is exactly $2n-1$.

        3. if any of them generates $w$,
        4. &nbsp;&nbsp;&nbsp;&nbsp; accept $\langle G, w \rangle$,
        5. else,
        6. &nbsp;&nbsp;&nbsp;&nbsp; reject $\langle G, w \rangle$.

    **C2** $A_\text{PDA} = \{\langle P, w \rangle : P \text{ is a PDA that accepts } w\}$.

    !!! plane ""

        $M_{C2}$ = on input $\langle P, w \rangle$

        1. build an CFG $G$ equivalent to $P$.
        2. run $M_{C1}$ on $\langle G, w \rangle$.
        3. output the result of $M_{C1}$.
    
    **C3** $E_\text{CFG} = \{\langle G \rangle : G \text{ is a CFG with } L(G) = \emptyset\}$.

    !!! plane ""

        $M_{C3}$ = on input $\langle G \rangle$

        1. mark all terminals and $e$.
        2. repeat the following until no new symbol is marked.
        3. &nbsp;&nbsp;&nbsp;&nbsp; for each rule that the right side is all marked symbols
        4. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mark the left side symbols
        5. if start symbol is marked,
        6. &nbsp;&nbsp;&nbsp;&nbsp; reject,
        7. else,
        8. &nbsp;&nbsp;&nbsp;&nbsp; accept.

    **C4** $E_\text{PDA} = \{\langle P \rangle : P \text{ is a PDA with } L(P) = \emptyset\}$.

## Reduction

Now we give the formal definition of **reduction**.

!!! definition

    Let $A$ and $B$ be two languages over $\Sigma_A$ and $\Sigma_B$ respectively. A **reduction** from $A$ to $B$ is a recursive / computable function $f: \Sigma_A^* \rightarrow \Sigma_B^*$ such that for any $x \in \Sigma_A^*$

    $$
        x \in A \text{ iff } f(x) \in B.
    $$

!!! theorem

    Suppose that there exists a reduction $f$ from $A$ and $B$. If $B$ is recursive, A is recursive, denoted by $A \le B$. (If A is not recursive, B is not recursive).

!!! proof

    Since B is recursive, then there exists $M_B$ decides $B$.

    $M_A$ = on input $x$,

    1. compute $f(x)$.
    2. run $M_B$ on $f(x)$.
    3. output the result of $M_B$.

## Language Category

Now we know that enumerable recursive languages contain recusive languages. But we care about two questions:

!!! plane ""

    1. is there any language that is not enumerable?
    2. is there any language that is not recursive but enumerable recursive?

Before we dive in, let's recap something about equinumerosity.

!!! quote

    > [**Equinumerosity**](../../DM/Chap_2/#inifinite-sets) in **DM**.

    Two sets have **the same cardinality** or say are **equinumerous (等势的)** iff there is a *bijective* from $A$ to $B$, i.e.$|A| = |B|$.

    A set is **countable** if it is equinumerous with $\mathbb{N}$.

!!! plane ""

    !!! theorem "Lemma"

        $A$ is countable iff there exists an injection $f : A \rightarrow \mathbb{N}$.

    ??? proof

        $\Rightarrow$ it's trivial.

        $\Leftarrow$ if A is finite, it's trivial. If not, sort $A$ in increasing order of $f(a)$ and let $g(a)$ be the rank of $a$.

    !!! theorem "Corollary"

        Any subset of a countable set is countable.

!!! theorem

    Let $\Sigma$ be an alphabet, then $\Sigma^*$ is countable.

Since a Turing machine can be encoded in to a string, we have the following corollary

!!! theorem "Corollary"

    $\mathcal{M} = \{M : M \text{ is a TM}\}$ is countable.

!!! theorem

    Let $\Sigma$ be some non-empty alphabet, and $\mathcal{L}$ be the set of all languages over $\Sigma$. Then $\mathcal{L}$ is uncountable.

!!! proof

    Assume that $\mathcal{L}$ is countable, then the langauges in $\mathcal{L}$ can be labelled as

    $$
        L_1, L_2, L_3, \dots
    $$

    Since $\Sigma^*$ is countable, then the string in $\Sigma^*$ can be labelled as

    $$
        s_1, s_2, s_3, \dots
    $$

    We construct a set $D = \{s_i | s_i \notin L_i\}$. Then for any $i \in \mathbb{N}^*$, $s_i \in D$ iff $s_i \notin L_i$, and thus $D \neq L_i$. Therefore $D \notin \mathcal{L}$.

    But $D \in \Sigma^*$, and thus $D$ is a language, which leads to a contradiction. So the assumption is false and $\mathcal{L}$ is uncountable.


Since $\mathcal{L}$ is uncountable while $\mathcal{M}$ is countable, then we have the following fact.

!!! note "Fact"

    There exists some language that is not recursively enumerable.

Now we define

$$
H = \{\langle M, w \rangle : M \text{ is a TM that halts on } w\}.
$$

!!! theorem

    $H$ is recursively enumerable.

!!! proof

    $U$ = on input $\langle M, w \rangle$

    1. run $M$ on $w$.

    Then $U$ halts on $\langle M, w \rangle$ $\Leftrightarrow$ $M$ halts on $w$ $\Leftrightarrow$ $\langle M, w \rangle \in H$.

    > We also call $U$ **universal TM**. You can think $U$ is a computer, since it run an algorithm $M$ on some input $w$. Both of the algorithm and input are programmable.

!!! theorem

    $H$ is not recursive.

!!! proof

    Let $H_d = \{\langle M \rangle : M \text{ is a TM that does NOT halt on } \langle M \rangle\}$

    !!! theorem "Lemma 1"

        If $H$ is recursive, then $H_d$ is recursive.

    !!! proof
    
        Suppose $H$ is recursive, then there exists a TM $M_H$ that decides $H$.

        $M_d$ = on input $\langle M \rangle$

        1. run $M_H$ on $\langle M, M \rangle$.
        2. if $M_H$ accepts $\langle M, M \rangle$,
        3. &nbsp;&nbsp;&nbsp;&nbsp; reject $\langle M \rangle$,
        4. else,
        5. &nbsp;&nbsp;&nbsp;&nbsp; accept $\langle M \rangle$.

        Thus $M_d$ decides $H_d$ and $H_d$ is recursive.

    !!! theorem "Lemma 2"
    
        $H_d$ is NOT recursively enumerable.
    
    !!! proof

        Assume $H_d$ is recursively enumerable, then there exists a TM $D$ that semidecides $H_d$.

        $$
            D \text{ on input } \langle M \rangle
            \left\{
            \begin{aligned}
                & \text{halt}, && \langle M \rangle \in H_d, \\
                & \text{NOT halt}, && \langle M \rangle \notin H_d.
            \end{aligned}
            \right.
        $$

        Since $D$ is a Turing machine, substitute $M$ with $D$, we have

        $$
            D \text{ on input } \langle D \rangle
            \left\{
            \begin{aligned}
                & \text{halt}, && \langle D \rangle \in H_d, \\
                & \text{NOT halt}, && \langle D \rangle \notin H_d.
            \end{aligned}
            \right.
        $$

        It's a contradiction. So $H_d$ is NOT recursively enumerable.
    
    Combining Lemma 1 and Lemma 2, $H$ is not recursive.

Now we get two key examples for the questions.

!!! plane ""

    1. $H_d$ is not recursively enumerable.
    2. $H$ is recursively enumerable but not recursive.

## Examples of Reduction

Now that we have a powerful example $H$, which is recursively enumerable but not recursive. So to prove some language that is also recursively enumerable but not recursive, we can use reduction: just reduct $H$ to that langauge. Here we give some examples.

!!! example

    Show that $L_1 = \{\langle M \rangle : M \text{ is a TM that halts on } e\}$ is not recursive.

    !!! proof

        To use the reduction theorem, we need to construct some $M'$, such that

        $$
            \langle M, w \rangle \in H \text{ iff } \langle M' \rangle \in L_1
        $$

        $M'$ = on input $u$,

        1. run $M$ on $w$.

        Well, that's all.

!!! example

    Show that $L_2 = \{\langle M \rangle : M \text{ is a TM that halts on some input} \}$ is not recursive.

    Show that $L_3 = \{\langle M \rangle : M \text{ is a TM that halts on every input} \}$ is not recursive.

    !!! proof

        Notice the proof in $L_1$, we construct $M'$. And actually we have

        !!! plane ""
        
            $M'$ halts on $e$ $\Leftrightarrow$ $M'$ halts on some input $\Leftrightarrow$ $M'$ halts on every input $\Leftrightarrow$ $M$ halts on $w$.
        
        So $L_2$ and $L_3$ is proved.

!!! example

    Show that $L_4 = \{\langle M_1, M_2 \rangle : M_1 \text{ and } M_2 \text{ are two TMs with } L(M_1) = L(M_2) \}$ is not recursive.

    !!! proof

        $$
            \langle M \rangle \in L_3 \text{ iff } \langle M_1, M_2 \rangle \in L_4
        $$

        namely

        $$
            M \text{ halts on every input} \text{ iff } L(M_1) = L(M_2)
        $$

        $M$ halts on every input, which means $L(M) = \Sigma^*$. So we construct

        $M_1 = M$

        $M_2$ = on input $u$
        
        1. halt.