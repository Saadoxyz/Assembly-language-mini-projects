.MODEL SMALL
.STACK 100H

.DATA
    val db 5
         
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    MOV DL,val 
    ADD DL,'0'   
    
    MOV AH,02H
    INT 21H 
    
    INC DL   
    
    MOV AH,02H
    INT 21H 
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
END MAIN