# Pot-pourri

> some terminology or other useful things from Chapter 11 to Chapter 19, which composes the second part of the textbook.

## Chapter 11 Introduction to C/C++ Programming

### C Standard

##### ANSI C, or C18 (American National Standards Institute)

It approves *an unambiguous and machine-independent definition of the language C*.

C89, C90, C99, C11

##### Other standards

ISO C, Standard C

### Translating High-Level Language Programs

Two translation techniques

##### Interpretation

With interpretation, a translation program called an *interpreter* reads in the high-level program and performs the operations indicated by the programmer.

The high-level language program is not directly executed by the hardware but is input data for the interpreter. The interpreter is a *virtual machine* that executes the program in an isolated sandbox.

Many interpreters translate the high-level language program section by section, one line, command , or subroutine at  a time.

##### Compilation

The translator is a *compiler*. The compilation process completely translates the high-level language program into machine language, or a form very close to machine language. An executable image is an output of the compilation process.

##### Pros and Cons

With interpretation, developing and debugging a program are usually easier. Interpreted code is more easily portable across different cmoputing systems. But program takes longer to execute.

With compilation, the programmer can produce code that executes more quickly and uses memory more efficiently.

### Compilation Process

##### The Compiler

Two major phases of compliation

- Analysis
   - the source program is broken down or parsed into its constituent parts
- Synthesis
   - a machine code version of the program is generated (object module)

**Symbol Table**

the compiler's internal bookkeeping method for keeping track of all the symbolic names used in the program.

Note that the compiler records a variable's location in memory as an offset, with most offsets being negative.

<div style="text-align: center;">
    <figure>
        <img src="../imgs/75.png" width="70%" style="margin: 0 auto;">
    </figure>
</div>

##### The Linker

It links all object modules to form an executable image of the program.

<div style="text-align: center;">
    <figure>
        <img src="../imgs/76.png" width="80%" style="margin: 0 auto;">
    </figure>
</div>


## Chapter 12 Variables and Operators

Variables are the most basic type of *memory object*.
The compiler uses a variable's type information to allocate a proper amount of storage for the variable. Also, type indicates how operations on the variable are to be perform at the machine level.

In C, a variable's declaration conveys these pieces of information to the compiler : *identifier*, *type*, *scope*.

In C, a *block* is any subsection of a program beginning with `{` and ending with `}`.

!!! plane ""

    **Identifier**

    variable names or function names.

    **Modifier**

    `long` `short` `unsigned`

    **Assignment**

    The left-hand side is *assigned* the value of the right-hand side.
    In general, in C, shorter types are converted to longer types.


    **Arithmetic operators**

    The order in which operators are evaluated is called *precedence*.

    For operations of equal precedence, their *associativity* determines the order in which they are evaluated.

    `%` integer remainder operator

### Allocating Spce for Variables

There are two regions of memory in which declared variables in C are allocated storage : the *global data section* and the *run-time stack*.

##### Global data section

Global variables are allocated storage in the global data section.

$\text{R4}$ contains the address of the beginning of the global data section.

##### Run-time stack

Local variable is on the run-time stack, in units of allocation called *activation records* or *stack frames*（栈帧）.

Whenever a particular function is executing, the highest numbered memory address of its stack frame will be stored in $\text{R5}$, which is called the **frame pointer**.

From Symbol Table, $\text{Abosolute memory location = R5 + offset(relative location)}$.

$\text{R6}$ contains the address of the top of the run-time stack, whic is called the **stack pointer**.

Consider the implementation of functions in C.


##### Heap

Another region reserved for dynamically allocated data.

Both the run-time stack and the heap can change size as the program executes.


<div style="text-align: center;">
    <figure>
        <img src="../imgs/77.png" width="80%" style="margin: 0 auto;">
        <caption>LC-3 memory map</caption>
    </figure>
</div>


## Chapter 13 Control Structures

### Conditional Constructs

The statement following the condition can be a *compound statement* or *block*.

It's legal the *nest* an `if` statement within another `if` statement.

