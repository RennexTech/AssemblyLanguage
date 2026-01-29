.MODEL SMALL
.STACK 100H
.DATA
   MSG1 DB 'Hello World $'
   MSG2 DB ?

.CODE
   MAIN PROC
      ; AH, 1 -> single character input
      ; AH, 2 -> single character output
      ; AH, 9 -> string output
      
      MOV AH, 1       ; single char input
      INT 21H
      
      MOV AH, 2       ; single char output
      MOV DL, AL
      INT 21H
      
      MOV AL, MSG2    ; store the input in MSG2
      
      MOV AH, 2       ; display new line
      MOV DL, 10
      INT 21h
      MOV DL, 13
      INT 21h
      
      MOV AX, @data   ; initialize DS
      MOV DS, AX
      
      MOV AH, 9       ; display MSG1 (String output)
      LEA DX, MSG1
      INT 21h
      
      EXIT:
         MOV AH, 4CH  ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN