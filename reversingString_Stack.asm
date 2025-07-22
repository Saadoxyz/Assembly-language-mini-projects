.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 100 DUP('$')
    NEWLINE DB 10,13,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 0AH
    LEA DX, MSG
    INT 21H
    
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H

    LEA SI, MSG + 2      
    MOV CL, [MSG + 1]    
    MOV CH, 0          
    
PUSH_LOOP:
    MOV AL, [SI]        
    PUSH AX              
    INC SI             
    LOOP PUSH_LOOP
    
    MOV CL, [MSG + 1]    
    MOV CH, 0
    
POP_LOOP:
    POP DX              
    MOV AH, 02H         
    INT 21H
    LOOP POP_LOOP
    
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN