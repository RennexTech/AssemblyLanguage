; Finite State Machine (Finite.asm)
INCLUDE Irvine32.inc

ENTER_KEY = 13         ; ASCII value for Enter key

.data
InvalidInputMsg: db "Invalid input", 13, 10, 0   ; Error message

.code
main:
    ; Clear screen
    call Clrscr

    ; Start state
StateA:
        ; Read next character into AL
        call Getnext

        ; Check for leading + or - sign
        cmp al, '+'
        je StateB
        cmp al, '-'
        je StateB

        ; Check if AL contains a digit
        call IsDigit
        jz StateC

        ; Invalid input
        call DisplayErrorMsg
        jmp Quit

StateB:
        ; Read next character into AL
        call Getnext

        ; Check if AL contains a digit
        call IsDigit
        jz StateC

        ; Invalid input
        call DisplayErrorMsg
        jmp Quit

StateC:
        ; Read next character into AL
        call Getnext

        ; Check if AL contains a digit
        call IsDigit
        jz StateC

        ; Check if Enter key pressed
        cmp al, ENTER_KEY
        je Quit

        ; Invalid input
        call DisplayErrorMsg
        jmp Quit

Quit:
        ; Call Crlf to print a newline
        call Crlf
        exit

; Getnext procedure
; Reads a character from standard input
; Receives: nothing
; Returns: AL contains the character
Getnext:
        ; Input from keyboard
        call ReadChar

        ; Echo on screen
        call WriteChar

        ret

; DisplayErrorMsg procedure
; Displays an error message indicating that
; the input stream contains illegal input
DisplayErrorMsg:
        ; Push EDX onto the stack
        push edx

        ; Move the offset of the error message to EDX
        mov edx, OFFSET InvalidInputMsg

        ; Call WriteString to print the error message
        call WriteString

        ; Pop EDX from the stack
        pop edx

        ret

; IsDigit procedure
; Checks if the character in AL is a valid digit (0-9)
; Returns: Zero flag is set if the character is a digit, cleared otherwise
IsDigit:
        cmp al, '0'          ; Check if AL >= '0'
        jl NotADigit
        cmp al, '9'          ; Check if AL <= '9'
        jg NotADigit
        ; If AL is between '0' and '9', it's a valid digit
        ret

NotADigit:
        ; If AL is not a valid digit, clear Zero flag
        ret
