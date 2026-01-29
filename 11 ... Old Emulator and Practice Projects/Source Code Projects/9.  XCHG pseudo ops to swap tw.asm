;XCHG keywords

.model small
.stack 100h

.code

main proc
       
     
    mov ah,1
    int 21h
    mov bl,al
    
    int 21h
    mov bh,al
    
    
    xchg bl,bh
    
    
    mov ah,2
   mov dl,0Ah
   int 21h
   mov dl,0Dh
   int 21h 
    
    
    mov dl,bl
    int 21h
    
    mov dl,bh
    int 21h
      
    
       
       
    exit:
    mov ah,4ch
    int 21h
    main endp
end main