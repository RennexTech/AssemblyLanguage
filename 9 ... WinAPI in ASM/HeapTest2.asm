; Title: HeapTest2.asm
; Description: This program demonstrates dynamic memory allocation using a custom heap.
; It allocates 0.5MB blocks repeatedly (up to 2000 times) until the 400MB limit 
; is reached or the loop completes. It showcases HeapCreate, HeapAlloc, and HeapDestroy.

INCLUDE Irvine32.inc

; =========================================================================================
; DATA SECTION
; The .data directive declares constants and variables for heap management.
; =========================================================================================
.data
HEAP_START = 2000000          ; Initial heap size (2 MB)
HEAP_MAX   = 400000000        ; Maximum heap size limit (400 MB)
BLOCK_SIZE = 500000           ; Size of each memory block to allocate (0.5 MB)

hHeap HANDLE ?                ; Variable to store the handle to the custom heap
pData DWORD  ?                ; Variable to hold the pointer to the most recently allocated block

; Error message string for allocation failure
str1 BYTE 0dh, 0ah, "Memory allocation failed", 0dh, 0ah, 0

; =========================================================================================
; CODE SECTION
; Contains the main logic and helper procedures.
; =========================================================================================
.code
main PROC
    ; --- Step 1: Create a new custom heap ---
    ; HeapCreate returns a handle in EAX. Parameters: (flags, initial size, max size)
    INVOKE HeapCreate, 0, HEAP_START, HEAP_MAX
    
    .IF eax == NULL
        ; If EAX is NULL, heap creation failed. 
        ; WriteWindowsMsg displays the system error message.
        call WriteWindowsMsg
        call Crlf
        jmp quit
    .ELSE
        ; Success: Store the handle returned in EAX for future use.
        mov hHeap, eax
    .ENDIF

    ; --- Step 2: Loop to repeatedly allocate memory blocks ---
    ; We aim to allocate up to 2000 blocks to test the 400MB heap limit.
    mov ecx, 2000             ; Set loop counter

L1:
    call allocate_block       ; Attempt to allocate one block
    
    ; Check the Carry Flag (CF). allocate_block sets CF=1 on failure.
    .IF Carry?
        ; Allocation failed: Display error and exit loop
        mov edx, OFFSET str1
        call WriteString
        jmp quit
    .ELSE
        ; Allocation successful: Show progress by printing a dot
        mov al, '.'
        call WriteChar
    .ENDIF
    
    loop L1                   ; Repeat until ECX = 0

quit:
    ; --- Step 3: Cleanup and Destroy the Heap ---
    ; It is vital to destroy the heap to free system resources.
    INVOKE HeapDestroy, hHeap
    
    .IF eax == NULL           ; HeapDestroy returns NULL (0) if it fails
        call WriteWindowsMsg
        call Crlf
    .ENDIF

    exit
main ENDP

; -----------------------------------------------------------------------------------------
; allocate_block PROC
; Logic: Uses HeapAlloc to request memory from our custom heap.
; Returns: CF = 0 if success (EAX = pointer), CF = 1 if failure.
; -----------------------------------------------------------------------------------------
allocate_block PROC USES ecx
    ; HEAP_ZERO_MEMORY: Forces the allocated block to be filled with zeros.
    INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, BLOCK_SIZE
    
    .IF eax == NULL
        stc                   ; Set Carry Flag (CF=1) to indicate failure
    .ELSE
        mov pData, eax        ; Save the pointer to the allocated memory
        clc                   ; Clear Carry Flag (CF=0) to indicate success
    .ENDIF
    
    ret
allocate_block ENDP

; -----------------------------------------------------------------------------------------
; free_block PROC
; Logic: Frees the single block pointed to by pData.
; Note: In the loop above, we only track the latest block in pData.
; -----------------------------------------------------------------------------------------
free_block PROC USES ecx
    INVOKE HeapFree, hHeap, 0, pData
    ret
free_block ENDP

END main