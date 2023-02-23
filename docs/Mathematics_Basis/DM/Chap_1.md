# Chapter 1 | The Foundations: Logic and Proofs

## Proposition

!!! definition
    **Proposition (推断)** is a *statement* that is either true or false, but not both.

### Logical Operators / Connective

- **Negation (否定)** $\neg p$.
- **Conjunction (合取)** $p \wedge q$.
- **Disjunction (析取)** $p \vee q$.
- **Implication (条件 / 蕴含)** $p \rightarrow q$.
    - $p$ is called the *hypothesis (or antecedent or premise)*.
    - $q$ is called the *conclusion (or consequence)*.

    ??? example "Common Ways to Express Implication $p \rightarrow q$"
        - If $p$ then $q$.
        - $p$ is sufficient for $q$.
        - $p$ implies $q$.
        - $q$ is necessary for $p$.
        - If $q$ whenever $p$
        - $p$ only if $q$.

- **Biconditional (双条件)** $p \leftrightarrow q$.

**Priorities** $\neg$, then $\wedge\ \vee$, then $\rightarrow\ \leftrightarrow$.

!!! note "Remark"

    - There is no such a sign $\leftarrow$ in the discussion in Dicrete Mathematics.
    - Disjunction is **inclusive or**.

        ???+ example
            - inclusive or (或、兼或). *e.g.* I passed mathematics or English.
            - exclusive or (异或). *e.g.* Paul was born in 1983 or 1984.
        
    - 合取否定 (denoted by **Sheffer stroke 谢费尔竖线**) $p\uparrow q \Leftrightarrow \neg(p \wedge q)$，析取否定 (denoted by **Peirce arrow 皮尔斯箭头**) $p\downarrow q \Leftrightarrow \neg(p \vee q)$.

### Propositional Formula

!!! definition
    **(Well Formed) Formula (wff)** are one of the follows:

    - Propositional variable / Proposition, $T$, $F$.
    - $\neg A$, $(A \wedge B)$, $(A \vee B)$, $(A \rightarrow B)$, $(A \leftrightarrow B)$, if $A$ and $B$ are formulae.
    - Finitely many composed applications above.

!!! definition "Definition | Classification"

    - **tautology (重言式 / 永真式):** if its truth table contains only *true* values for every case.
    - **contradiction (永假式):** if its truth table contains only *false* values for every case.
    - **contingence:** neither a tautology nor a contradiction.

### Proposition Equivalences

!!! definition
    Formulae $A$ and $B$ are **logical equivalent** if $A \leftrightarrow B$ is tautology, denoted by $A \Leftrightarrow B$.

!!! definition
    if $p \rightarrow q$,

    - **inverse (否命题)** $\neg p \rightarrow \neg q$
    - **converse (逆命题)** $q \rightarrow p$
    - **contrapositive (逆否命题)** $\neg q \rightarrow \neg p$

    **NOTE:** $p \rightarrow q \Leftrightarrow \neg q \rightarrow \neg p$.

<div align="center">
	<img src="../Pic/0.png" style="width:430px"/>
</div>

<div align="center">
	<img src="../Pic/1.png" style="width:600px"/>
</div>

## Predicates and Quantifiers

!!! definition
    **Predicates (谓词 / 断言)** is a  statement of the form $P(x_1, x_2, \dots, x_n)$, where $P$ is a *propositional function* at the *n*-tuple $(x_1, x_2,\dots,x_n)$.

### Quantifier 量词

- domain / universe of discourse 论域
- universal quantifier 全称量词
    - For all $x$, $p(x): \forall xp(x)$.
- existential quantifier 存在量词
    - For some $x$, $p(x): \exists xp(x)$.

### Banding Variables

!!! definition
    When a quantifier is used on the variable $x$, then the occurrence of $x$ is **bound** while others are **free**.
    
    The part of a logical expression to which a quantifier is applied is called the **scope (辖域)** of this quantifier.

