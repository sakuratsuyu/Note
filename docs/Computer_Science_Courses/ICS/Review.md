# Review

## Day 01 7.11

!!! plane ""

    **Why Boolean type is 8-bit in C / C++ ?**
    
    1 Byte is the minimum element of memory addressing.
    
    8-bit is the most efficient way for memory addressing.

!!! plane ""
    An ISA can have multiple microarchitecture.

!!! plane ""
    
    **Compiler vs. Assembler**
    
    Assemble language is bijective to ISA, but programming language are not.
    
    Compiler transform high level programming language to machine code.
    
    Assemble transform assemble language to machine code.

!!! plane ""

    **Value Representation**
    
    Signed Magnitide	源码
    
    most intuitive, but can not do calculation.
    
    1's Complement		反码
    
    can do calculation, but have +0 and -0, which wastes.
    
    2's Complement		补码
    
    can do calculation, no waste binary number.
    
    -16 is 2's complement is itself

!!! plane ""
    
    **Scope of some reprentations**
    
    Unsigned			$0 \le x \le 2^n - 1$
    
    2's complement		$-2^{n=1} \le x \le 2^{n-1} - 1$

!!! plane ""

    **Overflow**
    
    A trick to judge overflow :
    
    two number adds, if positive gets negative, or vice versa, then it overflows.
    
    A positive number plus a negative number never overflows.

!!! plane ""
    
    **How to move left ?**
    
    $a << 1 = a + a$

!!! plane ""

    **Operation Law of logic variable**

    $$
    \begin{aligned}
        X\ \mathrm{and}\ (0...0)_2 = (0...0)_2 \\
        X\ \mathrm{and}\ (1...1)_2 = X \\
        X\ \mathrm{and}\ Y = Y\ \mathrm{and}\ X \\
        (X\ \mathrm{and}\ Y)\ \mathrm{and}\ Z = X\ \mathrm{and}\ (Y\ \mathrm{and}\ Z)$	$X\ \mathrm{or}\ (0...0)_2 = X \\
        X\ \mathrm{or}\ (1...1)_2 = (1...1)_2 \\
        X\ \mathrm{or}\ Y = Y\ \mathrm{or}\ X \\
        (X\ \mathrm{or}\ Y)\ \mathrm{or}\ Z = X\ \mathrm{or}\ (Y\ \mathrm{or}\ Z)
    \end{aligned}
    $$

    $$
        X\ \mathrm{and}\ (Y\ \mathrm{or}\ Z) = (X\ \mathrm{and}\ Y)\ \mathrm{or}\ (X\ \mathrm{and}\ Z)
    $$

    $$
        X\ \mathrm{xor}\ X = 0
    $$

    xor operation is recursive. 

    Provided that $X\ xor\ Y = Z$, then if two variable is known, the rest one can be determined.

    **A way to exchange X, Y**

    $$
    \begin{aligned}
        X = X\ \mathrm{xor}\ Y \\
        Y = X\ \mathrm{xor}\ Y \\
        X = X\ \mathrm{xor}\ Y
    \end{aligned}
    $$


## Day 02 7.12

!!! plane ""

    取位		X AND M

    打开位		X OR M

    关闭位		X AND (NOT (M))

!!! plane ""

    ### Single Presicion 		32-bit

    **Normalized Form**

    $(127)_{10} = (01111111)_2$ is called _offset_.

    $N = (-1)^S \times 1.Fraction \times 2 ^{exp - 127}$

    $1 \le exp \le 254$

    $exp = 0 / 255$for other forms 

    **Other Precision**

    Double Precision		64-bit

    Half Precision 		16-bit

!!! plane ""

    **Logical Completeness**
    Not more 1 or 0 signal can be considered.





















