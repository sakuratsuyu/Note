# Lecture 4

## Context-Free Grammar and Context-Free Language

!!! definition

    A **context-free grammar (CFG)** $G = (V, \Sigma, S, R)$, where

    - $V$ is a **finite** set of symbols.
    - $\Sigma \subseteq V$ is the set of **terminals**.
        - $V - \Sigma$ is the set of **non-terminals**.
    - $S \in V - \Sigma$ is the **start symbol**.
    - $R \subseteq (V - \Sigma) \times V^*$ is a **finite** set of rules.
        - $(A, w)$ means $A \rightarrow w$.

!!! definition

    - $\forall x, y, u \in U^*, A \in U - \Sigma$, if $(A, u) \in R$, then we have $xAy \Rightarrow_G xuy$ and we say it **derive in one step**.

    - $\forall w, y, u \in U^*, A \in U - \Sigma$, if $w = u$ or $w \Rightarrow_G \cdots \Rightarrow_G u$, then we have $w \Rightarrow^*_G u$ and we say it **a derivation from $w$ to $u$ of length $n$**.

!!! definition

    $G$ generates $w \in \Sigma^*$ if $S \Rightarrow^*_G w$.

    For $L(G) = \{w \in \Sigma^* | G \text{ generates } w\}$., we say $G$ **generates** $L(G)$.

!!! definition

    We do a **leftmost derivation** of a string from a grammar by

    1. Begin with a string consisting only of the start symbol.
    2. Pick the **leftmost** variable occurrence in the current string.
    3. Pick any production that has that variable on the left of the $\rightarrow$.
    .
    4. Replace the chosen occurrence of that variable by the right-hand side of the chosen production.
    5. Repeat steps 2-4 until the string contains only terminals.

    Similarly, we have **rightmost derivation**.


Sometimes, leftmost derivation is the same as rightmost derivation.

!!! example

    For grammar $S \rightarrow SS$, $S \rightarrow (S)$, $S \rightarrow e$, to get $()()$ from $S$,

    - (leftmost) $S \rightarrow SS \rightarrow (S)S \rightarrow ()S \rightarrow ()(S) \rightarrow ()()$
    - (rightmost) $S \rightarrow SS \rightarrow S(S) \rightarrow S() \rightarrow (S)() \rightarrow ()()$

But sometimes not.

!!! example

    For grammar $E \rightarrow E + E$, $E \rightarrow E \times E$, $E \rightarrow (E)$, $E \rightarrow a$ to get $a + a \times a$ from $S$,

We call it an **ambiguous** expression. To find out the difference, we first introduce parse tree.


## Parse Tree

!!! definition

    Parse trees are a way of recording derivations that focus less upon the order in which derivation steps were applied and more on which productions were employed.

    A parse tree for a string $s$ in a languages described by a CFG is a tree in which

    1. The root of the tree is labeled with $S$.
    2. Each internal node is labeled with a variable.
    3. Each leaf node is labeled with a **terminal**.
    4. The leaf nodes, read from left to right, provide the string $s$.
    5. Each internal node labeled with a variable $A$ has children labeled with the symbols of $\alpha$ (reading left to right through the children) only if $A \rightarrow \alpha$ is a production in the grammar.

!!! example

    For the two cases above, their corresponding parse trees are

    ```mermaid
    graph TD;
        N1(("S"))
        N2(("S"))
        N3(("S"))
        N4(("("))
        N5(("S"))
        N6((")"))
        N7(("("))
        N8(("S"))
        N9((")"))
        N10(("e"))
        N11(("e"))
        N1 === N2
        N1 === N3
        N2 === N4
        N2 === N5
        N2 === N6
        N3 === N7
        N3 === N8
        N3 === N9
        N5 === N10
        N8 === N11
    ```

    === First Case (multiply then add)

        ```mermaid
        graph TD;
            N1(("E"))
            N2(("E"))
            N3(("+"))
            N4(("E"))
            N5(("a"))
            N6(("E"))
            N7(("×"))
            N8(("E"))
            N9(("a"))
            N10(("a"))
            N1 === N2
            N1 === N3
            N1 === N4
            N2 === N5
            N4 === N6
            N4 === N7
            N4 === N8
            N6 === N9
            N8 === N10

        ```
    
    === Second Case (add then muliply)

        ```mermaid
        graph TD;
            N1(("E"))
            N2(("E"))
            N3(("×"))
            N4(("E"))
            N5(("E"))
            N6(("+"))
            N7(("E"))
            N8(("a"))
            N9(("a"))
            N10(("a"))
            N1 === N2
            N1 === N3
            N1 === N4
            N2 === N5
            N2 === N6
            N2 === N7
            N4 === N8
            N5 === N9
            N7 === N10
        ```