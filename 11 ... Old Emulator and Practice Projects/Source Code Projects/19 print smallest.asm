.model small
.stack 100H

.code 

main proc
    
    mov ah,1
    
    int 21h
    mov bl,al
    
    int 21h
    mov bh,al
    
    cmp bl,al
    
    jle f
    jmp s
    
    
    f:
    mov ah,2
    mov dl,bl
    int 21h
    jmp exit
    
    
    s:
    mov ah,2
    mov dl,bh
    int 21h
    jmp exit
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main