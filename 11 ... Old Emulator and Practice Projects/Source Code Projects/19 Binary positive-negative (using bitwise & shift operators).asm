.MODEL SMALL 
.STACK 100H
.DATA
   MSG1 DB 'Enter a 16-bit binary: ', 10, 13, '$'
   MSG2 DB 10, 13, 'Invalid binary input. $' 
   MSG3 DB 10, 13, 'Positive $'
   MSG4 DB 10, 13, 'Negative $'  

.CODE     
   MAIN PROC
      MOV AX, @DATA          ; initialize DS
      MOV DS, AX
      
      MOV AH, 9              ; display MSG1
      LEA DX, MSG1
      INT 21h
      
      XOR BX, BX             ; 0 in BX
      MOV CX, 15             ; input size
      MOV AH, 1              ; set single chat input
      INT 21H
      
      INPUT:
         CMP AL, '1'         ; check if AL greater than '1' (not binary)
         JG INVALID_BINARY 
         CMP AL, 13          ; check if the input is 'cret'
         JE INVALID_BINARY
         
         AND AL, 0FH         ; bitwise AND operation
         SHL BX, 1           ; shift left operation
         OR BL, AL           ; bitwise OR operation
         INT 21H
         LOOP INPUT          ; jump to WHILE
      
      MOV AH, 9              ; set string output 
      ROL BX, 2              ; ROL operation on BX
      JC NEGATIVE            ; jump to NEGATIVE if carray
      JMP POSITIVE           ; otherwise jump to POSITIVE
      
      POSITIVE: 
         LEA DX, MSG3        ; display MSG3
         INT 21h
         JMP EXIT
         
      NEGATIVE:  
         LEA DX, MSG4        ; display MSG4
         INT 21h
         JMP EXIT
      
      INVALID_BINARY:
         MOV AH, 9           ; display MSG2
         LEA DX, MSG2
         INT 21h
         JMP EXIT
      
      EXIT:
         MOV AH, 4CH        ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN