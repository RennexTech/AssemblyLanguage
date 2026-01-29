.MODEL SMALL
.STACK 100H
.CODE
   MAIN PROC    
      MOV CX, 26         ; loop number
      MOV AH, 2          ; set AH to single char output
      MOV DL, 'A'        ; initialize DL with 'A' (loop starts with)
      
      LOOP1: 
         INT 21H         ; display the DL
         INC DL          ; increment DL
         LOOP LOOP1
      
      EXIT:
         MOV AH, 4CH     ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN