.global _start
_start:
	
	mov r1, #0x1000 // Ponteiro do início da string
	mov r2, #34324
	mov r3, #53
	mov r4, #456
	mov r5, #34
	mov r6, #54543
	mov r7, #3
	mov r8, #44353
	mov r9, #7 // Tamanho
	
	
	str r2, [r1, #0]
	str r3, [r1, #4]
	str r4, [r1, #8]
	str r5, [r1, #12]
	str r6, [r1, #16]
	str r7, [r1, #20]
	str r8, [r1, #24]
	
	// Bubble Sort
	
	mov r2, #0 // i = 0
FOR_I:
	cmp r2, #7
	beq RETURN
	
	sub r3, r9, r2 
	sub r3, r3, #1 // j < 6-i
	mov r4, #0 // j = 0
	FOR_J:
		cmp r4, r3
		beq RETURN_J
		
		mov r5, #4
		mul r5, r4, r5 // Endereço de j
		add r6, r5, #4 // Endereço de j+1
		
		ldr r7, [r1,r5]
		ldr r8, [r1, r6]
		
		cmp r7, r8	// Se v[j] > v[j+1], trocar de lugar
		eorgt r7, r7, r8 // xor
		eorgt r8, r7, r8 // r7 <- r8 e r8 <- r7
		eorgt r7, r7, r8
		strgt r7, [r1, r5]
		strgt r8, [r1, r6]
		
		add r4, r4, #1
		b FOR_J
		
	RETURN_J:
		add r2, r2, #1
		b FOR_I
		
RETURN:

	// Busca Binária
	
	mov r2, #54543 // Elemento a ser encontrado
	mov r3, #0 // Esquerda
	mov r4, #6 // Direita
	
WHILE:
	add r5, r3, r4
	lsr r5, #1 // meio = (r3+r4)/2
	mov r6, #4
	mul r6, r5, r6 // Endereço do meio
	
	ldr r6, [r1, r6]
	cmp r2, r6 
	// Se elemento == v[meio], retorne meio
	moveq r0, r5 
	beq FIM
	// Se elemento < v[meio], direita = meio-1
	movlt r4, r5
	sublt r4, r4, #1
	// Se elemento > v[meio], esquerda = meio+1
	movgt r3, r5
	addgt r3, r3, #1
	
	// Se não existe elemento, retorne -1
	cmp r3, r4
	movge r0, #0
	subge r0, r0, #1
	bge FIM
	
	b WHILE
	
FIM:	
