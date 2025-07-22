                                   .MODEL SMALL
.STACK 100H

.DATA
    prompt1 DB 'Enter first number: $'
    prompt2 DB 'Enter second number: $'
    result  DB 'After swapping: $'
    num1    DW ?
    num2    DW ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Get first number
    MOV AH, 09H
    LEA DX, prompt1
    INT 21H
    CALL GET_NUMBER
    MOV num1, AX
    CALL NEW_LINE
    
    ; Get second number
    MOV AH, 09H
    LEA DX, prompt2
    INT 21H
    CALL GET_NUMBER
    MOV num2, AX
    CALL NEW_LINE

    ; Swap using registers (simpler than stack method)
    MOV AX, num1
    MOV BX, num2
    MOV num1, BX
    MOV num2, AX

    ; Display result
    MOV AH, 09H
    LEA DX, result
    INT 21H
    
    ; Display swapped numbers
    MOV AX, num1
    CALL DISPLAY_NUMBER
    
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    MOV AX, num2
    CALL DISPLAY_NUMBER

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Simplified number input (0-9 only)
GET_NUMBER PROC
    MOV AH, 01H      ; Single character input
    INT 21H
    SUB AL, '0'      ; Convert ASCII to digit
    MOV AH, 0        ; Clear upper byte
    RET
GET_NUMBER ENDP

; Display single digit (0-9)
DISPLAY_NUMBER PROC
    ADD AL, '0'      ; Convert digit to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    RET
DISPLAY_NUMBER ENDP

NEW_LINE PROC
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN