.MODEL SMALL
.STACK 100H

.DATA

    numbers db 0,1,2,3,4,5,6,7,8,9
    size equ $-numbers
    
    
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX     
        
        MOV CX,size
        MOV SI,OFFSET numbers
        
        DISPLAY:
            MOV DL,[SI]
            INC SI
                      
            ADD DL,'0'
            MOV AH,02H
            INT 21H
            
            MOV DL,' '
            MOV AH,02
            INT 21H 
            
        LOOP DISPLAY
        
        MOV AH,4CH
        INT 21H        
    MAIN ENDP
END MAIN                