.MODEL SMALL
.STACK 100H
.DATA
   MSG1 DB 'Enter a string to be displayed in reverse order:', 10, 13, '$'
   NEW_LINE DB 10, 13, '$'
      
.CODE
   MAIN PROC
      MOV AX, @data       ; initialize DS
      MOV DS, AX
      
      MOV AH, 9           ; display MSG1
      LEA DX, MSG1
      INT 21h
      
      MOV AH, 1           ; set AH to char input
      MOV DX, 0           ; put 0 in DX
      MOV CX, 0           ; size of string
      
      INPUT:
         INT 21H
         MOV DL, AL       ; put AL in DL
         INC CX           ; increase size of the string
         PUSH DX          ; push DL into DX
         CMP DL, 13       ; check if the input is 'cret'
         JNE INPUT
         
      MOV AH, 9           ; display NEW_LINE
      LEA DX, NEW_LINE  
      INT 21H
      MOV AH, 2           ; set AL to single char output
      
      OUTPUT:
         POP DX           ; pop DX (and put the top element in DL)
         INT 21H          ; display DL
         LOOP OUTPUT
         
      EXIT:
         MOV AH, 4CH      ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN