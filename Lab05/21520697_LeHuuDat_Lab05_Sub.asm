.MODEL SMALL
.STACK 100H
.DATA
TB1 DB "S1= $"
TB2 DB 10,13, "S2= $"
TB3 DB 10,13, "S1-S2= $"    
.CODE
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    MOV AH, 9
    LEA DX, TB1
    INT 21H
    ;NHAP 16 BIT CAO S1
    MOV CX, 16
    MOV BX, 0
NHAP:
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV AH, 0
    PUSH AX
    MOV AX, 2
    MUL BX
    MOV BX, AX
    POP AX
    ADD BX, AX
    LOOP NHAP
    PUSH BX
    MOV BX, 0
    MOV CX, 16
    JMP NHAP1
NHAP1:
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV AH, 0
    PUSH AX
    MOV AX, 2
    MUL BX
    MOV BX, AX
    POP AX
    ADD BX, AX
    LOOP NHAP1
    PUSH BX
    JMP NHAP2
    ;NHAP 16 BIT CAO S2
NHAP2:
    MOV AX, @DATA
    MOV DS, AX
    MOV AH, 9
    LEA DX, TB2
    INT 21H
    MOV CX, 16
    MOV BX, 0
NHAP2_1:
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV AH, 0
    PUSH AX
    MOV AX, 2
    MUL BX
    MOV BX, AX
    POP AX
    ADD BX, AX
    LOOP NHAP2_1
    PUSH BX
    MOV BX, 0
    MOV CX, 16
    JMP NHAP3    
NHAP3:
    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV AH, 0
    PUSH AX
    MOV AX, 2
    MUL BX
    MOV BX, AX
    POP AX
    ADD BX, AX
    LOOP NHAP3
    PUSH BX       
TRU:
    MOV AX, @DATA
    MOV DS, AX
    MOV AH, 9
    LEA DX, TB3
    INT 21H
    POP DX
    POP CX
    POP BX
    POP AX    
    SUB BX, DX
    JC CARRY
    JMP NOT_CARRY
CARRY:
    SUB AX, 1
    JC CARRY2
    MOV DL, 0
    JMP NOT_CARRY
CARRY2:
    MOV DL, 1
NOT_CARRY:
    SUB AX, CX
    JC CARRY3
    MOV DL, 0
    JMP EXIT 
CARRY3:
    MOV DL, 1
EXIT:
    PUSH BX
    PUSH AX
    MOV BL, DL
    MOV AH, 2
    MOV DL, '0'
    TEST BL, 1
    JZ ZERO
    MOV DL, '1'
ZERO:
    INT 21H
    POP BX
    MOV CX, 16
PRINT:
    MOV AH, 2
    MOV DL, '0'
    TEST BX, 8000H
    JZ ZERO2
    MOV DL, '1'
ZERO2:
    INT 21H
    SHL BX, 1
    LOOP PRINT
    POP BX
    MOV CX, 16
PRINT2:
    MOV AH, 2
    MOV DL, '0'
    TEST BX, 8000H
    JZ ZERO3
    MOV DL, '1'
ZERO3:
    INT 21H
    SHL BX, 1
    LOOP PRINT2      
MAIN ENDP 
ENDP MAIN