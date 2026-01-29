.MODEL SMALL
.STACK 100H  
.DATA
   MSG1 DB 'HELLO $'
   MSG2 DB 'WORLD $'
   
.CODE
   MAIN PROC   
      MOV AX, @DATA        ; initialize DS
      MOV DS, AX
      
      JMP LABEL2           ; jump to LABEL2
      
      label1:     
         MOV AH, 9         ; display MSG2
         LEA DX, MSG2
         INT 21H
         JMP EXIT          ; jump to EXIT
      
      label2:
         MOV AH, 9         ; display MSG1
         LEA DX, MSG1
         INT 21H
         JMP LABEL1        ; jump to LABEL1
      
      EXIT:
         MOV AH, 4CH       ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN