    .text
    .align 2
    .globl mergeSort

mergeSort:
    sub $t0, $a3, $a1   #
    li $t1, 16          #
    bgt $t0, $t1, erroDetectado  # se tamaho > 16 entao exit
    li $t1, 1           #
    blt $t0, $t1, erroDetectado  # se tamanho < 1 entao exit

    addi $sp, $sp, 20
    sw $s0, 16($sp)
    sw $a0, 12($sp)
    sw $a1, 8($sp)
    sw $a3, 4($sp)
    sw $ra, 0($sp)


    jal copiaVetor

    move $a0, $v0
    sub $a3, $a3, $a1 #fim
    li $a1, 0   #inicio

    addi $sp, $sp, -12 #
    sw $a0, 8($sp)     # salva valor de $a0
    sw $a1, 4($sp)     # salva valor de $a1
    sw $a3, 0($sp)     # salva valor de $a3

    li $v0, 9         #  sbrk
    sub $a0, $a3, $a1 # aloca um vetor auxiliar
    li $t1, 4         # usado no merge
    mul $a0, $a0, $t1 #
    syscall           #
    move $s0, $v0     #


    lw $a0, 8($sp)     #volta valor de $a0
    lw $a1, 4($sp)     #volta valor de $a1
    lw $a3, 0($sp)     #volta valor de $a3
    addi $sp, $sp, 12 #

    jal mergeSortRecursao

    move $v0, $a0

    lw $s0, 16($sp)
    lw $a0, 12($sp)
    lw $a1, 8($sp)
    lw $a3, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 20

    jr $ra

erroDetectado:
    li $v0, 0 #
    jr $ra    # retorna 0

mergeSortRecursao:
    addi $sp, $sp, -28
    sw $s1, 24($sp)
    sw $a0, 16($sp) #vetor
    sw $a1, 12($sp) #inicio
    sw $a2, 8($sp)  #meio
    sw $a3, 4($sp)  #fim
    sw $ra, 0($sp)

    sub $t0, $a3, $a1
    addi $s1, $t0, -5
    bltz $s1, chamaBubble # se tam < 5 faz bubbleSort

    move $s1, $a3    # manter valor do fim

    add $t1, $a1, $a3
    li $t0, 2
    div $a2, $t1, $t0  # $a2 = $a3 / 2

    move $a3, $a2
    #                          #$a0    #$a1   #$a3
    jal mergeSortRecursao  # (vetor*, inicio, meio)

    move $a3, $s1   # manter valor do fim

    move $s1, $a1
    move $a1, $a2
    #                          #$a0    #$a1   #$a3
    jal mergeSortRecursao  # (vetor*,meio + 1, fim)
    move $a1, $s1

    jal merge


desempilhaMergeSortRecursao:
    lw $s1, 24($sp)
    lw $a0, 16($sp) #vetor
    lw $a1, 12($sp)  #inicio
    lw $a2, 8($sp)   #meio
    lw $a3, 4($sp)  #fim
    lw $ra, 0($sp)
    addi $sp, $sp, 28
    jr $ra


chamaBubble:
    jal bubbleSort
    j desempilhaMergeSortRecursao

