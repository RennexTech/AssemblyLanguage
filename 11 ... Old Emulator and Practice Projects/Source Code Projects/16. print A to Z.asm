.model small
.stack 100H

.code 

main proc
    
    mov bl,'A'
    mov cx,26     
    
    mov ah,2
    
    
    for: 
          
    mov dl,bl
    int 21h
    
    inc bl
    dec cx
    
    jnz for
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main