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
    # Prompt for n
    la   $a0, promptN
    li   $v0, 4
    syscall
    li   $v0, 5
    syscall
    move $t0, $v0      # t0 = n

    # Prompt for base b
    la   $a0, promptB
    li   $v0, 4
    syscall
    li   $v0, 5
    syscall
    move $t1, $v0      # t1 = b

    # TODO: Insert the loop to read each digit and compute decimal result

    j    print_stub    # skip to stub output

print_stub:
    li   $t2, 0        # stub decimalResult = 0

    la   $a0, resultMsg
    li   $v0, 4
    syscall

    move $a0, $t2
    li   $v0, 1
    syscall

    la   $a0, newline
    li   $v0, 4
    syscall

    li   $v0, 10       # exit
    syscall
