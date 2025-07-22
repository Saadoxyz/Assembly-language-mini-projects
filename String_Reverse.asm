.MODEL SMALL
.STACK 100H

.DATA

    buffer DB 100 DUP('$')
    reversed DB 100 DUP('$')
    newline DB 0DH, 0AH, '$';

.CODE
    MAIN PROC  
        
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 0AH
    LEA DX, buffer
    INT 21H
    
    MOV SI, OFFSET buffer + 1
    MOV CL, [SI]
    MOV CH, 0
    INC SI
    
    MOV DI, OFFSET reversed
    ADD DI, CX
    DEC DI
    
    REVERSE_LOOP:
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    DEC DI
    LOOP REVERSE_LOOP
    
    MOV AH, 09H
    LEA DX, newline
    INT 21H
    
    MOV AH, 09H
    LEA DX, reversed
    INT 21H
    
    MOV AH, 4CH
    INT 21H

    MAIN ENDP
END MAIN