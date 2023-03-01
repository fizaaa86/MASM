data segment
    n1 db ?
    n2 db ?
    n3 db ?
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13,"Enter string: $"
    msg2 db 10,13,"Count: $"
    msg3 db 10,13,"Substring: $"
    msg4 db 10,13,"length of string after deleting: $"
    msg5 db 10,13,"Original string after deleting: $"
data ends

code segment
assume cs:code,ds:data

start:
    mov ax,data
    mov ds,ax

    ;string1 msg

    lea dx,msg1
    mov ah,09H
    int 21H

    lea si,str1
    mov cl,00h

    ;inputting

    loop1:mov ah,01h
    int 21H
    cmp al,13
    je skip1
    mov [si],al
    inc si
    inc cl
    jmp loop1
    skip1:mov n1,cl


    lea dx,msg2
    mov ah,09H
    int 21H

    mov al,n1
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

    lea dx,msg3
    mov ah,09H
    int 21h

    lea di,str2
    mov cl,00h

    ;inputting

    loop2:mov ah,01h
    int 21H
    cmp al,13
    je skip2
    mov [di],al
    inc di
    inc cl
    jmp loop2
    skip2:mov n2,cl

    lea dx,msg2
    mov ah,09H
    int 21H

    mov al,n2
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

    lea dx,msg4
    mov ah,09H
    int 21H

    mov al,n1
    sub al,n2
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

    lea dx,msg5
    mov ah,09H
    int 21H

    lea si,str1
    lea di,str2
    ;deleting
    mov cl,'$'
    rr:cmp cl,[si]
    je exit
    mov al,[di]
    cmp al,[si]
    jne escape2
    inc si
    inc di
    cmp cl,[di]
    jne rr
    jmp escape3

    escape2:lea di,str2
    mov bl,[si]
    mov dl,bl
    mov ah,02h
    int 21H
    inc si
    jmp rr

    escape3:mov bl,[si]
    cmp bl,cl
    je exit 
    mov dl,bl
    mov ah,02h
    int 21H
    inc si
    jmp escape3



    exit:mov ah,4ch
    int 21H

    code ends
    end start


