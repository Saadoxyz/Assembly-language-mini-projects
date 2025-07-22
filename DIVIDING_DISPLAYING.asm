.MODEL SMALL
.STACK 100H

.DATA

.CODE
MAIN PROC  
    
    MOV AL,08
    MOV BL,02
    DIV BL
    MOV DL,AL
    ADD DL,'0'
    
    MOV AH,02H
    INT 21H
     
    MOV AH,4CH
    INT 21H
         
MAIN ENDP
END MAIN