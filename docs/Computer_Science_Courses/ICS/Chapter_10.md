# Chapter 10 | Calculator

### Data Type Conversion

- Binary to ASCII
- ASCII to Binary

### Arithmetic Using a Stack

Postfix Expression

## The Calculator

It allows a user to enter positive integers consisting of not more than 3 decimal digits, perform basic arithmetic (addition, subtraction and multiplication) on these integers, and display the decimal result

<div style="text-align: center;">
    <figure>
        <img src="../imgs/74.png" width="80%" style="margin: 0 auto;">
        <caption>the overview of calculator</caption>
    </figure>
</div>

```asm
.ORIG   x3000

;   Main Routine                
                LEA     R6, STACK_BASE
                ADD     R6, R6, #1
                
NEW_COMMAND     LEA     R0, PROMPT_MSG
                PUTS
                GETC
                OUT
                
; Check the command

; X for exit
TEST_X          LD      R1, NEG_X
                ADD     R1, R1, R0
                BRnp    TEST_C
                HALT
; C for clearing the stack
TEST_C          LD      R1, NEG_C
                ADD     R1, R1, R0
                BRnp    TEST_ADD
                JSR     OP_CLEAR
                BRnzp   NEW_COMMAND
; + for addition
TEST_ADD        LD      R1, NEG_PLUS
                ADD     R1, R1, R0
                BRnp    TEST_MINUS
                JSR     OP_ADD
                BRnzp   NEW_COMMAND
; - for subtraction
TEST_MINUS      LD      R1, NEG_MINUS
                ADD     R1, R1, R0
                Brnp    TEST_MUL
                JSR     OP_MINUS
                BRnzp   NEW_COMMAND
; * for multiplication
TEST_MUL        LD      R1, NEG_MUL
                ADD     R1, R1, R0
                BRnp    TEST_D
                JSR     OP_MUL
                BRnzp   NEW_COMMAND
; D for Display the value at the top of the stack
TEST_D          LD      R1, NEG_D
                ADD     R1, R1, R0
                BRnp    ENTER_NUMBER
                JSR     OP_DISPLAY
                BRnzp   NEW_COMMAND
; Input a number, LF for end
ENTER_NUMBER    JSR     PUSH_VALUE
                BRnzp   NEW_COMMAND

PROMPT_MSG      .FILL   x000A
                .STRINGZ    "Enter a command: "
NEG_X           .FILL   xFFA8
NEG_C           .FILL   xFFBD
NEG_PLUS        .FILL   xFFD5
NEG_MINUS       .FILL   xFFD3
NEG_MUL         .FILL   xFFD6
NEG_D           .FILL   xFFBC

; Globals
STACK_MAX       .BLKW   #9
STACK_BASE      .BLKW   #1
ASCIIBUFF       .BLKW   #4
                .FILL   x0000                           ; ASCIIBUFF sentinel



; Stack Operations

; Push the value in R0 on the stack
; R5 is used to indicate success (R5 = 0) or failure (R5 = 1)
PUSH            ST      R1, PUSH_SAVE1

                LD      R1, PUSH_STACK_MAX
                NOT     R1, R1
                ADD     R1, R1, #1
                ADD     R1, R1, R6
                BRz     OVERFLOW

                ADD     R6, R6, #-1
                STR     R0, R6, #0
                AND     R5, R5, #0
                
                LD      R1, PUSH_SAVE1

                RET

OVERFLOW        LEA     R0, OVERFLOW_MSG
                PUTS
                AND     R5, R5, #0
                ADD     R5, R5, #1

                LD      R1, PUSH_SAVE1

                RET

PUSH_SAVE1      .BLKW   #1
OVERFLOW_MSG    .FILL   x000A
                .STRINGZ    "Error: Stack is Full."
PUSH_STACK_MAX  .FILL   STACK_MAX


; Pop a value from the stack into R0
; R5 is used to indicate success (R5 = 0) or failure (R5 = 1)
POP             LD      R0, POP_STACK_BASE
                NOT     R0, R0
                ADD     R0, R0, R6
                BRz     UNDERFLOW

                LDR     R0, R6, #0
                ADD     R6, R6, #1
                AND     R5, R5, #0

                RET

UNDERFLOW       LEA     R0, UNDERFLOW_MSG
                PUTS
                
                AND     R5, R5, #0
                ADD     R5, R5, #1

                RET

UNDERFLOW_MSG   .FILL   x000A
                .STRINGZ    "Error: Too Few Values on the Stack."
POP_STACK_BASE  .FILL   STACK_BASE


; Clear the stack by resetting the stack pointer R6
OP_CLEAR        LD      R6, OP_CLEAR_STACK_BASE
                ADD     R6, R6, #1

                RET

OP_CLEAR_STACK_BASE     .FILL   STACK_BASE


; Display the value on the screen
OP_DISPLAY      ST      R0, OP_DISPLAY_SAVE0
                ST      R5, OP_DISPLAY_SAVE5
                ST      R7, OP_DISPLAY_SAVE7

                JSR     POP
                ADD     R5, R5, #0
                BRp     OP_DISPAY_DONE

                JSR     BINARY_TO_ASCII
                LD      R0, NEWLINE_CHAR
                OUT
                LD      R0, OP_DISPLAY_ASCIIBUFF
                PUTS
                ADD     R6, R6, #-1
OP_DISPAY_DONE  LD      R0, OP_DISPLAY_SAVE0
                LD      R5, OP_DISPLAY_SAVE5
                LD      R7, OP_DISPLAY_SAVE7

                RET

NEWLINE_CHAR             .FILL   x000A
OP_DISPLAY_ASCIIBUFF    .FILL   ASCIIBUFF
OP_DISPLAY_SAVE0        .BLKW   #1
OP_DISPLAY_SAVE5        .BLKW   #1
OP_DISPLAY_SAVE7        .BLKW   #1

; Push the value into stack
; R0 is each input char
; R1 points to the string
PUSH_VALUE      ST      R0, PUSH_VALUE_SAVE0
                ST      R1, PUSH_VALUE_SAVE1
                ST      R2, PUSH_VALUE_SAVE2
                ST      R7, PUSH_VALUE_SAVE7

                LD      R1, PUSH_VALUE_ASCIIBUFF
                LD      R2, MAX_DIGITS

VALUE_LOOP      ADD     R3, R0, x-0A                    ; Test for LF
                BRz     INPUT_DONE
                
                ADD     R2, R2, #0
                BRz     DIGIT_OVERFLOW

                LD      R3, NEG_ASCII_0
                ADD     R3, R0, R3
                BRn     NOT_INTEGER
                LD      R3, NEG_ASCII_9
                ADD     R3, R0, R3
                BRp     NOT_INTEGER

                ADD     R2, R2, #-1
                STR     R0, R1, #0
                ADD     R1, R1, #1
                GETC
                OUT
                BRnzp   VALUE_LOOP

INPUT_DONE      LD      R2, PUSH_VALUE_ASCIIBUFF        ; Test whether no input
                NOT     R2, R2
                ADD     R2, R2, #1
                ADD     R1, R1, R2
                BRz     NO_DIGIT

                JSR     ASCII_TO_BINARY
                JSR     PUSH
                BRnzp   PUSH_VALUE_DONE

NO_DIGIT        LEA     R0, NO_DIGIT_MSG
                PUTS
                BRnzp   PUSH_VALUE_DONE

NOT_INTEGER     GETC
                OUT
                ADD     R3, R0, x-0A
                BRnp    NOT_INTEGER

                LEA     R0, NOT_INTEGER_MSG
                PUTS
                BRnzp   PUSH_VALUE_DONE

DIGIT_OVERFLOW  GETC
                OUT
                ADD     R3, R0, x-0A
                BRnp    DIGIT_OVERFLOW

                LEA     R0, DIGIT_OVERFLOW_MSG
                PUTS
                BRnzp   PUSH_VALUE_DONE

PUSH_VALUE_DONE LD      R0, PUSH_VALUE_SAVE0
                LD      R1, PUSH_VALUE_SAVE1
                LD      R2, PUSH_VALUE_SAVE2
                LD      R7, PUSH_VALUE_SAVE7

                RET

DIGIT_OVERFLOW_MSG      .FILL   x000A
                        .STRINGZ    "Too many digits"
NO_DIGIT_MSG            .FILL   x000A
                        .STRINGZ    "No number entered"
NOT_INTEGER_MSG         .FILL   x000A
                        .STRINGZ    "Not an integer"

MAX_DIGITS              .FILL   x0003
NEG_ASCII_0             .FILL   x-30
NEG_ASCII_9             .FILL   x-39
PUSH_VALUE_ASCIIBUFF    .FILL   ASCIIBUFF

PUSH_VALUE_SAVE0        .BLKW   #1
PUSH_VALUE_SAVE1        .BLKW   #1
PUSH_VALUE_SAVE2        .BLKW   #1
PUSH_VALUE_SAVE7        .BLKW   #1



; Convertion

; ASCII to Binary convertion
; R0 is used to collect the result.
; R1 keeps track of how many digits are left to process
ASCII_TO_BINARY ST      R1, ATOB_SAVE1
                ST      R2, ATOB_SAVE2
                ST      R3, ATOB_SAVE3
                ST      R4, ATOB_SAVE4

                AND     R0, R0, #0
                ADD     R1, R1, #0                  ; Test number of digit
                BRz     ATOB_DONE                   ; No digit, i.e 0

                LD      R2, ATOB_ASCIIBUFF          ; R2 is the pointer
                ADD     R2, R2, R1

                ADD     R2, R2, #-1
                LDR     R4, R2, #0                  ; R4 <- "ones" digit
                AND     R4, R4, x000F               ; Strip off the ASCII template, i.e. R4 <- R4 - x0030
                ADD     R0, R0, R4

                ADD     R1, R1, #-1
                BRz     ATOB_DONE                   ; If it is only one digit

                ADD     R2, R2, #-1
                LDR     R4, R2, #0                  ; R4 <- "tens" digit
                AND     R4, R4, x000F
                LEA     R3, LOOK_UP_10
                ADD     R3, R3, R4
                LDR     R4, R3, #0
                ADD     R0, R0, R4

                ADD     R1, R1, #-1
                BRz     ATOB_DONE                   ; If it is only two digits

                ADD     R2, R2, #-1
                LDR     R4, R2, #0                  ; R4 <- "hundreds" digit
                AND     R4, R4, x000F
                LEA     R3, LOOK_UP_100
                ADD     R3, R3, R4
                LDR     R4, R3, #0
                ADD     R0, R0, R4

ATOB_DONE       LD      R1, ATOB_SAVE1
                LD      R2, ATOB_SAVE2
                LD      R3, ATOB_SAVE3
                LD      R4, ATOB_SAVE4

                RET

ATOB_ASCIIBUFF  .FILL   ASCIIBUFF
ATOB_SAVE1      .BLKW   #1
ATOB_SAVE2      .BLKW   #1
ATOB_SAVE3      .BLKW   #1
ATOB_SAVE4      .BLKW   #1
LOOK_UP_10      .FILL   #0
                .FILL   #10
                .FILL   #20
                .FILL   #30
                .FILL   #40
                .FILL   #50
                .FILL   #60
                .FILL   #70
                .FILL   #80
                .FILL   #90
LOOK_UP_100     .FILL   #0
                .FILL   #100
                .FILL   #200
                .FILL   #300
                .FILL   #400
                .FILL   #500
                .FILL   #600
                .FILL   #700
                .FILL   #800
                .FILL   #900


; Binary to ASCII convertion
; R0 contains the binary value
; R1 keeps track of the output string
BINARY_TO_ASCII ST      R0, BTOA_SAVE0
                ST      R1, BTOA_SAVE1
                ST      R2, BTOA_SAVE2
                ST      R3, BTOA_SAVE3

                LD      R1, BTOA_ASCIIBUFF
                ADD     R0, R0, #0
                BRn     NEG_SIGN

                LD      R2, ASCII_POS                   ; Store the positive sign
                STR     R2, R1, #0
                BRnzp   SKIP

NEG_SIGN        LD      R2, ASCII_NEG                   ; Store the negtive sign
                STR     R2, R1, #0
                NOT     R0, R0
                ADD     R0, R0, #1

; Process the "hundreds" digit
SKIP            LD      R2, ASCII_OFFSET
                LD      R3, NEG_100                     ; Since 100 > 2^5, immediate mode can't be used
LOOP_100        ADD     R0, R0, R3
                BRn     END_100
                ADD     R2, R2, #1
                BRnzp   LOOP_100

END_100         STR     R2, R1, #1
                LD      R3, POS_100
                ADD     R0, R0, R3                      ; R0 <- R0 + 100

; Process the "tens" digit
                LD      R2, ASCII_OFFSET
LOOP_10         ADD     R0, R0, #-10
                BRn     END_10
                ADD     R2, R2, #1
                BRnzp   LOOP_10

END_10          STR     R2, R1, #2
                ADD     R0, R0, #10

; Process the "ones" digit
                LD      R2, ASCII_OFFSET
                ADD     R2, R2, R0
                STR     R2, R1, #3

                LD      R0, BTOA_SAVE0
                LD      R1, BTOA_SAVE1
                LD      R2, BTOA_SAVE2
                LD      R3, BTOA_SAVE3

                RET

ASCII_POS       .FILL   x002B
ASCII_NEG       .FILL   x002D
ASCII_OFFSET    .FILL   x0030
NEG_100         .FILL   #-100
POS_100         .FILL   #100
BTOA_ASCIIBUFF  .FILL   ASCIIBUFF
BTOA_SAVE0      .BLKW   #1
BTOA_SAVE1      .BLKW   #1
BTOA_SAVE2      .BLKW   #1
BTOA_SAVE3      .BLKW   #1


; Check

RANGE_CHECK     LD      R5, NEG_999
                ADD     R5, R0, R5
                BRp     RANGE_OVERFLOW
                LD      R5, POS_999
                ADD     R5, R0, R5
                BRn     RANGE_OVERFLOW
                AND     R5, R5, #0

                RET

RANGE_OVERFLOW        ST      R0, RANGE_CHECK_SAVE0
                LEA     R0, RANGE_EROOR_MSG
                PUTS

                AND     R5, R5, #0
                ADD     R5, R5, #1

                LD      R0, RANGE_CHECK_SAVE0

                RET

NEG_999             .FILL   #-999
POS_999             .FILL   #999
RANGE_EROOR_MSG     .FILL   x000A
                    .STRINGZ    "Error: Number is out of range."
RANGE_CHECK_SAVE0   .BLKW   #1



; Arithmetic Operations

OP_ADD          ST      R0, OP_ADD_SAVE0
                ST      R5, OP_ADD_SAVE5
                ST      R7, OP_ADD_SAVE7

                JSR     POP
                ADD     R5, R5, #0
                BRp     OP_ADD_EXIT
                ADD     R1, R0, #0

                JSR     POP
                ADD     R5, R5, #0
                BRp     OP_ADD_RESTORE1

                ADD     R0, R0, R1                      ; Addition routine

                JSR     RANGE_CHECK
                ADD     R5, R5, #0
                BRp     OP_ADD_RESTORE2

                JSR     PUSH
                BRnzp   OP_ADD_EXIT

OP_ADD_RESTORE2 ADD     R6, R6, #-1
OP_ADD_RESTORE1 ADD     R6, R6, #-1
OP_ADD_EXIT     LD      R0, OP_ADD_SAVE0
                LD      R1, OP_ADD_SAVE1
                LD      R7, OP_ADD_SAVE7

                RET

OP_ADD_SAVE0    .BLKW   #1
OP_ADD_SAVE1    .BLKW   #1
OP_ADD_SAVE5    .BLKW   #1
OP_ADD_SAVE7    .BLKW   #1


OP_MINUS        ST      R0, OP_MINUS_SAVE0
                ST      R5, OP_MINUS_SAVE5
                ST      R7, OP_MINUS_SAVE7

                JSR     POP
                ADD     R5, R5, #0
                BRp     OP_MINUS_EXIT

                ADD     R0, R0, #1
                JSR     PUSH

                JSR     OP_ADD

OP_MINUS_EXIT   LD      R0, OP_MINUS_SAVE0
                LD      R5, OP_MINUS_SAVE5
                LD      R7, OP_MINUS_SAVE7

                RET

OP_MINUS_SAVE0  .BLKW   #1
OP_MINUS_SAVE5  .BLKW   #1
OP_MINUS_SAVE7  .BLKW   #1


OP_MUL          ST      R0, OP_MUL_SAVE0
                ST      R1, OP_MUL_SAVE1
                ST      R2, OP_MUL_SAVE2
                ST      R3, OP_MUL_SAVE3
                ST      R5, OP_MUL_SAVE5
                ST      R7, OP_MUL_SAVE7

                AND     R3, R3, #0                      ; R3 holds sign of multiplier
                JSR     POP
                ADD     R5, R5, #0
                BRp     OP_MUL_EXIT
                ADD     R1, R0, #0

                JSR     POP
                ADD     R5, R5, #0
                BRp     OP_MUL_RESTORE1
                ADD     R2, R0, #0                      ; Moves multiplier to test sign
                BRzp    POS_MULTIPLIER

                ADD     R3, R3, #1
                NOT     R2, R2
                ADD     R2, R2, #1

POS_MULTIPLIER  AND     R0, R0, #0
                ADD     R2, R2, #0
                BRz     PUSH_MULT                       ; If multiplier = 0, then DONE
                
MUL_LOOP        ADD     R0, R0, R1                      ; Multiply routine
                ADD     R2, R2, #-1
                BRp     MUL_LOOP

                JSR     RANGE_CHECK
                ADD     R5, R5, #0
                BRp     OP_MUL_RESTORE2

                ADD     R3, R3, #0                      ; Test for negative multiplier
                BRz     PUSH_MULT
                NOT     R0, R0
                ADD     R0, R0, #1

PUSH_MULT       JSR     PUSH
                BRnzp   OP_MUL_EXIT

OP_MUL_RESTORE2 ADD     R6, R6, #-1
OP_MUL_RESTORE1 ADD     R6, R6, #-1    
OP_MUL_EXIT     LD      R0, OP_MUL_SAVE0
                LD      R1, OP_MUL_SAVE1
                LD      R3, OP_MUL_SAVE3
                LD      R5, OP_MUL_SAVE5
                LD      R7, OP_MUL_SAVE7

                RET
                
OP_MUL_SAVE0   .BLKW   #1
OP_MUL_SAVE1   .BLKW   #1
OP_MUL_SAVE2   .BLKW   #1
OP_MUL_SAVE3   .BLKW   #1
OP_MUL_SAVE5   .BLKW   #1
OP_MUL_SAVE7   .BLKW   #1


.END
```