!!! note "Remark"

    - If the universe of discourse can be listed, then

        $$
            \forall xP(x) \Leftrightarrow P(x_1) \wedge \dots \wedge P(x_n)
        $$
        
        $$
            \exists xP(x) \Leftrightarrow P(x_1) \vee\dots \vee P(x_n)
        $$

    - Properties
        - De Morgan's Laws
        
            $$
                \neg \forall x p(x) \Leftrightarrow \exists x \neg p(x),\ \ \neg \exists x p(x) \Leftrightarrow \forall x \neg p(x).
            $$

        - 

            $$
            \begin{aligned}
                \forall x ((p(x) \wedge q(x)) & \Leftrightarrow (\forall x p(x)) \wedge (\forall x q(x)). \\
                \exists x ((p(x) \vee q(x)) & \Leftrightarrow (\exists x p(x)) \vee (\exists x q(x)).
            \end{aligned}
            $$

        - 

            $$
            \begin{aligned}
                \forall x q(x) \rightarrow A & \Leftrightarrow \exists x (q(x) \rightarrow A). \\
                \exists x q(x) \rightarrow A & \Leftrightarrow \forall x (q(x) \rightarrow A).
            \end{aligned}
            $$

## Method of Proof

!!! definition

    - An **axiom (公理)** is a proposition accepted as true without proof.
    - An **theorem (定理)** is a statement that can be shown to be true.
        - A **lemma (引理)** is a small theorem used to prove a bigger theorem.
        - A **corollary (推论)** is a theorem proven to be a logical consequnce of another theorem.
    - A **conjecture (猜想)** is a statement whose truth value is unknown.

### Valid Arguments

!!! definition
    **Deductive reasoning** the process of reaching a conclusion $q$ from a sequence of propositions $p_1,\dots,p_n$.

    - $p_1,\dots,p_n$ are premises or hypothesis.
    - $q$ is conclusion.

    An **argument** in propositional logic is a sequence of propositions. All but the final proposition in the argument are called **premises (假设)** and the final proposition is called the **conclusion (结论)**.

    An argument is **valid** if when all the hypotheses are true, the conclusion is true.  

### Rules of Inference

??? note "Glossary"
    Hypothetical Judgement 假言推断: Modus ponens 肯定前件式, Modus tollens 否定后件式.

    Hypothetical syllogism 假言三段论, Disjunctive syllogism 析取三段论.

    Addition 附加规则, Simplification 简化规则, Conjuction 合取规则, Resolution 消解原理.

<div align="center">
	<img src="../Pic/2.png" style="width:500px"/>
</div>

<div align="center">
	<img src="../Pic/3.png" style="width:400px"/>
</div>

!!! note "Remark"
    - $(p_1 \wedge p_2 \wedge \dots \wedge p_n) \rightarrow (p \rightarrow q) \Leftrightarrow (p_1 \wedge p_2 \wedge \dots \wedge p_n \wedge p) \rightarrow q$.
    
    !!! success "Contradiction 反证法"
        **Principle** $(p_1 \wedge p_2 \wedge \dots \wedge p_n) \rightarrow q \Leftrightarrow \neg (p_1 \wedge p_2 \wedge \dots \wedge p_n \wedge p_n \wedge \neg q)$

        **Steps** for proof $p \rightarrow q$:

        1. Assume $p$ is true and $q$ is false.
        2. Show that $\neg p$ is also true.
        3. $p \wedge \neg p = F$, which leads to a contradiction.

   - About **Resolution** rule
        - Use for automatic theorem proving.
        - $q\vee r$ is called the **resolvent**.


## Normal Form

!!! definition

    - A **literal** is a variable or its negation.
    - **Conjunctive clauses (short for clauses)** are conjunctions with literals as conjuncts.
    - A formula is in **disjunctive normal norm (DNF)** if it's wriiten as a disjunction of conjunctions of literals.

### Disjunctive Normal Form (DNF)

!!! quote
    Similar discussion can be seen in the canonical form and K-map of Digital Design.

$$
    \bigvee\limits _{i = 1}^{k} \bigwedge\limits _{j = 1}^{n_i} A_{ij} = (A_{11} \wedge A_{12} \wedge \dots \wedge A_{1n_1}) \vee \dots \vee (A_{k1} \wedge A_{k2} \wedge \dots \wedge A_{kn_1}).
$$

!!! theorem
    Any formula is tautologically equivalent to some formula in DNF.

### Full Disjunctvie Normal Form

!!! definition

    - A **minterm** is a conjunction of literals in which each variable is represented exactly one.
    - A full disjunctive form is a boolean function expressed as a disjunction of minterms.

!!! note "Remark"

    - $A \text{ is tautology} \Leftrightarrow \left(A \Leftrightarrow \bigvee\limits _{i = 0}^{2^n - 1}m_i\right)$
    - Full disjunctive form can be obtained by using truth table.
    - $\{\neg, \wedge, \vee\}$ is **functionally complete**.

### Conjuctive Normal Form (CNF) & Full Conjuctive Normal Form

> Similar to DNF / Full DNF.

$$
    \bigwedge\limits _{i = 1}^{k} \bigvee\limits _{j = 1}^{n_i} A_{ij} = (A_{11} \vee A_{12} \vee \dots \vee A_{1n_1}) \wedge \dots \wedge (A_{k1} \vee A_{k2} \vee \dots \vee A_{kn_1}).
$$

### Prenex Normal Form 前束范式

!!! definition
    A formula is in **prenex normal form** if it's of the form
    
    $$
        Q_1x_1Q_2x_2\cdots Q_nx_nB,
    $$
    
    where $Q_i(i = 1, 2, \cdots, n)$ is $\forall$ or $\exists$ and $B$ is quantifier free.

!!! success "Algorithm of prenex normal form"

    1. Rename bounded variables.
    2. Eliminate all connectives $\rightarrow$ and $\leftrightarrow$.
    3. Move all negations inward.
    4. Move all quantifiers to the front of the formula.

!!! example
    Convert

    $$
        \forall x (\forall y P(y, x) \rightarrow \exist y Q(x, y))
    $$

    into prenex normal form.

    **Solution.**

    $$
    \begin{aligned}
        \forall x & (\forall y P(y, x) \rightarrow \exists y Q(x, y)) \\
        & \Leftrightarrow \forall x (\neg \forall y P(y, x) \vee \exists y Q(x, y)) \\
        & \Leftrightarrow \forall x (\exists y \neg P(y, x) \vee \exists y Q(x, y)) \\
        & \Leftrightarrow \forall x (\exists y \neg P(y, x) \vee \exists z Q(x, z)) \\
        & \Leftrightarrow \forall x \exists y \exists z (\neg P(y, x) \vee Q(x, z)) \\
        & \Leftrightarrow \forall x \exists y \exists z (P(y, x) \rightarrow Q(x, z)) \\
    \end{aligned}
    $$