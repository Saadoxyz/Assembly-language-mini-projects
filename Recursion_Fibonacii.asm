                           .MODEL SMALL
.STACK 100H

.DATA
    prompt DB 'Enter n (0-9): $'
    result DB 13,10,'Fibonacci(n) = $'
    n DB ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Show prompt
    MOV AH, 9
    LEA DX, prompt
    INT 21H

    ; Read single digit (0-9)
    MOV AH, 1
    INT 21H
    SUB AL, '0'     ; Convert to number
    MOV n, AL

    ; Calculate Fibonacci
    MOV BL, n
    CALL FIB
    MOV BH, 0       ; Clear BH for 16-bit result
    MOV CX, AX      ; Save result in CX

    ; Show result
    MOV AH, 9
    LEA DX, result
    INT 21H

    ; Print result (assuming result is 1 digit)
    MOV DL, CL
    ADD DL, '0'
    MOV AH, 2
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Simple iterative Fibonacci
; Input: BL = n
; Output: AX = Fib(n)
FIB PROC
    CMP BL, 0
    JE ZERO
    CMP BL, 1
    JE ONE

    MOV AL, 0       ; Fib(0) = 0
    MOV AH, 1       ; Fib(1) = 1
    MOV CL, 1       ; Counter

LOOP_FIB:
    INC CL
    MOV DL, AH      ; DL = Fib(n-1)
    ADD AH, AL      ; AH = Fib(n) = Fib(n-1)+Fib(n-2)
    MOV AL, DL      ; AL = Fib(n-1) for next iteration
    CMP CL, BL
    JNE LOOP_FIB

    MOV AL, AH      ; Return result in AX
    RET

ZERO:
    MOV AX, 0
    RET
ONE:
    MOV AX, 1
    RET
FIB ENDP

END MAIN