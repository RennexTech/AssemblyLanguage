.MODEL SMALL 
.STACK 100H        
.DATA
    STAR DB 10, 13, '*', '$'

.CODE     
    MAIN PROC
        MOV AX, @DATA   ; initialize data segment
        MOV DS, AX
             
        MOV CX, 80      ; loop number: 80
        
        LOOP1:
        MOV AH, 9       ; display STAR
        LEA DX, STAR
        INT 21H         
        LOOP LOOP1      ; start the loop again
        
        EXIT:
        MOV AH, 4CH
        INT 21H    
    MAIN ENDP
END MAIN