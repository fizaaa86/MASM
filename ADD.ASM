data segment
    num1 db ?
    num2 db ?
    sum db ?
    carry db 00H
    msg1 db 10,13,"Enter first number : $"
    msg2 db 10,13,"Enter second number : $"
    msg3 db 10,13,"Sum : $"
data ends

code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    lea dx,msg1
    mov ah,09h
    int 21h
    call input
    mov num1,al
    lea dx,msg2
    mov ah,09h
    int 21h
    call input
    mov num2,al

    mov al,num1
    add al,num2
    daa
    jnc skip
    inc carry
    skip:mov sum,al

    mov ah,09h
    lea dx,msg3
    int 21h
    
    mov al,carry
    add al,30h
    cmp al,39h
    jle skip3
    add al,07h
    skip3:mov dl,al
    mov ah,02h
    int 21h

    lea si,sum
    call output
    mov ah,4Ch
    int 21h



    input proc near
    mov ah,01h
    int 21h
    sub al,30h
    cmp al,09h
    jle skip1
    sub al,07h
    skip1:mov cl,04h
    rol al,cl
    mov ch,al

    mov ah,01h
    int 21h
    sub al,30h
    cmp al,09h
    jle skip2
    sub al,07h
    skip2:add al,ch
    ret
    input endp

    output proc near
    mov al,[si]
    and al,0f0h
    mov cl,04h
    rol al,cl
    add al,30h
    cmp al,39h
    jle skip4
    add al,07h
    skip4:mov dl,al
    mov ah,02h
    int 21h

    mov al,[si]
    and al,0fh
    add al,30h
    cmp al,39h
    jle skip5
    add al,07h
    skip5:mov dl,al
    mov ah,02h
    int 21h
    ret
    output endp
code ends
end start
