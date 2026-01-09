.global _start
_start:
	
    mov r2, #0x1000
    mov r3, #6
    mov r4, #28
    mov r5, #496
    mov r6, #8128
    mov r7, #32764
    lsl r7, r7, #10
	
    str r3, [r2, #0]
    str r4, [r2, #4]
    str r5, [r2, #8]
    str r6, [r2, #12]
    str r7, [r2, #16]
	
    mov r1, #32764 // Número a ser checado, comente a próxima linha pra todos os números menos o último
    lsl r1, r1, #10 // Usar só pra checar 33550336, que deve ser escrito como 32764 na linha de cima
                    // 32764*2^10 = 33550336
    mov r3, #0
WHILE:
    cmp r3, #20
    moveq r0, #0
    beq FIM
	
    ldr r4, [r2, r3]
    cmp r4, r1
    moveq r0, #1
    beq FIM
	
    add r3, r3, #4
    b WHILE
	
FIM:
