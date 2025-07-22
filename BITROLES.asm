.MODEL SMALL
.STACK 100H

.DATA    
    MSGD DB 10,13,'_____________________WORKER ROLE SYSTEM_____________________ $',10,13   
    MENU_MSG    DB 10,13,'1. Assign Role',10,13
                DB '2. Revoke Role',10,13
                DB '3. Check Role',10,13
                DB '4. Display Roles',10,13
                DB '5. Exit',10,13
                DB 'Enter choice (1-5): $'
    ROLE_PROMPT DB 10,13,'Enter role number (0-7): $'
    INVALID_MSG DB 10,13,'Invalid input!$'
    ASSIGNED_MSG DB 10,13,'Role assigned.$'
    REMOVED_MSG DB 10,13,'Role removed.$'
    HAS_ROLE_MSG DB 10,13,'Worker has this role.$'
    NO_ROLE_MSG DB 10,13,'Worker does not have this role.$'
    CURRENT_ROLES DB 10,13,'Current roles: $'
    NO_ROLES_MSG DB 10,13,'No roles assigned.$'
    
    ROLE_NAMES DW OFFSET MINER, OFFSET TECHNICIAN, OFFSET SUPERVISOR, OFFSET SAFETY_OFFICER
               DW OFFSET ENGINEER, OFFSET MEDIC, OFFSET ADMIN, OFFSET RESERVED
    MINER DB 'Miner$'
    TECHNICIAN DB 'Technician$'
    SUPERVISOR DB 'Supervisor$'
    SAFETY_OFFICER DB 'Safety Officer$'
    ENGINEER DB 'Engineer$'
    MEDIC DB 'Medic$'
    ADMIN DB 'Admin$'
    RESERVED DB 'Reserved$'
    
    roles DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
MENU_LOOP:
    MOV AH, 09H
    LEA DX, MSGD
    INT 21H

    MOV AH, 09H
    LEA DX, MENU_MSG
    INT 21H
    
    MOV AH, 01H
    INT 21H
    
    CMP AL, '1'
    JE ASSIGN
    CMP AL, '2'
    JE REVOKE
    CMP AL, '3'
    JE CHECK
    CMP AL, '4'
    JE DISPLAY
    CMP AL, '5'
    JE EXIT_PROGRAM
    
    MOV AH, 09H
    LEA DX, INVALID_MSG
    INT 21H
    JMP MENU_LOOP
    
ASSIGN:
    CALL ASSIGN_ROLE
    JMP MENU_LOOP
    
REVOKE:
    CALL REVOKE_ROLE
    JMP MENU_LOOP
    
CHECK:
    CALL CHECK_ROLE
    JMP MENU_LOOP
    
DISPLAY:
    CALL DISPLAY_ROLES
    JMP MENU_LOOP
    
EXIT_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP


GET_ROLE_NUMBER PROC
    MOV AH, 09H
    LEA DX, ROLE_PROMPT
    INT 21H
    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'    
    
    CMP AL, 0
    JL INVALID_INPUT
    CMP AL, 7
    JG INVALID_INPUT
    
    MOV BL, AL     
    RET
    
INVALID_INPUT:
    MOV AH, 09H
    LEA DX, INVALID_MSG
    INT 21H
    JMP GET_ROLE_NUMBER
GET_ROLE_NUMBER ENDP


ASSIGN_ROLE PROC
    CALL GET_ROLE_NUMBER  
    
    MOV CL, BL
    MOV AL, 1
    SHL AL, CL      
    
    OR [roles], AL
    
    MOV AH, 09H
    LEA DX, ASSIGNED_MSG
    INT 21H
    
    RET
ASSIGN_ROLE ENDP

REVOKE_ROLE PROC
    CALL GET_ROLE_NUMBER 
    
    MOV CL, BL
    MOV AL, 1
    SHL AL, CL       
    NOT AL           
    
    AND [roles], AL
    
    MOV AH, 09H
    LEA DX, REMOVED_MSG
    INT 21H
    
    RET
REVOKE_ROLE ENDP

CHECK_ROLE PROC
    CALL GET_ROLE_NUMBER 
    
    MOV CL, BL
    MOV AL, 1
    SHL AL, CL     
    
    TEST [roles], AL
    
    MOV AH, 09H
    JNZ HAS_ROLE
    LEA DX, NO_ROLE_MSG
    JMP DISPLAY_RESULT
    
HAS_ROLE:
    LEA DX, HAS_ROLE_MSG
    
DISPLAY_RESULT:
    INT 21H
    RET
CHECK_ROLE ENDP

DISPLAY_ROLES PROC
    MOV AH, 09H
    LEA DX, CURRENT_ROLES
    INT 21H
    
    MOV CX, 8      
    MOV BX, 0       
    MOV SI, 0       
    
    MOV AL, [roles]
    
ROLE_CHECK_LOOP:
    SHR AL, 1       
    JNC NEXT_ROLE    
    
    PUSH AX         
    PUSH CX          
    
    MOV AH, 09H
    MOV DI, BX
    SHL DI, 1      
    MOV DX, [ROLE_NAMES + DI]
    INT 21H
    
    MOV DL, ','
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    INT 21H
    
    POP CX           
    POP AX          
    INC SI          
    
NEXT_ROLE:
    INC BX         
    LOOP ROLE_CHECK_LOOP
    
    CMP SI, 0
    JNE DISPLAY_DONE
    
    MOV AH, 09H
    LEA DX, NO_ROLES_MSG
    INT 21H
    
DISPLAY_DONE:
    RET
DISPLAY_ROLES ENDP

END MAIN