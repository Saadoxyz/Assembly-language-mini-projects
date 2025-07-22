                          MODEL SMALL
.STACK 100H

.DATA
    str db 'madam', '$' 
    len equ $ - str - 1  
    is_palindrome db 0  

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX          
    
    MOV SI, offset str  
    MOV DI, SI
    ADD DI, len - 1     
    
    MOV CX, len / 2    
    
check_loop:
    MOV AL, [SI]        
    CMP AL, [DI]         
    JNE not_palindrome   
    
    INC SI              
    DEC DI              
    LOOP check_loop
    
    MOV is_palindrome, 1 
    JMP done
    
not_palindrome:
    MOV is_palindrome, 0
    
done:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN