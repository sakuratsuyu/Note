# Chapter 2 | Basic Structures: Sets and Functions

## Set and Subset

!!! definition
    The objects in a set are **elements**. A **set** *contains* its elements.

- **Ways to describe sets:** List; Predicate; Venn Diagram.
- **Properties of sets:** Certainty; Don't care order and repetition of elements; Finite and Infinite set.
- **Subset**

    $$
        S \subseteq T \Leftrightarrow (\forall x \in S \Rightarrow x \in T).
    $$

- **Proper subset (真子集)**

    $$
        S \subset T \Leftrightarrow (\forall x \in S \Rightarrow x \in T) \wedge S \ne T.
    $$

- **Empty set $\emptyset$ and Universal set $U$**

    $$
        \text{For any set } A,\ \ A \subseteq A,\ \ \emptyset \subseteq A \subseteq U.
    $$

### Operations

- Union	$A \cup B = \{x | x \in A \vee x \in B\}$.
- Intersection	$A \cap B = \{x | x \in A \wedge x \in B\}$.
- Difference	$A -B = \{x | x \in A \wedge x \notin B\}$.
- Complement	$\overline{A} = U - A$.
- **Symmetric Difference** $A \oplus B = (A - B) \cup (B - A)$.
    - Properties
        
        $$
            A \oplus B = B \oplus A,\ \ (A \oplus B) \oplus C = A \oplus (B \oplus C),\ \ A \oplus A = \emptyset,\ \ A \oplus \emptyset = A.
        $$

        $$
            A \oplus B = A \oplus C \Rightarrow B = C.
        $$

### Power Set

!!! definition
    For a set $S$, **the power set** of $S$ is the set of all subsets of the set $S$, denoted by

    $$
        P(S) = 2^S = \{T | T \subseteq S\}.
    $$

If a set has $n$ elements, then its power set has $2^n$ elements.

### Cartesian Product

!!! definition
    For two sets $A$ and $B$, the **Cartesian product** of $A$ and $B$ is the set of all ordered pairs $(a, b)$ where $a \in A$ and $b \in B$, denoted by

    $$
        A \times B = \{(a, b) | a \in A \wedge b \in B\}.
    $$

    Generally for $n$ sets $A_1, \dots, A_n$, 
    
    $$
        A_1 \times A_2 \times \ \cdots \times A_n = \{(a_1, a_2, \dots a_n) | a_i \in A_i \text{ for } i = 1, 2, \dots, n\}.
    $$

!!! theorem "Properties"

    - $A \times \emptyset = \emptyset \times A = \emptyset$.
    - In general, $A \times B \ne B \times A$.
    - In general, $(A \times B) \times C \ne A \times (B \times C)$, unless we identify $((a, b), c)= (a, (b, c))$.
    - 
        $$
        \begin{aligned}
            A \times (B \cup C) = (A \times B) \cup (A \times C), \\
            A \times (B \cap C) = (A \times B) \cap (A \times C).
        \end{aligned}
        $$

    - If $A \subseteq C$ and $B \subseteq D$, then $A \times B \subseteq C \times D$, but **not** vice versa.
    - $(A \cap B) \times (C \cap D) = (A \times C) \cap (B \times D)$.

## Cardinality of Finite and Infinite Sets

**Cardinality** is the size of a set $S$, denoted by $|S|$.

### Finite Sets

!!! theorem "Theorem | Prniciple of Inclusion-exclusion 容斥原理"

    $$
        |A \cup B| = |A| + |B| - |A \cap B|.
    $$

    More generally, 
    
    $$
        \left|\bigcup_{i = 1}^nA_i\right| = \sum_{i = 1}^n|A_i| - \sum_{1 \le i \ne j \le n} |A_i \cap A_j| + \cdots + (-1)^{n-1}\left|\bigcap_{i = 1]}^n A_i\right|.
    $$

### Inifinite Sets

!!! definition
    Two sets have **the same cardinality** or say are **equinumerous (等势的)** iff there is an *bijective* from $A$ to $B$, i.e.$|A| = |B|$.

- Countable (denumerable) set
    - A set that is equinumerous with $\mathbb{N}$, e.g. $\mathbb{Z}$, $\mathbb{Q}$, $\mathbb{N} \times \mathbb{N}$.
    - $\aleph_0$ is called **countable**.
    - Properties
        - Countable set is the smallest infinite set.
        - The union of **two / finite number of / a countable number of** countable sets is countable.
- Uncountable set

!!! theorem

    - $\left|2^A\right| > |A|$.
    - $|\mathbb{R}| = \aleph_1 > \aleph_0$.

!!! plane ""
    **Continuum Hypothesis (CH) 连续统假设**

    $$
        \exists ? \omega,\ \ s.t.\ \aleph_0 \lt \omega \lt \aleph_1.
    $$

## Functions

$$
    f: A \rightarrow B \Leftrightarrow \forall a \in A,\ \ \exists b \in B : f(a) = b
$$

$f$ maps $A$ to $B$.

- $A$ is the **domain** of $f$, $\text{Dom } f = A$.
- $B$ is the **codomain** of $f$, $\text{Codom } f = B$.
- $f(a) = b,\ \ a \in A,\ \ b \in B$. $b$ is the **image** of $a$, $a$ is a **pre-image** of $b$.
- $\text{Range}(f) = \{b \in B | \exist a \in A, f(a) = b\}$.

- **One-to-one function (Injective) 单射**
    
    $$
        (\forall a, b \in A) \wedge (a \ne b) \Rightarrow f(a) \ne f(b).
    $$

- **Onto function (Subjective) 满射**
    
    $$
        \forall b \in B,\ \ \exist a \in A,\ \ s.t.\ f(a) = b.
    $$

- **One-to-one Correspondence (Bijective) 双射**
    
    <div align="center">
        one-to-one + onto
    </div>

### Inverse and Composition

!!! definition "Definition | Inverse Function"
    If $f$ is bijective, then $f^{-1}:B\rightarrow A$ is the **inverse function** of$f$.
    
    $$
        \forall a \in A, b \in B,\ \ (f(a) = b) \Leftrightarrow (f^{-1}(b) = a).
    $$

    Thus we also call a one-to-one correspondence **invertible**.

!!! definition "Definition | Composition"
    If $g: A\rightarrow B$ and $f:B\rightarrow C$, then $f\circ g : A\rightarrow C$ the **composition** of $f$ and $g$.
    
    $$
        \forall a \in A,\ \ (f\circ g)(a) = f(g(a)).
    $$


!!! note "Two Important Functions"
    - **Floor functions** $\lfloor x \rfloor$ (or by convetion $[x]$, or called greatest integer function).
    - **Ceiling functions** $\lceil x \rceil$.

### Growth of Function

!!! quote
    Similar to [**Algorithm Analysis**](../../../Computer_Science_Courses/FDS/Algorithm_Analysis/#asymptotic-notation) in **FDS**.

    BIG-O NOTATION, BIG-OMEGA NOTATION and BIG-THETA NOTATION.


!!! theorem
    If

	$$
        f(x) = a_nx^n + \cdots + a_1x + a_0,
    $$
    
    then $f(x)$ is $O(x^n)$.

!!! definition
    If $f(x) = \Theta(g(x))$, then we say $f(x)$ is of order $g(x)$.