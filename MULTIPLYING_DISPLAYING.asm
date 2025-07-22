.MODEL SMALL
.STACK 100H

.DATA

.CODE
MAIN PROC  
    
    MOV AL,02
    MOV BL,03
    MUL BL
    MOV DL,AL
    ADD DL,'0'
    
    MOV AH,02H
    INT 21H
     
    MOV AH,4CH
    INT 21H
         
MAIN ENDP
END MAIN