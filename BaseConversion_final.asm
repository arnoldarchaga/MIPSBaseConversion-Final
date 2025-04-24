        .data
promptN:     .asciiz "Enter number of digits (n): "
promptB:     .asciiz "Enter base b (2..10): "
promptDigit: .asciiz "Enter digit Xi: "
errorDigit:  .asciiz "ERROR: Digit not valid in this base.\n"
resultMsg:   .asciiz "Decimal result = "
newline:     .asciiz "\n"

        .text
        .globl main

main:
    # Read n
    la   $a0, promptN
    li   $v0, 4
    syscall
    li   $v0, 5
    syscall
    move $t0, $v0      # n

    # Read base b
    la   $a0, promptB
    li   $v0, 4
    syscall
    li   $v0, 5
    syscall
    move $t1, $v0      # b

    # Initialize
    li   $t2, 0        # decimalResult
    li   $s0, 0        # i = 0

loop_read_digit:
    bge  $s0, $t0, done       # if i ≥ n, finish

    # Read Xi
    la   $a0, promptDigit
    li   $v0, 4
    syscall
    li   $v0, 5
    syscall
    move $t3, $v0            # Xi

    # Validate Xi < b
    blt  $t3, $t1, valid_digit
    la   $a0, errorDigit
    li   $v0, 4
    syscall
    j    loop_read_digit     # retry same i

valid_digit:
    # Compute power = b^i
    li   $t4, 1
    li   $t5, 0
power_loop:
    bge  $t5, $s0, power_done
    mul  $t4, $t4, $t1
    addi $t5, $t5, 1
    j    power_loop
power_done:

    # Add partial
    mul  $t6, $t3, $t4
    add  $t2, $t2, $t6

    addi $s0, $s0, 1        # i++
    j    loop_read_digit

done:
    # Print result
    la   $a0, resultMsg
    li   $v0, 4
    syscall

    move $a0, $t2
    li   $v0, 1
    syscall

    la   $a0, newline
    li   $v0, 4
    syscall

    li   $v0, 10            # exit
    syscall
