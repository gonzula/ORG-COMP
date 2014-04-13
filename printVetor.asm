    .data
    .align 0

STRVETORVAZIO: .asciiz "O vetor esta vazio\n"
STRORDENADO: .asciiz "O vetor ordenado eh:\n"

    .text
    .align 2
    .globl printVetor

printVetor:
    move $t0, $a0  # endereco
    move $t1, $a1  # tamanho

    beq $a1, $zero, vetorVazio
loop:
    li $v0, 1
    lw $a0, 0($t0)
    syscall

    li $v0, 11
    li $a0, ','
    syscall

    addi $t0, $t0, 4
    addi $t1, $t1, -1

    bgtz $t1, loop

    jr $ra

vetorVazio:
    li $v0, 4
    la $a0, STRVETORVAZIO
    syscall

    jr $ra
