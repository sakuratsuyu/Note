# Chapter 8 | Data Structures

**Abstract Data types** or more colloquially data stuructures, are the complex items of information.

## Subroutines

**libraries** are the collections of some fragments  available to user programmer

Such program fragments are called *subroutines*, or alternatively, *procedures*, or in C terminology, *functions*.

### Call / Return Mechanism

<div style="text-align: center;">
    <figure>
        <img src="../imgs/57.png" width="90%" style="margin: 0 auto;">
    </figure>
</div

> We uses the call/return mechanism to direct the computer each time via the **call instruction** to the code A, and after the computer execute the code A, to the **return instruction** to the proper next instruction to be executed in the program.

**caller** is the program that contains the call.

**callee** is the subroutine that contains the return.

!!! ASMOP "JSR / JSRR"

    !!! plane ""
        JSR stands for Jump to SubRoutine.

    **Opcode** $\text{[15:12]} = 0100$

    **Operand**

    - $\text{[11]}$	: **Specification digit of addressing mode**
        - **JSR** (PC-relative) | if its value is `1`
            - the second operand is obtained by sign-extending bits $\text{[10:0]}$ to 16 bits.
        - **JSRR** (Base Register) | if its value is`0`
            - the second operands is the value in SR2 specified by bits $\text{[8:6]}$.
            - $\text{[10:9], [5,0]}$ must be `0`.
    
    **FUNCTION**

    $$
    \begin{aligned}
        \text{R7} &=&& \text{Incremented PC} \\
        \text{PC} &=&& \text{BaseR}\\
        \text{or} &=&& \text{Incremented PC} + \text{SEXT(PCoffset11)}
    \end{aligned}
    $$

    **Condition Codes**	:negative_squared_cross_mark:

    <div style="text-align: center;">
        <figure>
            <img src="../imgs/58.png" width="80%" style="margin: 0 auto;">
            <caption>encoding</caption>
        </figure>
    </div>

!!! ASMOP "RET"

    **Opcode** $\text{[15:12]} = 1100$

    **Operand**

    - $\text{[11:0]}$ : must be `000 111 000000`
    
    **FUNCTION**

    $$
        \text{PC} = \text{R7}
    $$

    **Condition Codes**	:negative_squared_cross_mark:

    <div style="text-align: center;">
        <figure>
            <img src="../imgs/59.png" width="80%" style="margin: 0 auto;">
            <caption>encoding</caption>
        </figure>
    </div>

### Saving and Restoring Registers

If a value in a register will be needed after someting else is stored in that register, we must *save* it before something else happens and *restore* it before it can be subsequently used.

A register value is saved by storing it in memory, and is restored by loading it back into the register.

**callee save** means the save/restore problem is handled by the callee.

**caller save** means the save/restore problem is handled by the caller. e.g. R7

## The Stack

### Property / Stack Protocol

The last thing stored in the stack is the first thing to remove.

Simply put : **Last In, First Out**, or **LIFO**.

### Implementaion

#### stack pointer, sp

It keeps track of the top of the stack. In LC-3, R6 is the stack pointer.

!!! note

    The values inserted into the stack are stored in memory locations having **decreasing** addresses. We say the stack *grows toward zero*.


#### Push

push a value onto the stack.

**overflow** : we can't push values where there is no space.

R5 is used to indicatie success (R5 = 0) or failure (R5 = 1) information.

```asm
; push the value in R0 onto the stack.
PUSH		ST		R1, PUSH_SAVE1

			LD		R1, STACK_MAX
			NOT		R1, R1
			ADD		R1, R1, #1
			ADD		R1, R1, R6
			BRz		OVERFLOW
	
			ADD		R6, R6, #-1
			STR		R0, R6, #0
			AND		R5, R5, #0
	
			LD		R1, PUSH_SAVE1
			RET
	
OVERFLOW	AND		R5, R5, #0
			ADD		R5, R5, #1

			LD		R1, PUSH_SAVE1
			RET

STACK_MAX	.FILL		ADDR				; the topmost address of stack
PUSH_SAVE1	.BLKW		#1
```
#### Pop

pop a value from the stack.

**underflow** : we can't pop values when the stack is empty.

R5 is used to indicatie success (R5 = 0) or failure (R5 = 1) information.

```asm
; Lazy Pop, without delete the element
; pop the value from the stack into R0.
POP			LD		R0, STACK_BASE
			NOT		R0, R0
			ADD		R0, R0, #1
			ADD		R0, R0, R6
			BRz		UNDERFLOW
	
			LDR		R0, R6, #0
			ADD		R6, R6, #1
			AND		R5, R5, #0
			RET
UNDERFLOW	AND		R5, R5, #0
			ADD		R5, R5, #1
			RET

STACK_BASE	.FILL		ADDR			; the bottommost address of the stack
```

# Recursion

