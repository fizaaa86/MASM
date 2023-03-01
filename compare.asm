data segment
    n1 db ?
    n2 db ?
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13,"Enter string: $"
    msg2 db 10,13,"Count: $"
    msg6 db 10,13,"Enter second string: $"
    msg3 db 10,13,"Not equal. $"
    msg4 db 10,13,"Equal.$"
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


    ;second string

    ;message

    lea dx,msg6
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


    ;comparing
    mov cl,n2
    mov al,n1
    cmp al,cl;comparing lengths
    jne notequal
    lea si,str1
    lea di,str2
    mov cl,n2

    loopr:mov al,[di]
    cmp al,[si]
    jne notequal
    inc si
    inc di
    dec cl
    jnz loopr
    jmp equal

    notequal:lea dx,msg3
    mov ah,09h
    int 21h
    jmp exit

    equal:lea dx,msg4
    mov ah,09h
    int 21h
    jmp exit


    exit:mov ah,4ch
    int 21h

    code ends
    end start
