.model small
.stack 100h

.code

main proc
     
     
    mov ax,4
    
    ;shl ax,1 
    
    shr ax,1
    
    
    mov ah,2
    mov dx,ax 
    add dx,48
    int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main



