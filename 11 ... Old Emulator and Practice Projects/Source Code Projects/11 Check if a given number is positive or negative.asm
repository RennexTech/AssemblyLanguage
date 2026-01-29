.MODEL SMALL
.STACK 100H
.DATA
   MSG1 DB 'Positive $'   
   MSG2 DB 'Negative $'

.CODE
   MAIN PROC   
      MOV AX, @data    ; initialize data segment
      MOV DS, AX 
    
      MOV BX, -68      ; a random number in BX
        
      CMP BX, 0        ; compare it BX with 0
      JGE IF           ; JGE: jump if greater than/equal
      JL ELSE          ; JL: jump if less than
        
      IF:
         MOV AH, 9     ; print MSG1
         LEA DX, MSG1  
         INT 21h
         JMP EXIT
                  
      ELSE:
         MOV AH, 9     ; print MSG2
         LEA DX, MSG2  
         INT 21h 
         JMP EXIT
            
      EXIT:          
         MOV AH, 4CH   ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN