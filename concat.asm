data segment
    n1 db ?
    n2 db ?
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13,"Enter string: $"
    msg2 db 10,13,"Count: $"
    msg3 db 10,13,"Enter substring: $"
    msg4 db 10,13,"Concatenated string: $"
data ends

code segment
assume cs:code,ds:data

start:
    mov ax,data
    mov ds,ax

    lea dx,msg1
    mov ah,09h
    int 21h;print msg1

    mov cl,00h;counter
    lea si,str1

    loop1:mov ah,01h
    int 21h
    cmp al,0Dh
    je skip1
    mov [si],al
    inc si
    inc cl
    jmp loop1

    skip1:mov n1,cl

    ;print count of first

    lea dx,msg2
    mov ah,09h
    int 21h

    mov al,n1
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

    ;second string

    ;message

    lea dx,msg3
    mov ah,09h
    int 21h

    ;inputing

    lea di,str2
    mov cl,00h

    loop2:mov ah,01h
    int 21h
    cmp al,0Dh
    je skip2
    mov [di],al
    inc di
    inc cl
    jmp loop2

    skip2:mov n2,cl

    ;print its count

    lea dx,msg2
    mov ah,09h
    int 21h

    mov al,n2
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

    ;concatenation
    lea dx,msg4
    mov ah,09h
    int 21h

    mov cl,n2;count of second string

    lea di,str2

    loop4:mov al,[di]
    mov [si],al
    inc si
    inc di
    dec cl
    jnz loop4

    lea dx,str1
    mov ah,09h
    int 21h


    mov ah,4ch
    int 21h

    code ends
    end start
