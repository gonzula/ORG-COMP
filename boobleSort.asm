    .text
    .align 2
    .globl bubbleSort

bubbleSort:
    # $a0 = endereco
    # $a1 = tamanho

    # $t2 = aux
    # $t3 = i
    # $t4 = j

    addi $sp, $sp, -12
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    sw $ra, 8($sp)

    beq $a1, $zero, desempilha

    move $t0, $a0


    move $a0, $t0

    li $t3, -1
loopExterno:
    li $t4, 1
    lw $a0, 0($sp)


    addi $t3, $t3, 1
    blt $t3, $a1 loopInterno


    bgt $t3, $a1, desempilha

loopInterno:
    bge $t4, $a1, loopExterno
    lw $t0, 0($a0)  # vetor[j]
    lw $t1, 4($a0)  # vetor[j+1]

    addi $a0, $a0, 4  #
    addi $t4, $t4, 1  #j++
    blt $t0, $t1, loopInterno

    sw $t0, 0($a0)   #
    sw $t1, -4($a0)  #swap

    j loopInterno

desempilha:
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12

    jr $ra