### Iteration Constructs

The `while` statement is useful for coding loops where the iteration process involves testing for a *sentinel* condition.


## Chapter 14 Functions

### Declaration

> or called *function prototype*.

It contains the name of the function, the type of value it returns, and a list of input arguments along with associated types.

### Definition

Within the parentheses after the name of the function is the function's *formal parameter list*.

In C, the arguments of the caller are *passed as values* to the callee.

### Implementation

Four basic phases

1. Argument values from the caller are passed to the callee.
2. Control is transferred to the callee.
3. The callee executes its task.
4. Control is passed back to the caller along with a return value.

In C, each function is required to be *caller-independent*. That is, a function should be callable from any function.

Each function has a memory template, called stack frame or activation record, where it stores its local variables, some bookkeeping information, and its parameter variables.

**In the stack protocol, the arguments of a C function call are pushed onto the stack from RIGHT to LEFT.**

- consider the parameter list of `scanf`.

??? example "An example of run-time stack in the implementation of functions"

    ```c
    int main(void) {
            int a;
            int b;
            ...
            b = Watt(a);
            b = Volt(a, b);
    }

    int Watt(int a) {
            int w;
            ...
            w = Volt(w, 10);
            return w;
    }

    int Volt(int q, int r) {
            int k;
            int m;
            ...
            return k;
    }
    ```

    ```asm
    Watt: 	...
            AND		R0, R0, #0
            ADD		R0, R0, #10
            ADD		R6, R6, #-1
            STR		R0, R6, #0		; Push 10
        
            LDR		R0, R5, #0		; Load w
            ADD		R6, R6, #0
            STR		R0, R6, #0		; Push w
            JSR		Volt

            LDR		R0, R6, #0		; Load return value
            STR		R0, R5, #0		; w = Volt(w, 10);
            ADD		R6, R6, #3		; Pop return value and arguments
            ...

    Volt:	ADD		R6, R6, #-1		; Allocate spot for return value

            ADD		R6, R6, #-1
            STR		R7, R6, #0		; Push R7
            
            ADD		R6, R6, #-1
            STR		R5, R6, #0		; Push R5, the frame pointer
            
            ADD		R5, R6, #-1
            ADD		R6, R6, #-2		; Allcate memory for Volt's local variables
            
            ...
            
            LDR		R0, R5, #0		; Load k
            STR		R0, R5, #3		; Write it in return value slot
            
            ADD		R6, R5, #1		; Pop local variables
            
            LDR		R5, R6, #0		; Pop R5, the frame pointer
            ADD		R6, R6, #1
            
            LDR		R7, R6, #0		; Pop R7
            ADD		R6, R6, #1
            RET
    ```

    <div style="text-align: center;">
        <figure>
            <img src="../imgs/78.png" width="80%" style="margin: 0 auto;">
            <caption>run-time stack after Volt pushed onto the stack</caption>
        </figure>
    </div>


## Chapter 16 Pointers and Arrays

**row major**: with C/C++, consecutive elements of each column are in adjacent memory locations.
The array name `number` is equivalent to `&number[0]`.

### Pointer Operators

**Address Operator** is called ampersand`&`.

**Indirection / Dereference Operator** is called asterisk `*`.

## Chapter 18 I/O in C

### C Standard Library

The behavior of standard library functions is precisely defined by the ANSI C standard.

A library header file does not contain the source code for library functions.

##### Static Linking

Each library function called within a program is linked in when the executable image is formed.

The object files containing the library functions are stored somewhere on the system and are accessed by the linker.

#### Dynamic Linking

With certain types of libraries (dynamically linked libraries, or DLLs), the machine code for a library isn't directly intergated into the executable image but is 「linked」 on demand while the program executes.

### I/O Streams

Conceptually, all character-based input and output is performed in *streams*.

The stream abstraction allows us to further decouple the producer from the consumer, which is helpful because the two are usually operating at different rates.


!!! example

    The sequence of ASCII characters typed by the user. As each character si typed, it's added to the end of the stream. Whenever a program reads keyboard input, it reads from the beginning of the stream.

