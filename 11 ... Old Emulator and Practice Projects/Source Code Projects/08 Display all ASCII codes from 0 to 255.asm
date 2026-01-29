.MODEL SMALL 
.STACK 100H
.CODE     
   MAIN PROC      
      MOV AH, 2         ; set single char output function
      MOV DL, 0         ; put 0 in DL
      
      LOOP1:  
         INT 21H
         INC DL         ; increment DL by 1
         CMP DL, 0      ; compare DL with 0
         JNZ LOOP1      ; jump to LOOP1 if not zero
         JMP EXIT       ; otherwise jump to EXIT
      
      EXIT:
         MOV AH, 4CH    ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN