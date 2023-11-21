# Chapter 3 | The Fundamentals: Algorithms

## Algorithms

!!! definition
    An **algorithm** is a finite set of precise instructions for performing a computation or solving problem.

    **Pseudocode** is instructions given in a generic language similar to a computer language.

!!! theorem "Properties"
    - Input and Output
    - Definiteness
    - Correctness
    - Finiteness
    - Effectiveness
    - Generality

## Complexity

!!! definition
    **Complexity** is the amount of time or space needed to execute the algorithm.

    - Space Complexity
    - Time Complexity
        - Types: best-case time; worst-case time; average-case time.

!!! plane ""

    - **P-Class Problem**
        - P for 「polynomial」
        - problems that can be **solved** by polynomial time algorithm
    - **NP-Class Problem**
        - NP for 「nondeterministic polynomial」
        - problems for which a solution can be **checked** in polynomial time
    - **NP-Complete (NPC) Problem**
        - If any of these problems can be solved by polynomial worst-case time algorithm, then all can be solved by polynomial worst-case time algorithms.

    <div align="center">
    	<img src="../imgs/4.png" style="width:400px"/>
    </div>