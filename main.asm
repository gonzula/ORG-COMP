#
#   Turma 3
#   Grupo 08
#   7144560 - Augusto Torres dos Santos
#   8632455 - Eduardo Aguiar Pacheco
#   7986991 - Matheus Manganeli de Macedo
#   7563703 - Carlos Eduardo Ayoub Fialho
#
#



    .data

    .align 0
ORDENADO:    .asciiz "    ordenado:"
NAOORDENADO: .asciiz "nao-ordenado:"

    .align 2
VETOR:       .word   36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

    .text
    .align 2
    .globl main
    .globl exit

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
