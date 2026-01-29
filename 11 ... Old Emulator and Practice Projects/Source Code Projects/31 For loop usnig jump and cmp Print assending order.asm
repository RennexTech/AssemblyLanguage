.model small
.stack 100h

.code

main proc
      
    mov ah,1
    int 21h
    mov bl,al
    
    
    mov cl,'1' 
    
    
    for:
    cmp cl,bl
    
    jg exit         ; if cl>bl then exit
    
    mov ah,2
    mov dl,cl
    int 21h         ; print cl
    
    inc cl          ; cl++
    
    jmp for  
    
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main


