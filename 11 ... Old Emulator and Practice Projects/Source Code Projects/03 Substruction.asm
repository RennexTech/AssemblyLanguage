.MODEL SMALL
.STACK 100H
.CODE
   MAIN PROC
      MOV AH, 1        ; take the first input
      INT 21H
      MOV BL, AL       ; put it in BL
      
      MOV AH, 1        ; take second input
      INT 21H
      
      SUB BL, AL       ; SUB operation
      ADD BL, 48       ; add 48 to fix ascii value
      
      MOV AH, 2        ; display BL
      MOV DL, BL
      INT 21H         
      
      EXIT:
         MOV AH, 4CH   ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN