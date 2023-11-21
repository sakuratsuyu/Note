# Chapter 11 | Trees

!!! definition
    A **tree** $T$ is a connected undirected graph with no simple circuit. A **forest** is an undirected graph with no simple circuit.

!!! theorem
    An undirected graph is a tree iff there is a unique simple path between any two of its vertices.

!!! definition
    A particular vertex of a tree is designated as the **root**. Once we specify the root, we can assign a direction to each edge. We direct each edge away from the root. Thus, a tree together with its root produces a directed graph called a **rooted tree**.

!!! definition
    
    - **Leaf** is the vertex that have no children.
    - **Internal vertex** is the vertex that have children.
    - Let $T$ be a rooted tree.
        - **level** $l(v)$ is the length of the simple path from root to $v$.
        - **height** $h = \max\limits_{v \in V(T)} l(v)$.
    - ***m*-ary tree *m* 元树** is a tree that every internal vertex has no more than $m$ children.
    - **Full *m*-ary tree** is a tree that every internal vertex has exactly $m$ children.
    - **Ordered rooted tree** is a tree that the children of each internal vertex are ordered, namely each children is unique. e.g. binary tree is often ordered, since it distinguishes *left* child and *right* child.
    - A rooted *m*-ary tree of height $h$ is **balanced** if all leaves are at levels $h$ or $h - 1$.

!!! plane ""
    **NOTE** In most cases, we treat a tree as an **ordered rooted tree**, and often only discuss **binary tree** in [FDS](../../../Computer_Science_Courses/FDS/Trees).

## Property

!!! theorem
    A tree with $n$ vertices has $n - 1$ edges.

!!! theorem
    A full *m*-ary tree with $i$ internal vertices contains $n = mi + 1$ vertices.

    Moreover, suppose $l$ is the number of leaves. With the equations

    $$
        n = mi + 1,\ \ n = l + i,
    $$

    if one of $n$, $i$ and $l$ is known, the other two quantities are determined.

!!! theorem
    There are at most $m^h$ leaves in *m*-ary tree of height $h$.

!!! theorem "Corollary"
    If an *m*-ary tree of height $h$ has $l$ leaves, then $h \ge \lceil \log _m l \rceil$. If it's full and balanced, then $h = \lceil \log _m l \rceil$.

## Application

### Binary Search Tree (BST)

> Refer to [Binary Search Tree](../../../Computer_Science_Courses/FDS/Trees/#binary-search-tree-bst).

### Prefix Codes

!!! definition
    To ensure that no bit string corresponds to more than one sequence of letters, the bit string for a letter must never occur as the first part of the string for another letter. Codes with this propertiy are called **prefix codes**.

!!! example
    To encode $\{a, b, c, d\}$ four characters, $\{0, 1, 01, 001\}$ is not prefix codes, but $\{0, 10, 110, 111\}$ is.

!!! plane ""
    A prefix code can be represented by a binary tree.
    
    <div align="center">
    	<img src="../imgs/10.png" style="width:200px"/>
    </div>

!!! note "Extension: Huffman Coding"
    !!! question "Remains"

### Decision Trees

!!! definition
    A rooted tree in which each internal vertex corresponds to a decision, with a subtree at these vertices for each possible outcome of the decision, is called a **decision tree**.

## Tree Traversal

> Refer to [Traversals](../../../Computer_Science_Courses/FDS/Trees/#traversals).

## Spanning Trees

We can consturct spanning trees by DFS or BFS.

> Refer to [MST](../../../Computer_Science_Courses/FDS/Graph/#minimum-spanning-tree-mstTrees/#traversals).