.MODEL SMALL
.STACK 100H

.DATA
    MSG_EQUAL    DB 'THEY ARE EQUAL$'
    MSG_NOT_EQUAL DB 'THEY ARE NOT EQUAL$'
    INPUT_BUFFER  DB 100, ?, 100 DUP('$')   
    ENCRYPTED     DB 100 DUP('$')    
    DECRYPTED     DB 100 DUP('$')   
    NEWLINE       DB 10,13,'$'
    ENC_MSG       DB 'Encrypted: $'
    DEC_MSG       DB 'Decrypted: $'

.CODE
MAIN PROC    
    
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX               
    
    MOV AH, 0AH
    LEA DX, INPUT_BUFFER
    INT 21H
    
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H   
    
    LEA SI, INPUT_BUFFER+2   
    LEA DI, ENCRYPTED
    MOV CL, INPUT_BUFFER+1    
    MOV CH, 0
    REP MOVSB                 

    LEA SI, ENCRYPTED
    MOV CL, INPUT_BUFFER+1             
    
ENCRYPT_LOOP1:
    MOV AL, [SI]
    ROL AL, 3                
    MOV [SI], AL
    INC SI
    LOOP ENCRYPT_LOOP1
    
    MOV CL, INPUT_BUFFER+1
    CMP CL, 1
    JBE SKIP_ROTATE
    LEA SI, ENCRYPTED
    MOV DI, SI
    MOV AL, [SI]             
    INC SI
    DEC CX                    
    REP MOVSB                 
    MOV [DI], AL   
              
SKIP_ROTATE:    
    LEA SI, ENCRYPTED
    MOV CL, INPUT_BUFFER+1 
    
ENCRYPT_LOOP2:
    MOV AL, [SI]
    ROR AL, 2                 
    MOV [SI], AL
    INC SI
    LOOP ENCRYPT_LOOP2
    
    
    MOV AH, 09H
    LEA DX, ENC_MSG
    INT 21H
    LEA DX, ENCRYPTED
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    
    LEA SI, ENCRYPTED
    LEA DI, DECRYPTED
    MOV CL, INPUT_BUFFER+1
    REP MOVSB
    
    LEA SI, DECRYPTED
    MOV CL, INPUT_BUFFER+1 
    
DECRYPT_LOOP1:
    MOV AL, [SI]
    ROL AL, 2                
    MOV [SI], AL
    INC SI
    LOOP DECRYPT_LOOP1
    
    MOV CL, INPUT_BUFFER+1
    CMP CL, 1
    JBE SKIP_ROTATE_DEC
    LEA SI, DECRYPTED
    ADD SI, CX
    DEC SI                    
    MOV AL, [SI]              
    MOV DI, SI
    DEC SI
    STD                     
    REP MOVSB                
    CLD                       
    MOV [DECRYPTED], AL      

SKIP_ROTATE_DEC:
    LEA SI, DECRYPTED
    MOV CL, INPUT_BUFFER+1  
    
DECRYPT_LOOP2:
    MOV AL, [SI]
    ROR AL, 3            
    MOV [SI], AL
    INC SI
    LOOP DECRYPT_LOOP2

    MOV AH, 09H
    LEA DX, DEC_MSG
    INT 21H
    LEA DX, DECRYPTED
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    
   
    LEA SI, INPUT_BUFFER+2
    LEA DI, DECRYPTED        
    MOV CL, INPUT_BUFFER+1  
    REPE CMPSB              
    JNE NOT_EQUAL
    
    MOV AH, 09H
    LEA DX, MSG_EQUAL
    INT 21H
    JMP EXIT
    
NOT_EQUAL:
    MOV AH, 09H
    LEA DX, MSG_NOT_EQUAL
    INT 21H
    
EXIT:
    MOV AH, 4CH
    INT 21H    
MAIN ENDP
END MAIN