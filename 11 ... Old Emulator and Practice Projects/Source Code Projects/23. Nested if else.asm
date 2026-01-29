.model small
.stack 100h

.data
a db 0Ah,0dh,"Equal to 5 $"
b db 0Ah,0dh,"Greater than 5 $"
c db 0Ah,0dh,"less than 5 $" 


.code

main proc   
    
    mov ax,@data
    mov ds,ax 
    
    mov ah,1
    int 21h
    mov bl,al
    
    
    cmp bl,53  ; 5+48=53  
    
    je l1    ; if(bl==5)
    jg l2    ; else if(bl>5)
    jmp l3   ; else
    
    
    l1:
    mov ah,9
    lea dx,a
    int 21h
    jmp exit
    
    l2:
    mov ah,9
    lea dx,b
    int 21h
    jmp exit
    
    l3:
    mov ah,9
    lea dx,c
    int 21h
    jmp exit
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main


