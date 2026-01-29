.model small
.stack 100h

.code

main proc 
    
    mov ah,1
    int 21h
    mov bl,al
    
    
    cmp bl,97
    
    jl l2           ; a er theke choto hole
    
    cmp bl,122
    jg l2            ; z er theke boro hole
    
    jmp l1
    
     
    
    
    
    
    l1:               ; lowercase hoile
    sub bl,32
    
    mov ah,2
    mov dl,bl
    int 21h 
    jmp exit
    
    l2:                ; na hole jeta ase setai thakbe
    mov ah,2
    mov dl,bl
    int 21h 
    jmp exit
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main

