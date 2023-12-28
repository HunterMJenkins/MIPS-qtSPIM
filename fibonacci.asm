#-------------------------------------------------------
#Hunter Jenkins and Dima Bondar
#Fibonacci Sequence
#10/20/2023

#Requirement
#Let F(n) be the nth element (where n >= 0) in the sequence:
#If n < 2, then F(n) = 1
#Otherwise, F(n) = F(n-1) + F(n-2)

#------------------------------------------------------
.data
inputNum: .asciiz "Enter a positive integer: "
message: .asciiz "Fibonacci sequence of: "
message2: .asciiz " = "
result: .word 0

.text
main:
    la $a0, inputNum
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    move $a0, $t1
    move $v0, $t1
    jal fibonacci

    move $t2, $v0

    la $a0, message
    li $v0, 4
    syscall

    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, message2
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall

    # Exit
    li $v0, 10
    syscall

fibonacci:
    bgt $a0, 1, fibonacci_funct
    move $v0, $a0
    jr $ra

fibonacci_funct:
    sub $sp, $sp, 12
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    addi $a0, $a0, -1
    jal fibonacci
    lw $a0, 4($sp)
    sw $v0, 8($sp)

    addi $a0, $a0, -2
    jal fibonacci
    lw $t0, 8($sp)

    add $v0, $t0, $v0

    lw $ra, 0($sp)
    addi $sp, $sp, 12
    jr $ra
