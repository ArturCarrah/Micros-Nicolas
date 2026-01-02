.global _start
_start:

	mov r1, #370 // Número a ser checado
	
	mov r2, #1 // num de dígitos
	mov r3, #10 // base
	mov r10, #10 //Constante

CONTA_DIGITOS:
	cmp r3, r1
	bgt RETURN
	
	add r2, r2, #1
	mul r3, r3, r10
	b CONTA_DIGITOS

RETURN:


	mov r3, #0 // Valor da soma
	mov r4, r1 
	mov r5, r2
	sub r5, r5, #1 // Expoente
	
WHILE:
	cmp r5, #0
	blt FIM
	
	mov r6, #1 // Base
	mov r7, r5
	WHILE_POT10: // r6 = 10^r7
		cmp r7, #0 
		beq SAIDA
		
		mul r6, r6, r10
		sub r7, r7, #1
		b WHILE_POT10
		
	SAIDA:
	
	mov r7, #9 // r4 - 9000 -> r4 - 8000 -> r4 - 7000 -> ...
	WHILE_DIG:
		mul r8, r6, r7
		cmp r4, r8 // Ex: 6000 >= 5593 >= 5000, então o dígito é 5 (r7)
		subge r4, r4, r8
		bge DIGITO
	
		sub r7, r7, #1
		b WHILE_DIG
		
	DIGITO:
		
		mov r6, r2
		mov r8, r7
	WHILE_EXP: //r7^r2
		cmp r6, #1
		beq SOMA
		
		mul r8, r8, r7
		sub r6, r6, #1
		b WHILE_EXP
	
	SOMA:
		add r3, r3, r8
		sub r5, r5, #1
		b WHILE

FIM:
	mov r0, #0
	cmp r3, r1
	addeq r0, r0, #1
