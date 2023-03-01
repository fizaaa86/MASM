data segment
    n db ?
    char db ?
    str1 db 20 dup('$')
    msg1 db 10,13,"Enter string : $"
    msg2 db 10,13,"count: $"
    msg3 db 10,13,"Character: $"
    msg4 db 10,13,"occurence: $"
data ends

code segment
assume cs:code,ds:data

start:
    mov ax,data
    mov ds,ax

    lea dx,msg1
    mov ah,09h
    int 21h

    lea si,str1
    mov cl,00h
    call input

    lea dx,msg2
    mov ah,09h
    int 21h

    mov al,n
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

    lea dx,msg3
    mov ah,09h
    int 21h

    mov ah,01h;reading Character
    int 21h
    ;sub al,30h
    mov char,al

    mov ch,00h;counter for occurence

    lea dx,msg4;message for printing occurence
    mov ah,09h
    int 21h


    lea si,str1
    call counting

    mov ah,4ch
    int 21h


    input proc near
    loop1: mov ah,01h
    int 21h
    cmp al,0Dh
    je skip1
    mov [si],al
    inc si
    inc cl
    jmp loop1
    skip1:mov n,cl

    ret 
    input endp

    counting proc near
    mov bh,char;for comparing Character
    mov bl,n;length of string
    loop2:mov al,[si]
    cmp al,bh
    jne skip2
    inc ch
    skip2:inc si
    dec bl;decrementing count
    jnz loop2

    mov al,ch
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h
    ret

    counting endp

    code ends
    end start