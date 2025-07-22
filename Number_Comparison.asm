.MODEL SMALL
.STACK 100H

.DATA       

    MSG1 DB 'Number1 is Greater$'  
    MSG2 DB 'Number2 is Greater$'

.CODE
    MAIN PROC    
        
        MOV AX,@DATA
        MOV DS,AX
    
        MOV AX,5
        MOV CX,4
        CMP AX,CX
        JG  TRUE_CON   
        
        JMP FALSE_CON
        

    TRUE_CON:
        LEA DX,MSG1
        MOV AH,09H
        INT 21H   
        JMP EXIT
    
    
    FALSE_CON:
        LEA DX,MSG2
        MOV AH,09H
        INT 21H  
        
        
    EXIT:  
        MOV AH,0CH
        INT 21H
    
    
    MAIN ENDP  
END MAIN