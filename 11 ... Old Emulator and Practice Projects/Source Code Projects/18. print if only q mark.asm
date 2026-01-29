.model small
.stack 100H

.code 

main proc
    
    mov ah,1
    int 21h
    mov bl,al
    
    cmp bl,'?'
    jne skip
    
    mov ah,2
    mov dl,bl
    int 21h
    
    skip:
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main