.model small
.stack 100h

.code

main proc
     
    mov ah,1
    int 21h
    mov bl,al  
    sub al,48
    
    
    mov cx,0
    mov cl,al     ;counter initilization for loop op code ; cx=0,,counter register ta purata 0 krar jnno 
                  ; al ke direct cl e dewa jabe na
                  
                  
    
    for:
    
    mov ah,2 
    mov dl,bl
    int 21h 
    
    dec bl
    
    
    loop for        ; loop op code automatic cx er value dekhe,,,, otobar loop chalabe
    
    
     
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main