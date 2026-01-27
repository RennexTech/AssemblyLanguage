;----------------------------------------------------
; ArraySum: Calculates sum of a DWORD array
; Parameters:
;   ptrArray  - pointer to array
;   arraySize - number of elements
; Returns: EAX = sum
;----------------------------------------------------
INCLUDE Irvine32.inc
.code
ArraySum PROC
    ptrArray  EQU [ebp+8]
    arraySize EQU [ebp+12]

    enter 0,0
    push ecx
    push esi

    mov eax,0              ; initialize sum
    mov esi,ptrArray
    mov ecx,arraySize
    cmp ecx,0
    jle DoneSum            ; exit if array empty

SumLoop:
    add eax,[esi]          ; add current element
    add esi,4              ; move to next element
    loop SumLoop

DoneSum:
    pop esi
    pop ecx
    leave
    ret 8
ArraySum ENDP
END
