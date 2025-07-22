.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'ENTER FIRST NUMBER: $'
    MSG2 DB 'ENTER SECOND NUMBER: $'
    NEWLINE DB 10,13,'$'

.CODE
    MAIN PROC
                  
        MOV AX,@DATA
        MOV DS,AX
        
        LEA DX,MSG1
        MOV AH,09H
        INT 21H
        
        MOV AH,01H
        INT 21H
        SUB AL,'0'
        MOV CH,AL
        
        MOV AH,01H
        INT 21H
        SUB AL,'0'
        MOV CL,AL
        
        LEA DX,NEWLINE
        MOV AH,09H
        INT 21H
        
        LEA DX,MSG2
        MOV AH,09H
        INT 21H 
        
        MOV AH,01H
        INT 21H
        SUB AL,'0'
        MOV BH,AL
        
        MOV AH,01H
        INT 21H
        SUB AL,'0'
        MOV BL,AL 
        
        LEA DX,NEWLINE
        MOV AH,09H
        INT 21H 
        
        ;NOW ADDINGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
        
        ADD CH,BH
        MOV DL,CH
                 
        ADD DL,'0'         
        MOV AH,02H
        INT 21H 
        
        XOR DH,DH
        
        ADD CL,BL
        MOV DL,CL
        
        ADD DL,'0'         
        MOV AH,02H
        INT 21H
              
        
        MOV AH,4CH
        INT 21H
        
    MAIN ENDP
END MAIN