#### Buffered I/O

The program seems to make no progress at all until the Enter/Return key is pressed.

On most I/O services, I/O streams are buffered. Every key typed is captured by the lower levels of the system software and kept in a *buffer*, which is a small array or queue, until it's released into the stream.

Note that output stream is also buffered. We can execute the following routine to check it.

```c
#include <stdio.h>
#include <unistd.h>

int main() {
	putchar('a');
	sleep(5);
	putchar('b');
	putchar('\n');
	return 0;
}
```

### Formatted I/O

`scanf` and `printf`

The first parameter is the *format string*.
The *conversion specifications* indicate how to print out any of the parameters that follow the format string in the function call.

- If the character is a `\`, then the next character indicates the particular special character.
- If the character is a `%`, indicating a conversion specification, then the next charachater indicates how the next pending parameter should be interpreted.

`printf("%d\n")` will display a garbage value in decimal.

##### Variable Argument Lists

Recall the calling convention pushes items onto the run-time stack *from right to left*.

Once the parameter is detected as `char *`, the complier knows it reaches the end of the arguments.

##### Machanism of `scanf`

**white space** is defined as spaces, tabs, new lines, carriage returns, vertical tabs, and form feeds.

The format string represents the format of the input stream.

For example, `%d` indicates that the next sequence of non-white space characters is a sequence of digits in ASCII representing an integer in decimal notation.

```c
#include <stdio.h>

int a, b;
char ch1, ch2;

int main() {
    printf("input prompt> ");
    scanf("%d/%d\n", &a, &b);
    ch1 = getchar();
    ch2 = getchar();
    printf("output prompt> ");
    printf("%d %d%c%c\n", a, b, ch1, ch2);
    return 0;
}
```

```shell
gcc test.c -o test && ./test
input prompt> 1 2
output prompt> 1 0 2
```


## Chapter 19 Dynamic Data Structures in C

### Dynamic Memory Allocation

Recall, memory objects in C programs are allocated to one of three spots in memory : the run-time stack, the global data section, or the heap.

- Variables declared local to funcions are allocated during execution on to the run-time stack.

- Global variables are allocated to the global data section and are accessible from all parts of a program.

- Dynamiccaly allocated data objects are allocated on to the heap. Their allocation and deallocation are determined completely by the logic of the code.


!!! plane ""

    **memory allocator** `malloc`

    **memory deallcator** `free`

`malloc` needs to return a *generic pointer* of type `void *`.

Dynamically sized arrays are allocated on the heap, which means that they can be accessed through out the code and not just within a single function, which is the case with stack-allocated variable-sized arrays.

### Linked Lists

A linked list is a data structure that is similar to an array in that both can be used for data that is a sequential list of elements.

A linked list is a collection of elements, or *nodes*. Each node contains a pointer to the next node and thus the nodes need not be adjacent in memory.

<div style="text-align: center;">
    <figure>
        <img src="../imgs/79.png" width="80%" style="margin: 0 auto;">
        <caption>two representation for a linked list</caption>
    </figure>
</div>

#### Adding a Node

- Empty List
- Add at Head
- Add to Middle
- Add at Tail
- B Exists

> R2 is the node to insert. R1 is the current pointer, R0 is the previous pointer.

```asm
; initiate
			LD		R2, NEW_ITEM
			LD		R1, LIST_HEAD
			AND		R0, R0, #0		; R0 = NULL

; insert
			ST		R2, LIST_HEAD
```

```asm
; initiate
			LD		R2, NEW_ITEM
			LD		R1, LIST_HEAD
			AND		R0, R0, #0		; R0 = NULL

; compare, to sort by NAMEs
LOOP		...
			BRp		INSERT
			BRn		MOVE_PTR
			BRz		LOOP

; move pointer
MOVE_PTR	ADD		R0, R1, #0
			LDR		R1, R1, #0

; insert
INSERT		STR		R2, R0, #0
			STR		R1, R2, #0
```
#### Delete a Node