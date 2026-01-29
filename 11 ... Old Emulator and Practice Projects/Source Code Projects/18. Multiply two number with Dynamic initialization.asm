.model small
.stack 100h

.data

a db ?
b db ?


.code

main proc
       
    mov ah,1
    int 21h
    sub al,48
    mov a,al
    
    int 21h
    sub al,48
    
    
    mul a            ; al=al*a
    
    aam              ;  
    
    
    mov bx,ax
    
    
    mov ah,2
    mov dl,bh
    add dl,48
    int 21h
    
    mov dl,bl
    add dl,48
    int 21h
    
    
    
    exit:  
    mov ah,4ch
    int 21h
    main endp
end main

         
         
         
 
 
;ASCII Adjust after Multiplication(AAM):

;Corrects the result of multiplication of two BCD values.

;Algorithm:

;AH = AL / 10

;AL = remainder

;Example:

;MOV AL, 15 ; // AL = 0Fh

;AAM ; // AH = 01, AL = 05

;RET