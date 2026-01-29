.MODEL SMALL
.STACK 100H
.DATA
   STR DB '0'
   MSG1 DB 'Enter a string: $'
      
.CODE
   MAIN PROC
      MOV AX, @data        ; initialize DS
      MOV DS, AX      
           
      MOV SI, 0            ; input index
      MOV CX, 0            ; size of string
      
      MOV AH, 9            ; display MSG1
      LEA DX, MSG1
      INT 21h      
      MOV AH, 1            ; set AH to chat input
            
      INPUT:
         INT 21H
         MOV STR[SI], AL   ; put AL in STR[SI]
         INC CX
         CMP AL, 13        ; check if the input is 'cret'
         JE NEW_LINE
         INC SI            ; increase SI for the next input 
         JMP INPUT
         
      NEW_LINE:
         MOV AH, 2         ; display new line
         MOV DL, 10
         INT 21H
         MOV DL, 13
         INT 21H
      
      DEC CX            ; since we have 'cret' in the last input  
      MOV SI, 0         ; to use SI as display index
      JMP DISPLAY
         
      DISPLAY:
         MOV DL, STR[SI]   ; display the input
         INT 21H
         INC SI
         LOOP DISPLAY
         
      EXIT:
         MOV AH, 4CH       ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN