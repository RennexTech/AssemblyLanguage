.MODEL SMALL
.STACK 100H
.DATA
   BIT DW 8
   STR DB '0'
   MSG1 DB 'Enter a binary number: $'
   MSG2 DB 10, 13, 'Not a valid 8-bit binary! $'

.CODE
   MAIN PROC
      MOV AX, @data        ; initialize DS
      MOV DS, AX 

      MOV SI, 0            ; used as input/output index
      MOV CX, BIT          ; size of string

      MOV AH, 9            ; display MSG1
      LEA DX, MSG1
      INT 21h      
      MOV AH, 1            ; set AH to chat input

      INPUT:
         INT 21H
         MOV STR[SI], AL   ; put AL in STR[SI]
         CMP AL, '1'       ; check if AL greater than '1' (not binary)
         JG INVALID_BINARY 
         CMP AL, 13        ; check if the input is 'cret'
         JE INVALID_BINARY
         INC SI            ; increase SI for the next input 
         LOOP INPUT
         JMP NEW_LINE

      NEW_LINE:
         MOV AH, 2         ; display new line
         MOV DL, 10
         INT 21H
         MOV DL, 13
         INT 21H
      
      MOV SI, 0            ; to use SI as display index
      MOV CX, BIT          ; reset CX
      JMP DISPLAY

      DISPLAY:
         MOV DL, STR[SI]   ; display the input
         INT 21H
         INC SI
         LOOP DISPLAY
         JMP EXIT

      INVALID_BINARY:
         MOV AH, 9         ; display MSG2
         LEA DX, MSG2
         INT 21h

      EXIT:
         MOV AH, 4CH       ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN