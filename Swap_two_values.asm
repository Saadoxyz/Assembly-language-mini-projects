.MODEL SMALL
.STACK 100H 

.DATA

.CODE
    MAIN PROC  
        MOV AX,5
        MOV DX,9
        XCHG AX,DX
               
        MOV AH,4CH      
        INT 21H
    MAIN ENDP
    
END MAIN