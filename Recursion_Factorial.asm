.MODEL SMALL
.STACK 100H

.DATA
    PROMPT   DB 'Enter a number (0-8): $'
    RESULT   DB 0DH, 0AH, 'Factorial is: $'
    NEWLINE  DB 0DH, 0AH, '$'
    INVALID  DB 0DH, 0AH, 'Invalid input! Enter 0-8.$'
    NUM      DW ?     ; Stores input number
    FACT     DW ?     ; Stores factorial result

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

INPUT:
    ; Display prompt
    MOV AH, 9
    LEA DX, PROMPT
    INT 21H

    ; Read character input
    MOV AH, 1
    INT 21H

    ; Check if input is a digit (0-8)
    CMP AL, '0'
    JL  ERROR
    CMP AL, '8'
    JG  ERROR

    ; Convert ASCII to number
    SUB AL, '0'
    MOV AH, 0
    MOV NUM, AX

    ; Calculate factorial iteratively
    CALL CALC_FACT

    ; Display result
    MOV AH, 9
    LEA DX, RESULT
    INT 21H

    ; Display factorial result
    MOV AX, FACT
    CALL DISPLAY_NUMBER

    ; Exit
    MOV AH, 4CH
    INT 21H

ERROR:
    ; Show invalid message and try again
    MOV AH, 9
    LEA DX, INVALID
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    JMP INPUT
MAIN ENDP

; Iterative factorial calculation
CALC_FACT PROC
    MOV AX, 1       ; Initialize result
    MOV CX, NUM     ; Counter
    CMP CX, 0       ; Special case for 0!
    JE  DONE

CALC_LOOP:
    MUL CX          ; AX = AX * CX
    LOOP CALC_LOOP

DONE:
    MOV FACT, AX    ; Store result
    RET
CALC_FACT ENDP

; Display number in AX (simple version for 0-40320)
DISPLAY_NUMBER PROC
    MOV CX, 0       ; Digit counter
    MOV BX, 10      ; Divisor

PUSH_DIGITS:
    MOV DX, 0       ; Clear DX for division
    DIV BX          ; AX = AX/10, DX = remainder
    ADD DL, '0'     ; Convert to ASCII
    PUSH DX         ; Store digit
    INC CX          ; Count digits
    CMP AX, 0       ; Done?
    JNE PUSH_DIGITS ; No, continue

POP_DIGITS:
    POP DX          ; Get digit
    MOV AH, 2       ; Display character function
    INT 21H
    LOOP POP_DIGITS
    RET
DISPLAY_NUMBER ENDP

END MAIN