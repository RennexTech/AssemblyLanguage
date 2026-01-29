.model small
.stack 100h

.code

main proc
     
     
    mov ax,7
    
    
    ;rol ax,1 
    
    ;rcl ax,1 
    
    ;ror ax,1    
    
    rcr ax,1
    
    
    
    mov ah,2
    mov dx,ax 
    ;add dx,48  ; ascii value print krbe      ; kn jani lage na
    int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main

