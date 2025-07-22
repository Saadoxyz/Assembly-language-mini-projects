.MODEL SMALL
.STACK 100H

.DATA

    MSG DB 100 DUP('$')
    NEWLINE DB 10,13,'$'

.CODE
    MAIN PROC  
        
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,0AH
    LEA DX,MSG
    INT 21H
    
    MOV AH,09H
    LEA DX,NEWLINE
    INT 21H
    
    MOV AH,09H
    LEA DX,MSG+2
    INT 21H
 
    MOV AH, 4CH
    INT 21H

    MAIN ENDP
END MAIN