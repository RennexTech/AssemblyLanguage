;----------------------------------------------------
; DisplaySum: Displays a sum on the console
; Parameters:
;   ptrPrompt - pointer to prompt string
;   theSum    - sum value (DWORD)
; Returns: nothing
;----------------------------------------------------
INCLUDE Irvine32.inc
.code
DisplaySum PROC
    ptrPrompt EQU [ebp+8]
    theSum    EQU [ebp+12]

    enter 0,0
    push eax
    push edx

    mov edx,ptrPrompt
    call WriteString       ; display prompt
    mov eax,theSum
    call WriteInt          ; display sum
    call Crlf              ; new line

    pop edx
    pop eax
    leave
    ret 8
DisplaySum ENDP
END
