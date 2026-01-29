.MODEL SMALL 
.STACK 100H 
.CODE
   MAIN PROC     
      MOV AH, 1          ; take an input
      INT 21H   
      
      MOV CX, 50         ; set counter register to 50
      MOV AH, 2          ; set AH to char output
      MOV DL, AL         ; put AL in DL
      
      LOOP1:
         INT 21H         ; display AL (the input)
         DEC CX          ; decrement cx
         JNZ LOOP1       
      
      EXIT: 
         MOV AH, 4CH     ; return control to DOS 
         INT 21H 
   MAIN ENDP 
END MAIN 
