.model small
.stack 100h

.data
a db 0Ah,0Dh,'***** $' 

.code

main proc 
    
    mov ax,@data
    mov ds,ax
         
         
    mov cx,5      
    
    mov ah,9
    lea dx,a
    
    for:
    
    int 21h
    
    loop for
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    


