# Chapter 6 | Programming

## Problem Solving

**Systematic Decomposition / Structured Programming**

A methodology that systematically breaks the larger tasks down into smaller ones.

The process is also referred as *stepwise refinement*.

### Three Constructs

!!! plane ""

    **Sequential** consturct
    
    Carry out the subtask sequentially, nerver going back.

!!! plane ""

    **Conditional** construct
    
    Do one of the two subtasks but not both, depending on some condition.
    
    Either subtask may be vacuous.

!!! plane ""

    **Iterative** construct
    
    Do a subtask a number of times, but only as long as some condition is true.

Each of the three possible decompositions, there is exactly *one entrance into the construct* and exactly *one exit out of the construct*.

<div style="text-align: center;">
    <figure>
        <img src="../imgs/54.png" width="80%" style="margin: 0 auto;">
    </figure>
</div>

---

<div style="text-align: center;">
    <figure>
        <img src="../imgs/55.png" width="80%" style="margin: 0 auto;">
        <caption>LC-3 implementation by BR instruction</caption>
    </figure>
</div>


## Debugging

The simplest way to keep track of where you are as compared to where you want to be is to *trace* the program.

When the behavior of the program as it is executing is different from what it should be doing, you know there is a bug.

A useful technique is to partition the program into parts, often referred to as **modules**, and examine the results that have been computed at the end of execution of each module.

!!! plane ""

    **corner cases**

    For a program to work, it must work for all valid source    operands, and a good test of the program is to set source operands to the unusual values, the ones the programmer may have failed to consider. These values are referred to colloquially as **corner cases**.

### Debugging Operations

#### Set Values
#### Execute Sequences
- **Run** command
- **Step** command
- **Set Breakpoint** command
#### Display Values

