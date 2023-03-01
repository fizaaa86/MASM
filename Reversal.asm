data segment
    n db ?
    str1 db 20 dup('$')
    str2 db 20 dup('$')
    msg1 db 10,13,"Enter string: $"
    msg2 db 10,13,"Count: $"
    msg3 db 10,13,"Reversed string: $"
data ends

code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax

    lea dx,msg1
    mov ah,09H
    int 21H

    mov cl,00h
    call input
    lea dx,msg2
    mov ah,09H
    int 21H

    mov al,n
    add al,30h
    mov dl,al
    mov ah,02H
    int 21h
    
    lea dx,msg3
    mov ah,09H
    int 21h
    dec si
    mov cl,n
    lea di,str2
    call reverse
    
    mov ah,4cH
    int 21H

    input proc near
    lea si,str1
    loop1:mov ah,01h
    int 21H
    cmp al,0Dh
    je skip
    mov [si],al
    inc si
    inc cl
    jmp loop1
    skip:mov n,cl
    ret
    input endp

    reverse proc near
    loop2:mov al,[si]
    mov [di],al
    inc di
    dec si
    dec cl
    jnz loop2

    lea dx,str2
    mov ah,09H
    int 21H
    ret 
    reverse endp


   
    



    code ends
    end start