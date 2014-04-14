    .text
    .align 2
    .globl printVetor

printVetor:
    addi $sp, $sp, -16
    sw $a0, 12($sp)
    sw $a1, 8($sp)
    sw $s0, 4($sp)
    sw $s1, 0($sp)

    li $s0, 4
    mul $s1, $a1, $s0
    add $a0, $a0, $s1
    sub $a1, $a3, $a1

    move $s0, $a0  # endereco
    move $s1, $a1  # tamanho
    addi $s1, $s1, -1

    beqz $a1, quebraLinha
loop:
    li $v0, 1
    lw $a0, 0($s0)
    syscall

    addi $s0, $s0, 4
    addi $s1, $s1, -1

    bltz $s1, quebraLinha


    li $v0, 11
    li $a0, ','
    syscall

    j loop
    #bgtz $s1, loop

quebraLinha:
    li $a0, '\n'
    li $v0, 11
    syscall

    lw $a0, 12($sp)
    lw $a1, 8($sp)
    lw $s0, 4($sp)
    lw $s1, 0($sp)
    addi $sp, $sp, 16

    jr $ra
