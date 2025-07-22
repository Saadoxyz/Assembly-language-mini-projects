.MODEL SMALL
.STACK 100H

.DATA
    PROMPT DB "Enter array elements (1-digit numbers, press Enter after each): $"
    SUM_MSG DB 10, 13, "Sum of array: $"
    ARRAY DB 10 DUP(0)    ; Array to store 10 elements (1-digit each)
    LEN DB ?              ; Actual length of array (entered by user)
    SUM DB 0              ; Variable to store sum

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display input prompt
    MOV AH, 09H
    LEA DX, PROMPT
    INT 21H

    ; Initialize
    MOV SI, OFFSET ARRAY  ; SI points to array start
    MOV LEN, 0            ; Initialize length counter

INPUT_LOOP:
    ; Read a single character (digit)
    MOV AH, 01H
    INT 21H

    ; Check if Enter pressed (end input)
    CMP AL, 13            ; 13 = ASCII for Enter
    JE END_INPUT

    ; Convert ASCII digit to number ('0'-'9' ? 0-9)
    SUB AL, '0'

    ; Store in array
    MOV [SI], AL
    INC SI                ; Move to next array position
    INC LEN               ; Increment length counter

    ; Check if array is full (max 10 elements)
    CMP LEN, 10
    JB INPUT_LOOP         ; Jump if below 10

END_INPUT:
    ; Calculate sum
    MOV SI, OFFSET ARRAY  ; Reset SI to array start
    MOV CL, LEN           ; Loop counter = array length
    MOV SUM, 0            ; Clear sum

SUM_LOOP:
    MOV AL, [SI]          ; Load current element
    ADD SUM, AL           ; Add to sum
    INC SI                ; Move to next element
    LOOP SUM_LOOP

    ; Display result message
    MOV AH, 09H
    LEA DX, SUM_MSG
    INT 21H

    ; Display sum (convert to ASCII and print)
    MOV AL, SUM
    MOV AH, 0             ; Clear AH for division
    MOV BL, 10
    DIV BL                ; AL = quotient, AH = remainder

    ; Print tens digit (if any)
    CMP AL, 0
    JE PRINT_UNITS
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H

PRINT_UNITS:
    ; Print units digit
    ADD AH, '0'
    MOV DL, AH
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN