.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Class starts!$'
    MSG2 DB 'Recess time!$'
    MSG3 DB 'Class ends!$'
    MSG4 DB 'School is over!$' 
    BELL DB 'DING $'
    NEWLINE DB 10,13,'$'
    CLASS_DELAY EQU 1000  
    BREAK_DELAY EQU 500  

.CODE    

MAIN PROC 
    
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 09
    LEA DX, BELL
    INT 21H 
    
    LEA DX, MSG1
    INT 21H     
    
    LEA DX, NEWLINE
    INT 21H  
    
    CALL DELAY_CLASS
    

    LEA DX, BELL
    INT 21H
    LEA DX, BELL
    INT 21H
    LEA DX, MSG2
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    CALL DELAY_BREAK
    
    LEA DX, BELL
    INT 21H    
    
    LEA DX, MSG3
    INT 21H      
    
    LEA DX, NEWLINE
    INT 21H      
    
    CALL DELAY_CLASS
    
    LEA DX, BELL
    INT 21H
    
    LEA DX, BELL
    INT 21H   
    
    LEA DX, BELL
    INT 21H   
    
    LEA DX, MSG4
    INT 21H    
    
    LEA DX, NEWLINE
    INT 21H
    
    MOV AH, 4CH
    INT 21H   
    
MAIN ENDP

DELAY_CLASS PROC
    PUSH CX
    MOV CX, CLASS_DELAY
    
CLASS_LOOP:
    LOOP CLASS_LOOP
    POP CX
    RET          
    
DELAY_CLASS ENDP

DELAY_BREAK PROC
    PUSH CX
    MOV CX, BREAK_DELAY 
    
BREAK_LOOP:
    LOOP BREAK_LOOP
    POP CX
    RET          
    
DELAY_BREAK ENDP

END MAIN