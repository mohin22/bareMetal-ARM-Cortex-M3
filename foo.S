.section .vectors
vector_table:
    .word 0xABC0
    .word reset_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
   LDR r0, =48         @ First number (48)
    LDR r1, =18         @ Second number (18)
    BL gcd              @ Call the GCD function
    B .                 @ Infinite loop to halt after result

gcd:
    @ GCD using Euclidean algorithm
loop:
    CMP r1, #0          @ Compare r1 with 0
    BEQ end_gcd         @ If r1 == 0, we have our result in r0
    UDIV r2, r0, r1     @ Divide r0 by r1 (r2 = r0 / r1)
    MLS r1, r2, r1, r0  @ r1 = r0 - (r2 * r1), calculating modulus manually
    MOV r0, r1          @ Move the result into r0
    B loop              @ Repeat until r1 == 0

end_gcd:
    BX lr               @ Return to caller
