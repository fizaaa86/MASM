data segment
    n1 db ?
    array1 db 20 dup('$')
    msg1 db 10,13,"Enter the array elements: $"
    msg2 db 10,13,"Count: $"
    msg3 db 10,13,"Sorted array: $"
data ends

code segment
assume cs:code,ds:data

start:
    mov ax,data
    mov ds,ax

    lea dx,msg1
    mov ah,09h
    int 21h;array element message

    lea si,array1
    mov cl,00h;counter

    loop1:mov ah,01h
    int 21h
    cmp al,0Dh
    je skip1
    mov [si],al
    inc si
    inc cl
    jmp loop1
    skip1:mov n1,cl

    lea dx,msg2;count message
    mov ah,09h
    int 21h

    mov al,n1
    add al,30h
    cmp al,39h
    jle skipc
    add al,07
    skipc:mov dl,al
    mov ah,02h
    int 21h

    lea dx,msg3
    mov ah,09h
    int 21h;sorted array
    
    

    mov cl,n1;copy of count
    dec cl

    loop2:mov ch,n1;copy of count,outer loop
    dec ch

    lea si,array1

    loop3:mov al,[si]
    inc si
    cmp al,[si]
    jc skip2
    mov bl,[si]
    dec si
    mov [si],bl
    inc si
    mov [si],al
    skip2:dec ch
    jnz loop3
    dec cl
    jnz loop2

    mov bl,n1
    lea si,array1;
    loop8:mov al,[si]
    mov dl,al
    mov ah,02h
    int 21h
    inc si
    dec bl
    jnz loop8
    ;mov ah,09h
    ;int 21h;printing sorted array

    mov ah,4ch
    int 21h

    code ends
    end start