data segment 
    n1 db ?
    n2 db ?
    array1 db 20 dup('$')
    msg1 db 10,13,"Enter elements of array: $"
    msg2 db 10,13,"Count: $"
    msg3 db 10,13,"Key to be searched: $"
    msg4 db 10,13,"Not found $"
    msg5 db 10,"Found at $"
    msg6 db "index position $"

data ends

code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax

    lea dx,msg1
    mov ah,09h
    int 21h;print msg1

    mov cl,00h;Count
    lea si,array1;pointer to array

    ;input procedure

    loop1:mov ah,01h
    int 21h
    cmp al,13
    je skip1
    mov [si],al
    inc si
    inc cl
    jmp loop1

    skip1:lea dx,msg2
    mov ah,09h
    int 21h

    mov n1,cl;copied length to n1
    mov al,n1;moved a copy of n1 to al
    add al,30h;convert to ascii
    mov dl,al
    mov ah,02h
    int 21h

    lea dx,msg3;key to search msg
    mov ah,09h
    int 21h

    mov ah,01h
    int 21h
    ;sub al,30h;conversion into hex
    mov n2,al

    ;mov al,n2
    ;add al,30h
    ;mov dl,al
    ;mov ah,02h;checking it by displaying it
    ;int 21h

    mov ch,00h

    mov cl,n1;length of array
    lea si,array1
    loop2:mov al,[si]
    inc ch
    cmp al,n2
    je found
    inc si
    dec cl;decrementing Count
    jnz loop2
    jmp notfound

    found:lea dx,msg5
    mov ah,09h
    int 21h
    lea dx,msg6
    mov ah,09h
    int 21h
    dec ch
    mov al,ch
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h
    jmp exit

    notfound:lea dx,msg4
    mov ah,09h
    int 21h
    jmp exit



   exit: mov ah,4ch
    int 21h

    code ends
    end start    
    
    