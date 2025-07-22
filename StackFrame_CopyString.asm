                   .MODEL SMALL
.STACK 100H

.DATA
    SRC DB "SOURCE", 0
    DEST DB 10 DUP(0)  ; Buffer for copy
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        MOV ES, AX      ; For REP MOVSB (if used)

        ; Call strcpy(DEST, SRC)
        LEA AX, DEST
        PUSH AX
        LEA AX, SRC
        PUSH AX
        CALL STRCPY
        ADD SP, 4       ; Clean stack

        ; Exit
        MOV AH, 4CH
        INT 21H
    MAIN ENDP

    STRCPY PROC
        PUSH BP
        MOV BP, SP
        PUSH SI
        PUSH DI

        MOV SI, [BP+4]  ; SRC
        MOV DI, [BP+6]  ; DEST

    COPY_LOOP:
        MOV AL, [SI]
        MOV [DI], AL
        INC SI
        INC DI
        CMP AL, 0
        JNE COPY_LOOP

        POP DI
        POP SI
        POP BP
        RET
    STRCPY ENDP
END MAIN