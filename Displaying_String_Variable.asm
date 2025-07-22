.MODEL SMALL
.STACK 100H

.DATA   
    myString db "Welcome to Assembly$"

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DX,OFFSET myString
    
    MOV AH,09H
    INT 21H
    
    MOV AH,4CH
    INT 21H

MAIN ENDP
END MAIN