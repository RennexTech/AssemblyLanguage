;============================================================
; Program: BinarySortTest.asm
; Purpose: Demonstrates Bubble Sort and Binary Search on an 
;          array of signed integers. Includes detailed 
;          comments explaining each step.
;============================================================

INCLUDE Irvine32.inc
INCLUDE BinarySearch.inc  ; Binary search procedure

LOWVAL = -5000
HIGHVAL = +5000
ARRAY_SIZE = 50

.data
; Array to hold random integers
array DWORD ARRAY_SIZE DUP(?)

.code
main PROC
    ;-----------------------------
    ; Initialize random number generator
    ;-----------------------------
    call Randomize

    ;-----------------------------
    ; Fill array with random integers
    ;-----------------------------
    INVOKE FillArray, ADDR array, ARRAY_SIZE, LOWVAL, HIGHVAL

    ;-----------------------------
    ; Display unsorted array
    ;-----------------------------
    INVOKE PrintArray, ADDR array, ARRAY_SIZE
    call WaitMsg

    ;-----------------------------
    ; Sort array using Bubble Sort
    ;-----------------------------
    INVOKE BubbleSort, ADDR array, ARRAY_SIZE

    ;-----------------------------
    ; Display sorted array
    ;-----------------------------
    INVOKE PrintArray, ADDR array, ARRAY_SIZE

    ;-----------------------------
    ; Ask user for value to search
    ;-----------------------------
    call AskForSearchVal

    ;-----------------------------
    ; Perform binary search
    ; Returns index in EAX, or -1 if not found
    ;-----------------------------
    INVOKE BinarySearch, ADDR array, ARRAY_SIZE, eax

    ;-----------------------------
    ; Display search results
    ;-----------------------------
    call ShowResults

    exit
main ENDP

;============================================================
; AskForSearchVal
; Prompts the user to input a signed integer and returns it in EAX
;============================================================
AskForSearchVal PROC
    .data
    prompt BYTE "Enter a signed decimal integer in the range of -5000 to +5000 to find in the array: ",0
    .code
    call Crlf
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt      ; Value returned in EAX
    ret
AskForSearchVal ENDP

;============================================================
; ShowResults
; Displays the outcome of the binary search:
; - If value found: prints the array position
; - If not found: prints "The value was not found"
;============================================================
ShowResults PROC
    .data
    msg1 BYTE "The value was not found.",0
    msg2 BYTE "The value was found at position ",0
    .code
    .IF eax == -1
        mov edx, OFFSET msg1
        call WriteString
    .ELSE
        mov edx, OFFSET msg2
        call WriteString
        call WriteDec
    .ENDIF
    call Crlf
    call Crlf
    ret
ShowResults ENDP
