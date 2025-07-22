MODEL SMALL
.STACK 100H

.DATA
    limit db 10    
    fib db 20 dup(?)

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV SI, offset fib
    MOV CX, 0       
    
    MOV byte ptr [SI], 0 
    INC SI
    MOV byte ptr [SI], 1 
    INC SI
    MOV CX, 2          
    
fib_loop:
    CMP CL, limit      
    JAE done
    
    MOV AL, [SI-2]      
    ADD AL, [SI-1]    
    MOV [SI], AL       
    
    INC SI
    INC CX
    JMP fib_loop
    
done:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN