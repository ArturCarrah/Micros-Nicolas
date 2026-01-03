.global _start
_start:
	
	mov r1, #0x1000 // Ponteiro do início da string
	mov r2, #0x61
	mov r3, #0x72
	mov r4, #0x61
	mov r5, #0x72
	mov r6, #0x61
	mov r7, #5 // Tamanho
	
	
	strb r2, [r1, #0]
	strb r3, [r1, #1]
	strb r4, [r1, #2]
	strb r5, [r1, #3]
	strb r6, [r1, #4]
	
	mov r2, #0
	mov r3, #4
	
WHILE:
	cmp r3, r2 // r2 ->     <- r3
	movle r0, #1
	ble RETURN
	
	ldrb r4, [r1, r2]
	ldrb r5, [r1, r3]
	
	cmp r4, r5
	movne r0, #0
	bne RETURN
	
	add r2, r2, #1
	sub r3, r3, #1
	
	b WHILE
	
RETURN:
