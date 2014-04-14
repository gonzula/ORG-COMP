    .text
    .align 2
    .globl copiaVetor

copiaVetor:
    #a0 = original
    #a1 = inicio
    #a3 = fim
    # retorna:
    #$v0 = endereco da copia

    addi $sp, $sp, -8 #
    sw $a0, 0($sp)    # salvando contexto
    sw $a1, 4($sp)    #


    li $v0, 9         #
    sub $a0, $a3, $a1 #
    li $t1, 4         # aloca o vetor que recebera a copia
    mul $a0, $a0, $t1 #
    syscall           #

    lw $a0, 0($sp) #$a0 = original
    move $t1, $v0  #$v0 = vazio para copia

    li $t0, 4
    mul $t0, $a1, $t0
    add $a0, $a0, $t0  # &vetor[inicio]
    sub $a1, $a3, $a1  # tamanho = fim - inicio

loop:
    blez $a1, desempilha
    lw $t0, 0($a0)
    sw $t0, 0($t1)

    addi $a0, $a0, 4
    addi $t1, $t1, 4
    addi $a1, $a1, -1

    j loop


desempilha:
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    addi $sp, $sp, 8

    jr $ra

