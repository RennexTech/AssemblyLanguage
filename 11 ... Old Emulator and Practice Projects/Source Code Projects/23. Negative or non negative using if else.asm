.model small
.stack 100h

.data

a db "Non Negative $"
b db "Negative $"

.code
main proc 
    
    mov ax,@data
    mov ds,ax   
    
    mov bx,-10
    
    cmp bx,0
    
    jge l1        ; bx>=0
    jmp l2        ; else
    
    
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
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main