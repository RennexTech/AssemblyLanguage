.model small
.stack 100h

.code

main proc
     
     
    mov bl,5
    neg bl
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main