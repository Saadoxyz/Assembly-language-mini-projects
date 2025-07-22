.MODEL SMALL
.STACK 100H


.DATA      

    STR DB 'Enter a Number: $'
    NEWLINE DB 10,13,'$' 
    STREVE DB 'Number is Even$'
    STRODD DB 'Number is ODD$'

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        MOV AH,09
        MOV DX,OFFSET STR
        INT 21H       
        
        MOV AH,02H
        MOV DX,' '
        INT 21H   
        
        MOV AH,01H
        INT 21H   
        
        MOV CL, AL
        
        MOV AH,09
        MOV DX,OFFSET NEWLINE
        INT 21H 
        
        MOV AL, CL
        SUB AL,'0' 
  
        XOR AH,AH
        MOV BL,2
        DIV BL
        
        CMP AH,0
        JE EVEN  
        
        MOV AH,09
        MOV DX,OFFSET STRODD
        INT 21H
        JMP EXIT 
        
        EVEN:
            MOV AH,09
            MOV DX,OFFSET STREVE
            INT 21H      
        
        
        Exit: 
            MOV AH,4CH
            INT 21H
        
    MAIN ENDP
END MAIN