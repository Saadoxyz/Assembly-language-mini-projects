.MODEL SMALL
.STACK 100H
.DATA
    DIGIT1 DB 0AH, 0DH, "ENTER FIRST DIGIT: $"
    DIGIT2 DB 0AH, 0DH, "ENTER SECOND DIGIT: $"
    RESULT DB 0AH, 0DH, "RESULT IS: $"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Get first 2-digit number
    LEA DX, DIGIT1
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BH, AL    ; Tens digit
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL    ; Units digit
    
    ; Get second 2-digit number
    LEA DX, DIGIT2
    MOV AH, 09H
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV CH, AL    ; Tens digit
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV CL, AL    ; Units digit   
    
    ;HERE THE INPUT PROCEDURE IS DONE LETS MOVE ON TO ADD
    
    ; Add units digits
    ADD BL, CL
    MOV AL, BL
    MOV AH, 0
    
    MOV CL, AL    ; Result units digit
    MOV BL, AH    ; Carry over
    
    ; Add tens digits with carry
    ADD BL, BH
    ADD BL, CH
    MOV AL, BL
    MOV AH, 0
    AAA           ; Adjust after addition
    
    ; Prepare result digits
    MOV BH, AH    ; Possible hundreds digit
    MOV BL, AL    ; Tens digit
    
    ; Display result
    LEA DX, RESULT
    MOV AH, 09H
    INT 21H
    
    ; Display hundreds digit if present
    CMP BH, 0
    JE  SKIP_HUNDREDS
    MOV DL, BH
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
SKIP_HUNDREDS:
    ; Display tens digit
    MOV DL, BL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
    ; Display units digit
    MOV DL, CL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN