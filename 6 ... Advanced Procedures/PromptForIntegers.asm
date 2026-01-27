;----------------------------------------------------
; PromptForIntegers: Prompts user for an array of integers
; Parameters:
;   ptrPrompt - pointer to prompt string
;   ptrArray  - pointer to array of DWORDs
;   arraySize - number of integers
; Returns: nothing (array filled with user input)
;----------------------------------------------------
INCLUDE Irvine32.inc
.code
PromptForIntegers PROC
    ; Stack frame aliases
    ptrPrompt EQU [ebp+8]
    ptrArray  EQU [ebp+12]
    arraySize EQU [ebp+16]

    enter 0,0
    pushad                ; save all registers

    mov ecx,arraySize
    cmp ecx,0
    jle DonePrompt         ; exit if array size is zero

    mov edx,ptrPrompt
    mov esi,ptrArray

ReadLoop:
    call WriteString       ; display prompt
    call ReadInt           ; read integer into EAX
    call Crlf              ; new line
    mov [esi],eax          ; store in array
    add esi,4              ; next integer
    loop ReadLoop

DonePrompt:
    popad
    leave
    ret 12                 ; clean up stack
PromptForIntegers ENDP
END
