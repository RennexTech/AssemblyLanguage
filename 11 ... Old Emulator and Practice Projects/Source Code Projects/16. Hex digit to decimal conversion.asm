.model small
.stack 100h

.code

main proc
    
    mov ah,1
    int 21h
    mov bl,al
    
    
    sub bl,17    ; hex digit theke decimal er last digit     
    
    
    mov ah,2
    mov dl,49    ; first digit 1 hbe.... tai 1+48=49   
    int 21h
    
    mov dl,bl
    int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main



