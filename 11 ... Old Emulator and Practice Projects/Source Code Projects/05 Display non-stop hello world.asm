.MODEL SMALL
.STACK 100H
.DATA
   STR DB 'HELLO WORLD $'
   
.CODE
   MAIN PROC
      MOV AX, @DATA    ; initialize ds
      MOV DS, AX
      
      LABEL: 
         MOV AH, 9     ; display STR
         LEA DX, STR 
         INT 21H
         
         MOV AH, 2     ; display new line
         MOV DL, 10
         INT 21H
         MOV DL, 13
         INT 21H 
         
         JMP LABEL     ; jump to label

   MAIN ENDP
END MAIN