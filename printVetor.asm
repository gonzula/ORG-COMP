    .text
    .align 2
    .globl printVetor

printVetor:
    addi $sp, $sp, -8
    sw $a0, 4($sp)
    sw $a1, 0($sp)

    li $t0, 4
    mul $t1, $a1, $t0
    add $a0, $a0, $t1
    sub $a1, $a3, $a1

    move $t0, $a0  # endereco
    move $t1, $a1  # tamanho
    addi $t1, $t1, -1

    beqz $a1, quebraLinha
loop:
    li $v0, 1
    lw $a0, 0($t0)
    syscall

    addi $t0, $t0, 4
    addi $t1, $t1, -1

    bltz $t1, quebraLinha


    li $v0, 11
    li $a0, ','
    syscall

    j loop
    #bgtz $t1, loop

quebraLinha:
    li $a0, '\n'
    li $v0, 11
    syscall

    lw $a0, 4($sp)
    lw $a1, 0($sp)
    addi $sp, $sp, 8

    jr $ra
