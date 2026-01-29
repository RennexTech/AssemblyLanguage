.model small
.stack 100h

.code

main proc
     
    ;mov ah,1
    ;int 21h
    ;mov bl,al           ; input nile
    ;sub bl,48
    
    
    ;int 21h
    ;sub al,48            ; input nile
    
     
    mov al,16
    mov bl,3 
    
           
    mov ah,0   ; remainder thakbe tai 0 kre dite hbe
    div bl    ; al=al/bl   
    
    mov bx,ax
    
    mov ah,2
    mov dl,bl
    add dl,48
    int 21h
    
    mov dl,bh
    add dl,48
    int 21h
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main


