.model small
.stack 100h

.data

m1 DB "Enter three initials : $"
nl DB 0DH,0AH,"$"
ast DB "***********",0DH,0AH,"$"

.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,2
    mov dl,'?'
    int 21h
    
    mov ah,9   
    lea dx,nl
    int 21h
    
    lea dx,m1
    int 21h  
    
    mov ah,1
    int 21h
    mov bl,al
    
    int 21h
    mov bh,al
    
    int 21h
    mov cl,al
    
    mov ah,9
    lea dx,nl
    int 21h

    lea dx,ast
    
    int 21h  
    int 21h
    int 21h
    int 21h
    int 21h 
    
    
    mov ast+4,bl 
    mov ast+5,bh
    mov ast+6,cl
    
    int 21h
    
    
    mov ast+4,'*' 
    mov ast+5,'*'
    mov ast+6,'*'
    
    int 21h  
    int 21h
    int 21h
    int 21h
    int 21h 
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
    
    
    
    
    
    

