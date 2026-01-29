.model small
.stack 100H     

.data
m1 DB 0dh,0ah,"Neither Y nor y$"

.code 

main proc
    
    mov ax,@data
    mov ds,ax
    
    mov ah,1
    int 21h
    mov bl,al
    
    cmp bl,'y'
    je display
    
    cmp bl,'Y'
    je display 
    
    jmp ndisplay 
    
    
    display:
   
    mov ah,2
    mov dl,bl
    int 21h 
    jmp exit 
    
     
    ndisplay:
        
    mov ah,9
    lea dx,m1
    int 21h 
    jmp exit
    
    
    
   
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main