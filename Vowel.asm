data segment
    n db ?
    str1 db 20 dup('?')
    msg1 db 10,13,"Enter the string: $"
    msg2 db 10,13,"Count: $"
    msg3 db 10,13,"Number of vowels: $"
data ends

code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax

    mov si,offset str1
    mov cl,00h
    lea dx,msg1
    mov ah,09H
    int 21H

    mov ah,01h
    loop1: int 21h
    cmp al,0Dh
    je escape1
    mov [si],al
    inc cl
    inc si
    jmp loop1

    escape1:mov n,cl

    lea dx,msg2
    mov ah,09H
    int 21H
    mov al,n
    add al,30h
    mov dl,al
    mov ah,02H
    int 21h

    mov bh,00h

    mov si,offset str1
    loop2:mov al,[si]
    cmp al,0Dh
    je escape2
    cmp al,'a'
    jne skip1
    inc bh
    skip1:cmp al,'e'
    jne skip2
    inc bh
    skip2:cmp al,'i'
    jne skip3
    inc bh
    skip3:cmp al,'o'
    jne skip4
    inc bh
    skip4:cmp al,'u'
    jne skip5
    inc bh

    skip5:inc si
    jmp loop2

    escape2:mov al,bh
    add al,30h
    lea dx,msg3
    mov ah,09H
    int 21h
    mov dl,al
    mov ah,02H
    int 21h

    mov ah,4ch
    int 21h

    code ends
    end start