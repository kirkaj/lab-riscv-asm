.data
N:
.word 5
M:
.word 3
matrix:
.word 0, -5, 1, 1, 0
.word 2, 2, 2, -20, 0
.word 1, 1, 1, 0, 0
result:
.word 0
minValue:
.word 0

.text

main:
la a2, N
la a3, M
la a4, matrix
la a5, minValue
la a6, result
call process
la a2, M
la a3, result
call print
call exit

print:
addi a0, x0, 1
lw a1, 0(a6)
ecall
ret

exit:
addi a0, x0, 10
ecall

process:
lw t1, 0(a2) 
lw t2, 0(a3) 
addi t4, x0, 0

init:
addi t5, x0, 0
addi t3, x0, 0
cycle:
lw t6, 0(a4)
addi a4, a4, 4
add t5, t5, t6 
addi t3, t3, 1
blt t3, t1, cycle
beqz t4, ifBody
lw t0, 0(a5)
bge t5,t0,cycleCon
ifBody:
sw t5, 0(a5)
sw t4, 0(a6)
cycleCon:
addi t4, t4, 1
blt t4, t2, init
ret


