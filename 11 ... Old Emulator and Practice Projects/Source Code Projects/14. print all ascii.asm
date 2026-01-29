.model small
.stack 100H

.code 
main proc
    
    mov ah,2
    
    mov cx,256 
    
    mov bl,0
    
    
    for: 
    
    mov dl,bl
    int 21h 
    
    inc bl 
    ;dec cx
    
    
    loop for ; jnz for
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    
    
    
    