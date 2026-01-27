;----------------------------------------------------
; Main program: Integer Summation
; Calls:
;   PromptForIntegers - get integers from user
;   ArraySum          - calculate sum
;   DisplaySum        - show result
;----------------------------------------------------
INCLUDE Irvine32.inc
INCLUDE macros.asm      ; For INVOKE & PROTO

EXTERN PromptForIntegers:PROC
EXTERN ArraySum:PROC
EXTERN DisplaySum:PROC

Count = 3               ; size of array

.data
prompt1 BYTE "Enter a signed integer: ",0
prompt2 BYTE "The sum of the integers is: ",0
array   DWORD Count DUP(?)
sum     DWORD ?

.code
main PROC
    call Clrscr
    INVOKE PromptForIntegers, ADDR prompt1, ADDR array, Count
    INVOKE ArraySum, ADDR array, Count
    mov sum, eax
    INVOKE DisplaySum, ADDR prompt2, sum
    call Crlf
    exit
main ENDP
END main
