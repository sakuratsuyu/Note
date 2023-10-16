# Lecture 3

## Regular Expression

!!! definition

    Suppose an alphabet $\Sigma$,

    #### Atomic

    - For a regular expression $\phi$, its language is $L(\phi) = \phi$.
    - For a regular expression $a \in \Sigma$, its language is $L(a) = \{a\}$.

    #### Composite

    - For a regular expression $L(R_1 \cup R_2)$, its language is $L(R_1 \cup R_2) = L(R_1) \cup L(R_2)$.
    - For a regular expression $L(R_1 \circ R_2)$, its language is $L(R_1 \circ R_2) = L(R_1) \circ L(R_2)$.
    - For a regular expression $L(R^*)$, its language is $L(R^*) = (L(R))^*$.

    !!! plane ""

        **Precedence** $^* > \circ > \cup$.

!!! example

    | Language | Regular Expression |
    | -------- | ------------------ |
    | $\{e\}$  | $\phi^*$           |
    | $\{w \in (a \cup b)^* \| w \text{ starts with } a \text{ and end with } b\}$ | $a(a \cup b)^* b$ |
    | $\{w \in (a \cup b)^* \| w \text{ has at least two occurences of } a\}$ | $(a \cup b)^*a(a \cup b)^* a(a \cup b)^*$ |

!!! theorem

    A language $B$ is regular iff there is some regular expression $R$ with $L(R) = B$.

!!! proof

    Namely to proof the equivenlance of regular expression and NFA.

    (1) Regular expression $\Rightarrow$ NFA is trivial by definition.
    (2) We now proof NFA $\Rightarrow$ regular expression.