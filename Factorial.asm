              MODEL SMALL
.STACK 100H

.DATA
    num db 5       
    result dw ?    

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL, num    
    MOV AH, 0    
    MOV CX, AX      
    
    MOV AX, 1    
    
    CMP CX, 0   
    JE done        
    
factorial_loop:
    MUL CX       
    LOOP factorial_loop
    
done:
    MOV result, AX 
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN