.MODEL SMALL 
.STACK 100H
.DATA
   MSG1 DB 'Enter 2 characters: $'
   MSG2 DB 'Thank You $'
   NEW_LINE DB 10, 13, '$'    

.CODE     
   MAIN PROC
      MOV AX, @DATA         ; initialize DS
      MOV DS, AX
      
      MOV AH, 9             ; display MSG1
      LEA DX, MSG1
      INT 21H
      
      MOV AH, 1             ; set single char output function
      INT 21H               ; take the first input 
      MOV BL, AL            ; put it in BL      
      INT 21H               ; take the second input
      MOV CL, AL            ; put it in CL
      
      CMP BL, CL            ; compare the inputs
      JG IF                 ; jump to IF if greater (means to check if 
                            ; BL comes after CL in alphabetical order)
      JMP DISPLAY           ; otherwise jump to DISPLAY
      
      IF:
         XCHG BL, CL        ; swap BL and CL values
         JMP DISPLAY        ; jump to DISPLAY
      
      DISPLAY:
         MOV AH, 9          ; display NEW_LINE
         LEA DX, NEW_LINE  
         INT 21H
         
         MOV AH, 2          ; set single char output function
         MOV DL, BL         ; display BL
         INT 21H         
         MOV DL, CL         ; display CL
         INT 21H                     
         JMP EXIT           ; jump to EXIT
      
      EXIT:
         MOV AH, 4CH        ; return control to DOS
         INT 21H
   MAIN ENDP
END MAIN