Recursion is a mechanism for expressing a function *in terms of itself*.

**Stack** is used to implement the recursion. It stores the return linkage R7, the values used to solve the problem, and the other values concerning the save/restore problem.

!!! example "Factorial"

    ```asm
    ; Suppose we have MUL instruction.
    FACT		ADD		R6, R6, #-1
                STR		R1, R6, #0				; Push caller's R1
        
                ADD		R1, R0, #-1
                BRz		BASE_CASE				; n = 1 is the base case.
        
                ADD		R6, R6, #-1
                STR		R7, R6, #0				; Push return linkage
                ADD		R6, R6, #-1
                STR		R0, R6, R0				; Push n
        
                ADD		R0, R0, #-1
                JSR		FACT
        
                LDR		R1, R6, #0
                ADD		R6, R6, #1				: Pop n
                MUL		R0, R0, R1				; R0 <- n * (n - 1)!
        
                LDR		R7, R6, #0
                ADD		R6, R6, #1				; Pop return linkage

    BASE_CASE	LDR		R1, R6, #0
                ADD		R6, R6, #1				; Pop caller's R1

                RET
    ```

    <div style="text-align: center;">
        <figure>
            <img src="../imgs/60.png" width="80%" style="margin: 0 auto;">
            <caption>the stack during two instances of executing the FACT subroutine</caption>
        </figure>
    </div>

## The Queue

### Property

**First in First Out, FIFO.**

### Implementation

#### FRONT pointer & REAR pointer

In LC-3, R3 is the FRONT pointer and R4 is the REAR pointer.


#### Remove from Front & Insert at Rear

Considering **wrap around, underflow and overflow**.

R5 is used to indicatie success (R5 = 0) or failure (R5 = 1) information.

```asm
; don't consider queue initiation!

INSERT			ST		R1, QUQUE_SAVE1
				AND		R5, R5, #0

				LD		R1, NEG_LAST
				ADD		R1, R1, R4
				BRnp 	INSERT_SKIP_1
				LD		R4, FIRST			; Wrap around, R4 <- FIRST
				BRnzp	INSERT_SKIP_2
INSERT_SKIP_1	ADD		R4, R4, #1			; No wrap around, R4 <- R4 + 1

INSERT_SKIP_2	NOT		R1, R4
				ADD		R1, R1, #1			; R1 = - REAR
				ADD		R1, R1, R3			; R1 <- FRONT - REAR
				BRz		OVERFLOW

				STR		R0, R4, #0			; Do the insert
				BRnzp	INSERT_DONE

OVERFLOW		LD		R1, NEG_FIRST
				ADD		R1, R1, R4
				BRnp	INSERT_SKIP_3
				LD		R4, LAST			; Wrap around, R4 <- LAST
				BRnzp	INSERT_SKIP_4
INSERT_SKIP_3	ADD		R4, R4, #-1			; No wrap around, R4 <- R4 - 1

INSERT_SKIP_4	ADD		R5, R5, #1

INSERT_DONE		LD		R1, QUEUE_SAVE1              
				RET

REMOVE			ST		R1, QUQUE_SAVE1
				AND		R5, R5, #0
	
				NOT		R1, R4
				ADD		R1, R1, #1			; R1 = - REAR
				ADD		R1, R1, R3			; R1 = FRONT - REAR
				BRz		UNDERFLOW
	
				LD		R1, NEG_LAST
				ADD		R1, R1, R3
				BRnp 	REMOVE_SKIP_1
				LD		R3, FIRST			; Wrap around, R3 <- FIRST
				BRnzp	REMOVE_SKIP_2
REMOVE_SKIP_1	ADD		R3, R3, #1			; No wrap around, R3 <- R3 + 1

REMOVE_SKIP_2	LDR		R0, R3, #0			; Do the remove
				BRnzp	REMOVE_DONE

UNDERFLOW		ADD		R5, R5, #1

REMOVE_DONE   	LD		R1, QUEUE_SAVE1
				RET

LAST			.FILL		ADDR1	; the topmost memory space
NEG_LAST		.FILL		-ADDR1
FIRST			.FILL		ADDR2	; the bottommost memory space
NEG_FIRST		.FILL		-ADDR2
QUEUE_SAVE1		.BLKW		1
```

#### How many elements can be stored in a Queue?

In order to differentiate the full queue and the empty queue, we only allow a queue to store only$n - 1$elements if$n$`elements has been allocated.

A queue is full when there are$n - 1$elements in the queue, i.e. `FRONT - 1 == REAR`.

A queue if full when `FRONT == REAR`.

<div style="text-align: center;">
    <figure>
        <img src="../imgs/61.png" width="80%" style="margin: 0 auto;">
    </figure>
</div>


# Character Strings

A one-dimensional array of ASCII codes, and at the end the null character $\text{x0000}$ indicates the end of the character string.