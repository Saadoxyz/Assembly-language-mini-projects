.MODEL SMALL
.STACK 100H

.DATA
    myString db "Hello World$" ;Declare a null termianted String and putting $ at the end because of string terminator
    
.CODE  
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX
    
    MOV DX, OFFSET myString
    
    MOV AH,09h
    INT 21H
           
    MOV AH,4CH
    INT 21H
    
MAIN ENDP
END MAIN