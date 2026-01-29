.model small
.stack 100h

.code

main proc
    
    mov ah,1
    int 21h
    mov bl,al
    
    int 21h
    mov bh,al
    
    
    cmp bl,bh
    
    jge l1          ;  bl er value >= bh er value hoile ei label e jabe
    jmp l2          ; else ei label e jabe
    
    
    l1:
    mov ah,2
    mov dl,bl           
    int 21h 
    jmp exit
    
    
    l2:
    mov ah,2
    mov dl,bh
    int 21h
    jmp exit
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main

