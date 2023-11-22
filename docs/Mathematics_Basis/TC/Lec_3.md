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


From NFA to regular expression. For any NFA $M$, there exists a regular expression $R$, such that $L(R) = L(M)$.


We first simplify a specific NFA $M$ with the following steps to find its corresponding regular expression.

1. Simplify $M$ so that

    - no arc enters the initial state.
    - only one final state, and no arc leaves it.

    For the following NFA $M$,

    !!! plane ""

        <div align="center">
        <figure>
            <img src="../imgs/8.svg" style="height:200px"/>
        </figure>
        </div>
    
    we simplify it to
    
    !!! plane ""

        <div align="center">
        <figure>
            <img src="../imgs/9.svg" style="height:200px"/>
        </figure>
        </div>

2. Eliminate States

    There are only three connection situations of states.

    !!! plane ""

        <div align="center" style="text-align: center">
            <span style="vertical-align: middle">
                <img src="../imgs/10.svg" style="height:90px; vertical-align: middle"/>
                <span> ---\> </span>
                <img src="../imgs/11.svg" style="height:50px; vertical-align: middle"/>
            </span>
        </div>

        <div align="center" style="text-align: center">
            <span style="vertical-align: middle">
                <img src="../imgs/12.svg" style="height:50px; vertical-align: middle"/>
                <span> ---\> </span>
                <img src="../imgs/13.svg" style="height:50px; vertical-align: middle"/>
            </span>
        </div>

        <div align="center" style="text-align: center">
            <span style="vertical-align: middle">
                <img src="../imgs/14.svg" style="height:95px; vertical-align: middle"/>
                <span> ---\> </span>
                <img src="../imgs/15.svg" style="height:50px; vertical-align: middle"/>
            </span>
        </div>


??? example

    For the following instance of NFA,

    !!! plane ""

        <div align="center">
        <figure>
            <img src="../imgs/16.svg" style="height:200px"/>
        </figure>
        </div>

    we can finally simplify it to

    !!! plane ""

        <div align="center">
        <figure>
            <img src="../imgs/17.svg" style="height:50px"/>
        </figure>
        </div>
        

Based on the mechanism above, we can simply give the following more abstract proof.

!!! proof

    Now we back to the proof of the equivenlance of regular expression and NFA.

    (1) Regular expression $\Rightarrow$ NFA is trivial by definition.

    (2) We now proof NFA $\Rightarrow$ regular expression.

    Suppose an NFA $M = (K, \Sigma, \Delta, s, F)$ satisfying

    1. $K = \{q_1, \dots, q_n\}$, $s = q_{n - 1}$, $F = \{q_n\}$.
    2. $\forall p \in K, a \in \Sigma,\ \ (p, a, q_{n - 1}) \notin \Delta$.
    3. $\forall p \in K, a \in \Sigma,\ \ (q_n, a, p) \notin \Delta$.

    For any NFA that not satisfying the properties above, we can use the mechanism above to make it satisfy.

    Then we define a subproblem and use the idea of DP (Dynamic Programming) to prove.

    $\forall i, j, k \in [1, n] (i, j, k \in \mathbb{N})$, we define the regular expression $R_{ij}^{k}$ satisfying

    $$
        L(R_{ij}^{k}) = \{w \in \Sigma^* | w \text{ drives } M \text{ from } q_i \text{ to } q_j \text{ with no intermediate state having index} > k\}.
    $$

    Then our goal is to get $R_{(n - 1)n}^{n - 2}$.

    The base case ($k = 0$) is $\forall i, j \in [1, n] (i, j \in \mathbb{N})$,

    - if $i = j$, $R_{ij}^0 = \phi^* \cup a_1 \cup \cdots \cup a_m$, where $(q_i, a, q_j) \in \Delta$.
    - if $i \neq j$, $R_{ij}^0 = a_1 \cup \cdots \cup a_m$, where $(q_i, a, q_j) \in \Delta$.

    Then is the recurrence case.

    $$
        R_{ij}^{k} = R_{ij}^{k - 1} \cup R_{ik}^{k - 1}(R_{kk}^{k - 1})^* R_{kj}^{k - 1}
    $$
    
    <div align="center">
    <figure>
        <img src="../imgs/18.svg" style="height:200px"/>
    </figure>
    </div>


!!! theorem "Pumping Theorem"

    Let $L$ be a regular language. There exists an integer $p \ge 1$ such that $w \in L$ with $|w| \ge p$ can be divided into 3 parts $w = xyz$, where

    1. for each integer $i \ge 0$, $xy^iz \in L$.
    2. $|y| > 0$.
    3. $|xy| \le p$.

    We call the value $p$ **pumping length**.

    !!! plane ""

        **NOTE** This theorem is a necceasry condition of regular language but not sufficient.

!!! proof

    If $L$ is finite, just let $p = \max\limits_{w \in L} |w| + 1$. It's trivial.

    If $L$ is infinite, then there exists a DFA $M$ accepting $L$. Let $p$ be the number of the states of $M$, and $w = a_1\cdots a_n$ in $L$ with $|w| \ge p$.

    <div align="center">
    <figure>
        <img src="../imgs/19.svg" style="height:50px"/>
    </figure>
    </div>

    Then $\exists 0 \le i < j \le p$, such that $q_i = q_j$.

    <div align="center">
    <figure>
        <img src="../imgs/20.svg" style="height:200px"/>
    </figure>
    </div>

    So $x = a_1 \cdots a_i$, $y = a_{i + 1} \cdots a_j$ and $z = a_{j + 1} \cdots a_n$. And

    1. $xy^iz \in L$ for any $i \in \mathbb{N}$.
    2. $|y| = j - i > 0$.
    3. $|xy| = j < p$.

!!! example

    Show that $B = \{0^n1^n | n \in \mathbb{N}^*\}$ is not regular.

    !!! proof

        Assume $B$ is regular. Let $p$ be the pumping length given by the pumping theorem. Then $\forall w \in B, |w| \ge p$, or particularly, we let $w$ be

        $$
            w = 0^p 1^p
        $$

        Then $w$ can be written as $w = xyz$, such that

        1. $xy^iz \in L$ for any $i \in \mathbb{N}$.
        2. $|y| > 0$.
        3. $|xy| \le p$.

        From 2. and 3., we can infer that $y = 0^k$ for some integer $1 \le k \le p$.

        However, then $xy^0z = 0^{p - k}1^p \notin L$, which leads to a contradition with 1.

!!! example

    Show that $B = \{w \in \{0, 1\}^* | w \text{ has equal number of } 0 \text{ and } 1\}$ is not regular.

    !!! proof

        Simply proof by reduction. Suppose $B$ is regular, then $B \cap \{0^n1^n | n \in \mathbb{N}^*\}$ must also be regular, which is $\{0^n1^n | n \in \mathbb{N}^*\}$. But we've prove it not regular. So $B$ is not regular.