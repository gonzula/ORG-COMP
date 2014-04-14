    .data

    .align 0
ORDENADO:    .asciiz "    ordenado:"
NAOORDENADO: .asciiz "nao-ordenado:"

    .align 2
VETOR:       .word   36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

    .text
    .align 2
    .globl main

main:

    la $a0, VETOR ## $a0 = &vetor[0]
    li $a1, 0     ## $a1 = inicio
    li $a3, 16    ## $a3 = final + 1

    jal mergeSort #retorna em $v0 o vetor ordenado
    beqz $v0, exit  #se deu erro ($v0 == 0) exit

    addi $sp, $sp, -16
    sw $v0, 12($sp)  #salva o $v0
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    sw $a3, 0($sp)

    li $v0, 4
    la $a0, ORDENADO
    syscall

    lw $a0, 12($sp)  #volta valor de $v0 em $a0
    lw $a1, 4($sp)
    lw $a3, 0($sp)


    sub $a3, $a3, $a1  #fim
    li $a1, 0          #inicio
    jal printVetor

    li $v0, 4
    la $a0, NAOORDENADO
    syscall

    lw $a0, 8($sp)
    lw $a1, 4($sp)
    lw $a3, 0($sp)
    addi $sp, $sp, 16
    jal printVetor #recebe em $a0 o vetor original


exit:
    li $v0, 10   #
    syscall      # exit


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

