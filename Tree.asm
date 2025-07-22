.model small
.stack 100h

.data
    arr      db 6, 5, 4, 3, 2, 1
    n        equ 6

    pre_msg  db 'Preorder: $'
    in_msg   db 'Inorder: $'
    post_msg db 'Postorder: $'
    newline  db 13, 10, '$'
    space    db ' $'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov dx, offset pre_msg
    call print_str
    mov al, 0
    call preorder
    call print_newline

    mov dx, offset in_msg
    call print_str
    mov al, 0
    call inorder
    call print_newline

    mov dx, offset post_msg
    call print_str
    mov al, 0
    call postorder
    call print_newline

    mov ah, 4ch
    int 21h
main endp

preorder proc
    cmp al, n
    jge pre_done
    
    call print_node
    
    push ax
    mov bl, al
    add bl, bl
    inc bl
    mov al, bl
    call preorder
    
    pop ax
    mov bl, al
    add bl, bl
    add bl, 2
    mov al, bl
    call preorder

pre_done:
    ret
preorder endp

inorder proc
    cmp al, n
    jge in_done
    
    push ax
    mov bl, al
    add bl, bl
    inc bl
    mov al, bl
    call inorder
    
    pop ax
    push ax
    call print_node
    
    pop ax
    mov bl, al
    add bl, bl
    add bl, 2
    mov al, bl
    call inorder

in_done:
    ret
inorder endp

postorder proc
    cmp al, n
    jge post_done
    
    push ax
    mov bl, al
    add bl, bl
    inc bl
    mov al, bl
    call postorder
    
    pop ax
    push ax
    mov bl, al
    add bl, bl
    add bl, 2
    mov al, bl
    call postorder
    
    pop ax
    call print_node

post_done:
    ret
postorder endp

print_node proc
    push ax
    push bx
    push dx
    
    xor bh, bh
    mov bl, al
    mov dl, arr[bx]
    add dl, '0'
    mov ah, 02h
    int 21h
    
    mov dx, offset space
    call print_str
    
    pop dx
    pop bx
    pop ax
    ret
print_node endp

print_str proc
    mov ah, 09h
    int 21h
    ret
print_str endp

print_newline proc
    mov dx, offset newline
    call print_str
    ret
print_newline endp

end main