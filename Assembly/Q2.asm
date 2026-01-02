.global _start
_start:

	mov r1, #0x0b1ac
	mov r2, #0x0ff03
	mov r3, #0x01234
	mov r4, #0x0bdca
	mov r5, #0x00ffc
	mov r6, #0x10000 
	
	str r1, [r6, #0]
	str r2, [r6, #4]
	str r3, [r6, #8]
	str r4, [r6, #12]
	str r5, [r6, #16] // Salvando os valores na memória pra busca e apreensão
	
	
	mov r1, #16 // Loop de trás pra frente
	ldr r0, [r6, #16]

WHILE:
	cmp r1, #0
	blt RETURN // r1<0?
	
	ldr r2, [r6, r1]
	cmp r2, r0
	movge r0, r2 //r2>r0?
	
	sub r1, r1, #4
	b WHILE
	
RETURN:
	
