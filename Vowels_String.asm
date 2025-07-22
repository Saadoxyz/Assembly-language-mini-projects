MODEL SMALL
.STACK 100H

.DATA
    str db 'Hello World!', '$'  
    vowels db 'AEIOUaeiou'  
    count db 0                

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX          
    
    MOV SI, offset str  
    MOV DI, offset vowels
    
count_loop:
    MOV AL, [SI]        
    CMP AL, '$'          
    JE done
    
    MOV CX, 10         
    REPNE SCASB         
    JNE next_char       
    
    INC count           
    
next_char:
    MOV DI, offset vowels 
    INC SI              
    JMP count_loop
    
done:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN