.MODEL SMALL
.STACK 100H
.DATA
TB1 DB "S1= $"
TB2 DB 10,13, "S2= $"
TB3 DB 10,13, "Chuoi Fibonacci la: $"
X DW ?
Y DW ?
A DW 0
B DW 1
.CODE
 MAIN PROC
 MOV AX, @DATA
 MOV DS, AX
 MOV AH, 9
 LEA DX, TB1
 INT 21H
 CALL NHAPSO
 MOV CX, X
 MOV AX, @DATA
 MOV DS, AX
 MOV AH, 9
 LEA DX, TB2
 INT 21H
 CALL NHAPSO
 ADD X, CX
 SUB X, 2H
 
 MOV AX, @DATA
 MOV DS, AX
 MOV AH, 9
 LEA DX, TB3
 INT 21H
 MOV DL,13
 MOV AH,2
 INT 21H
 MOV DL,10
 MOV AH,2
 INT 21H
 MOV AH, 2H
 MOV DL, 30H
 INT 21H
 MOV DL,13
 MOV AH,2
 INT 21H
 MOV DL,10
 MOV AH,2
 INT 21H
 MOV AH, 2H
 MOV DL, 31H
 INT 21H
 
 CALL FIBO

 MOV AH, 4CH
 INT 21H
 MAIN ENDP 
 
 NHAPSO PROC
 MOV X,0
 MOV Y,0
 MOV BX,10
 NHAP:
 MOV AH,1
 INT 21H
 CMP AL,13
 JE THOAT
 SUB AL,30H
 XOR AH,AH
 MOV Y,AX
 MOV AX,X
 MUL BX
 ADD AX,Y
 MOV X,AX
 JMP NHAP
 THOAT:
 RET
 NHAPSO ENDP

 HTHI PROC 
 MOV BX,10
 MOV AX,Y
 MOV CX,0
 CHIA:
 MOV DX,0
 DIV BX
 INC CX 
 PUSH DX
 CMP AL,0
 JE HT
 JMP CHIA
 HT:
 POP DX
 ADD DL,30H
 MOV AH,2
 INT 21H
 DEC CX 
 CMP CX,0
 JNE HT
 MOV CX, X
 ADD CX, 1
 RET
 HTHI ENDP

 FIBO PROC
 FB:
 MOV AX, X
 SUB AX, 1
 MOV X, AX
 MOV AX, A
 MOV BX, B
 ADD AX, BX
 MOV Y, AX
 MOV B, AX
 MOV A, BX
 MOV DL,13
 MOV AH,2
 INT 21H
 MOV DL,10
 MOV AH,2
 INT 21H
 CALL HTHI
 LOOP FB
 FIBO ENDP