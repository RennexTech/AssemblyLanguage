.model small
.stack 100h

.code 

main proc 
    
    
    
    mov cx,26
    mov bl,'A'
    
    
    for: 
    
    mov ah,2
    mov dl,bl
    int 21h
    
    inc bl
    
    loop for
    
    
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
