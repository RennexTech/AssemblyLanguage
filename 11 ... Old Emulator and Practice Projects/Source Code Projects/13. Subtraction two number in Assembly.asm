.model small
.stack 100h

.code

main proc
    
    mov ah,1
    int 21h
    mov bl,al
    
    int 21h
    mov bh,al
    
    sub bl,bh   ; bl=bl-bh   
    add bl,48   ; subtract krar por 48 add krte hoi
    
    
    
    mov ah,2 
    mov dl,bl
    int 21h
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
