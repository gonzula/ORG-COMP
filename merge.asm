    .text
    .align 2
    .globl merge

merge:
    addi $sp, $sp, -32
    sw $s0, 28($sp)
    sw $s1, 24($sp)
    sw $s2, 20($sp)
    sw $a0, 16($sp) #vetor
    sw $a1, 12($sp) #inicio    #0
    sw $a2, 8($sp)  #meio      #2
    sw $a3, 4($sp)  #fim       #5
    sw $ra, 0($sp)

    move $t0, $a1   # i
    move $t1, $a2   # j
    move $t5, $s0   # &aux[0]

    li $t4, 4
    mul $t2, $t0, $t4
    mul $t3, $t1, $t4

    add $t2, $a0, $t2   # & subvet1[i]
    add $t3, $a0, $t3   # & subvet2[j]
loop:
    bge $t0, $a2, terminaDireita  # quando subvet1 termina, completa com o subvet2
    bge $t1, $a3, terminaEsquerda # e vice e versa

    lw $t6, 0($t2)
    lw $t7, 0($t3)

    blt $t6, $t7, trocaEsquerda

# trocaDireita
    sw $t7, 0($t5)
    addi $t5, $t5, 4 # k++
    addi $t1, $t1, 1 # j++
    addi $t3, $t3, 4

    j loop

trocaEsquerda:
    sw $t6, 0($t5)
    addi $t5, $t5, 4 # k++
    addi $t0, $t0, 1 # i++
    addi $t2, $t2, 4

    j loop



terminaEsquerda:
    bge $t0, $a2, fim  # t0 >= a2

    lw $t7, 0($t2)

    sw $t7, 0($t5)
    addi $t5, $t5, 4 # k++
    addi $t0, $t0, 1 # i++
    addi $t2, $t2, 4

    j terminaEsquerda


terminaDireita:
    bge $t1, $a3, fim

    lw $t6, 0($t3)

    sw $t6, 0($t5)  #erro
    addi $t5, $t5, 4 # k++
    addi $t1, $t1, 1 # j++
    addi $t3, $t3, 4


    j terminaDireita

fim:
    move $t0, $a1  # i = inicio
    #move $t1, $a0
    move $t2, $s0

copiaVetor:
    bge $t0, $a3, desempilha   # if (i < fim) then copiaVetor

    li $t4, 4
    mul $t4, $t0, $t4
    add $t1, $a0, $t4

    lw $t3, 0($t2)
    sw $t3, 0($t1)

    addi $t2, $t2, 4

    addi $t0, $t0, 1 #i++

    j copiaVetor

desempilha:


    lw $s0, 28($sp)
    lw $s1, 24($sp)
    lw $s2, 20($sp)
    lw $a0, 16($sp) #vetor
    lw $a1, 12($sp) #inicio
    lw $a2, 8($sp)  #meio
    lw $a3, 4($sp)  #fim
    lw $ra, 0($sp)
    addi $sp, $sp, 32
    jr $ra

