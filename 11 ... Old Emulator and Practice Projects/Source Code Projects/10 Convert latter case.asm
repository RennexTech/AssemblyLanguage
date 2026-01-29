.MODEL SMALL
.STACK 100H 
.DATA
   MSG1 DB 'Input a char in Lower case: $'
   MSG2 DB 10, 13, 'Input a char in Upper case: $'

.CODE
   MAIN PROC      
      ; UPPER-> SUB 32, LOWER-> ADD 32
      
      MOV AX, @data    ; initialize DS
      MOV DS, AX         
      
      MOV AH, 9        ; print MSG1
      LEA DX, MSG1  
      INT 21h
      
      MOV AH, 1        ; take input
      INT 21H

      SUB AL, 32       ; SUB 32 to get the upper case
      MOV AH, 2        ; display
      MOV DL, AL
      INT 21H 
      
      MOV AH, 9        ; print MSG2
      LEA DX, MSG2  
      INT 21h
      
      MOV AH, 1        ; take input
      INT 21H
      
      ADD AL, 32       ; ADD 32 to get the lower case
      MOV AH, 2        ; display
      MOV DL, AL
      INT 21H
      
      EXIT:
         MOV AH, 4CH   ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN