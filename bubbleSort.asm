    .text
    .align 2
    .globl bubbleSort

bubbleSort:
    # $a0 = endereco
    # $a1 = inicio
    # $a3 = fim

    # $t2 = aux
    # $t3 = i
    # $t4 = j

    addi $sp, $sp, -8 #
    sw $a0, 0($sp)    # salvando contexto
    sw $a1, 4($sp)    #

    li $t0, 4
    mul $t0, $a1, $t0
    add $a0, $a0, $t0  # &vetor[inicio]
    sub $a1, $a3, $a1  # tamanho = fim - inicio

    blez $a1, desempilha  # se vetor vazio...

    move $t5, $a0

    li $t3, 0
loopExterno:
    bge $t3, $a1, desempilha

    li $t4, 1       # j = 1
    move $a0, $t5   # volta o ponteiro para o inicio do vetor
    j loopInterno



loopInterno:
    bge $t4, $a1, fimLoopExterno
    lw $t0, 0($a0)  # vetor[j-1]
    lw $t1, 4($a0)  # vetor[j]

    addi $a0, $a0, 4  #
    addi $t4, $t4, 1  # j++
    ble $t0, $t1, loopInterno  # vetor[j-1] <= vetor[j], nao troca
                               # else, troca

    sw $t0, 0($a0)   #
    sw $t1, -4($a0)  #swap

    j loopInterno

fimLoopExterno:
    addi $t3, $t3, 1
    j loopExterno


desempilha:
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    addi $sp, $sp, 8

    jr $ra
