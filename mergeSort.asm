    .data
    .align 2
VETOR:       .word   36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

    .text
    .align 2
    .globl main

main:

    la $a0, VETOR ## $a0 = &vetor[0]
    li $a1, 10     ## $a1 = inicio
    li $a3, 30    ## $a3 = tamanho

    move $t0, $a0

    li $v0, 9         #
    sub $a0, $a3, $a1 # aloca um vetor auxiliar
    li $t1, 4         # usado no merge
    mul $a0, $a0, $t1 #
    syscall           #

    move $s0, $v0     # $s0, variavel
    move $a0, $t0

    jal mergeSort



    jal printVetor

    li $v0, 10   #
    syscall      # exit


mergeSort:
    addi $sp, $sp, 8
    sw $a0, 4($sp)
    sw $ra, 0($sp)


    move $t0, $a0

    #li $v0, 9         #
    #sub $a0, $a3, $a1 # aloca o vetor que recebera a oredenacao
    #li $t1, 4         #
    #mul $a0, $a0, $t1 #
    #syscall           #

    move $a0, $t0



    jal mergeSortRecursao

    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, -8

mergeSortRecursao:
    addi $sp, $sp, -28
    sw $s1, 24($sp)
    sw $s2, 20($sp)
    sw $a0, 16($sp) #vetor
    sw $a1, 12($sp) #inicio
    sw $a2, 8($sp)  #meio
    sw $a3, 4($sp)  #fim
    sw $ra, 0($sp)

    sub $t0, $a3, $a1
    addi $s1, $t0, -5
    bltzal $s1, ajustaBubble # se tam < 5 faz bubbleSort
    bltz $s1, desempilha

    move $s1, $a3    # manter valor do fim

    add $t1, $a1, $a3
    li $t0, 2
    div $a2, $t1, $t0  # $a2 = $a3 / 2

    move $a3, $a2
    #                  #a0    #a1    #a3
    jal mergeSortRecursao  # (vetor*, inicio, meio)

    move $a3, $s1   #manter valor do fim

    move $s1, $a1
    move $a1, $a2
    #                  #a0    #a1     #a3
    jal mergeSortRecursao  # (vetor*,meio + 1, fim)
    move $a1, $s1


    la $a0, VETOR

    jal merge

desempilha:
    lw $s1, 24($sp)
    lw $s2, 20($sp)
    lw $a0, 16($sp) #vetor
    lw $a1, 12($sp)  #inicio
    lw $a2, 8($sp)   #meio
    lw $a3, 4($sp)  #fim
    lw $ra, 0($sp)
    addi $sp, $sp, 28
    jr $ra

ajustaBubble:
    addi $sp, $sp, -8
    sw $ra, 0($sp)

    jal bubbleSort

    lw $ra, 0($sp)
    addi $sp, $sp, 8

    jr $ra
