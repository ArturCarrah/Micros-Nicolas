.global _start
_start:
	
    mov r0, #0
	mov r1, #0b0100100111011010
	lsl r1, r1, #16
    add r1, r1, #0b1111111100 // x1 tem 16 1's

    mov r2, r1 // y = num
    mov r3, #0 // i = 0

WHILE:
	cmp r2, #0 // retorna quando x3 tiver sido completamente shiftado
    beq RETURN 
    
    and r4, r2, #1
    cmp r4, #1
    addeq r3, r3, #1
    
    lsr r2, r2, #1
    b WHILE
    

RETURN:
	mov r0, r3 // x0 = i