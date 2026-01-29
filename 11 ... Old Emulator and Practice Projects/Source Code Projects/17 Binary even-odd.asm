.MODEL SMALL
.STACK 100H
.DATA
   BIT DW 8
   STR DB '0'
   MSG1 DB 'Enter an 8-bit binary number: $'
   MSG2 DB 10, 13, 'Not a valid 8-bit binary! $' 
   MSG3 DB 'Even $'
   MSG4 DB 'Odd $'

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
                   
      TEST STR[7], 1       ; TEST operation on LSB
      JNZ ODD
      JMP EVEN

      EVEN:
         MOV AH, 9         ; display MSG3
         LEA DX, MSG3
         INT 21h
         JMP EXIT      
      
      ODD:
         MOV AH, 9         ; display MSG4
         LEA DX, MSG4
         INT 21h
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