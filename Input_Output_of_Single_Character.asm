.MODEL SMALL
.STACK 100H

.DATA        

.CODE
MAIN PROC   
    
    MOV AX,@DATA
    MOV DS,AX 
    
             
    MOV AH,01H
    INT 21H
             
    MOV AH,02H
    MOV DL,AL
    INT 21H     
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
END MAIN