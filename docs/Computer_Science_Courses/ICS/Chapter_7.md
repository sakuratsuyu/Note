# Chapter 7 | Assembly Language

A small step up from the ISA of a machine is that ISA's assembly language.

**symbolic address** is the symbolic and mnemonic name of opcodes and memory locations

The assembly translation program is called an *assembler* and the translation process is called *assembly*.

## Assembly Language Program

### Instructions

$$
    \text{Label\ \ \ \ Opcode\ \ \ \ Operands\ \ \ \ ;\ Comment}
$$

#### Opcodes and Operands

Opcode and operands are **mandatory.**

A literal value must contain a symbol identifying the representation base of the number.

`#`for decimal, `x`for hexadecimal, `b`for binary.

#### Labels

Labels are symbolic names which are used to identify memory locations that are referred to explicity in the program.

In LC-3, a label consists of from 1 to 20 alphanumeric characters, starting with a letter of the alphabet.

**reserved words**	the not-allwoed character strings

TWO conditions for explicity referring to a memory location, where we use LABEL :

- The location is the target of a **branch** instruction
- The location contains a value that is **loaded** or **stored**

#### Comments

Comments are messages intended only human consumption.

It's important to make comments that provide **additional insight** and do not just restate the obvious.

### Pseudo-Ops / Assembler Directives

> like C/C++ that has `#pragma`**.**

Pesudo-Op is a message from the assembly language programmer to the assembler to help the assemble in the assembly process. 

Once the assemble handles the message, the pseudo-op is discarded.

!!! plane ""

    **.ORIG**

    Where in the memory to place the LC-3 program.

    **.FILL**
    To set aside the next location in the program and initialize it with the value of the operand.

    **.BLKW**
    
    stand for a **BLocK of Words**.

    To set aside some number of sequential memory locations in the program and the content of memory locations will be clear to 0.

    **.STRINGZ**
    
    To initialize a sequence of N + 1 memory locations.

    The argument is a sequence of N characters inside double quotation marks.

    The last word containing $\text{x0000}$ provides a convenient sentinel for processing the string of ASCII codes. Thus N + 1.

    **.END**
    To indicate that it has reached the end of the program and need not even look at anything after it.

## Assembly Process

#### The First Pass : Creating the Symbol Table

It identify the actual binary addresses corresponding to the symbolic names (or labels). This set of correspondences is the *symbol table*.

!!! definition

    **location counter, LC**
    
    A counter to keep track of the location assigned to each instruction. It's initialized to the address specified in .ORIG.

The assembler examines each instruction in sequence and increments the LC once for each assembly language instrurction. And it constructs a symbol table like the following one :

<div style="text-align: center;">
    <figure>
        <img src="../imgs/56.png" width="60%" style="margin: 0 auto;">
        <caption>a symbol table</caption>
    </figure>
</div>

#### The Second Pass : Generating the Machine Language Program
It translates the individual assembly language instructions into their corresponding machine language instructions with the help of the symbol table.

## Other Concepts

#### The Executable Image

When a computer begins execution of a program, the entity being executed is called an *executable image*.

The executable image is created from modules. Each modules translated separately into an object file. Each object file consists of instructions in the ISA of the computer being used, along with the associated data.

The final step is to combine (i.e. *link*) all the object modules together into one executable image.

#### More than One Object File

##### The pseudo-op	.EXTERNAL

It tells the assembler to create a symbol table entry for the label of .EXTERNAL and instead of assigning it an address, it would mark the symbol as belonging to another module.

At link time, all the modules are combined.

The .EXTERNAL pseudo-ops allows references by one module to symbolic locations in another module. The proper translations are resolved by the linker.