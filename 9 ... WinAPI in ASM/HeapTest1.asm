; Heap Test #1 (Heaptest1.asm)
; ---------------------------------------------------------------------------------
; This program demonstrates dynamic memory allocation and manipulation in the 
; Windows environment using the Irvine32 library. It shows how to allocate 
; memory from the heap, fill it with specific values, and display its contents.
;
; The program follows these steps:
; 1. Obtain a handle to the default process heap (GetProcessHeap).
; 2. Dynamically allocate a block of memory (HeapAlloc).
; 3. Populate the memory block with a constant value (fill_array).
; 4. Display the memory contents in hexadecimal (display_array).
; 5. Release the allocated memory back to the heap (HeapFree).
; ---------------------------------------------------------------------------------

INCLUDE Irvine32.inc

.data
ARRAY_SIZE = 1000            ; Size of the array to be allocated (1000 bytes)
FILL_VAL   EQU 0FFh          ; Hex value used to fill the array (255 decimal)

hHeap  HANDLE ?              ; Handle to the default process heap
pArray DWORD  ?              ; Pointer to the dynamically allocated block of memory

.code
main PROC
    ; -----------------------------------------------------------------------------
    ; Step 1: Obtain a handle to the default heap owned by the current process.
    ; This handle is required for subsequent memory allocation calls.
    ; -----------------------------------------------------------------------------
    INVOKE GetProcessHeap
    
    .IF eax == NULL          ; If obtaining the heap handle fails (returns NULL)
        call WriteWindowsMsg ; Display the system error message
        jmp quit             ; Exit the program
    .ELSE
        mov hHeap, eax       ; Success: store the handle for later use
    .ENDIF

    ; -----------------------------------------------------------------------------
    ; Step 2: Allocate memory for the array by calling the allocate_array procedure.
    ; -----------------------------------------------------------------------------
    call allocate_array
    
    jnc arrayOk              ; If Carry Flag = 0, allocation was successful
    
    ; If allocation failed (CF = 1):
    call WriteWindowsMsg     ; Display error message
    call Crlf
    jmp quit                 ; Terminate

arrayOk:
    ; -----------------------------------------------------------------------------
    ; Step 3: Fill the allocated memory with a specific character (FILL_VAL).
    ; -----------------------------------------------------------------------------
    call fill_array
    
    ; -----------------------------------------------------------------------------
    ; Step 4: Display the contents of the allocated memory in hexadecimal format.
    ; -----------------------------------------------------------------------------
    call display_array
    call Crlf

    ; -----------------------------------------------------------------------------
    ; Step 5: Free the allocated memory to prevent memory leaks.
    ; -----------------------------------------------------------------------------
    INVOKE HeapFree, hHeap, 0, pArray

quit:
    exit                     ; Terminate the program
main ENDP

; ---------------------------------------------------------------------------------
; allocate_array
;
; Dynamically allocates space for the array using HeapAlloc.
; Receives: EAX = handle to the program heap (via global hHeap)
; Returns: CF = 0 if successful (pArray points to memory), CF = 1 if failed.
; ---------------------------------------------------------------------------------
allocate_array PROC USES eax
    INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, ARRAY_SIZE
    
    .IF eax == NULL
        stc                  ; Set Carry Flag to 1 (Failure)
    .ELSE
        mov pArray, eax      ; Save the pointer to the block
        clc                  ; Clear Carry Flag to 0 (Success)
    .ENDIF
    ret
allocate_array ENDP

; ---------------------------------------------------------------------------------
; fill_array
;
; Fills all array positions with a single character (defined by FILL_VAL).
; Receives: nothing (uses global ARRAY_SIZE and pArray)
; Returns: nothing
; ---------------------------------------------------------------------------------
fill_array PROC USES ecx edx esi
    mov ecx, ARRAY_SIZE      ; Initialize loop counter
    mov esi, pArray          ; Point to the start of the allocated array
    
L1:
    mov BYTE PTR [esi], FILL_VAL ; Fill the current byte
    inc esi                  ; Move to the next memory location
    loop L1                  ; Repeat until all bytes are filled
    ret
fill_array ENDP

; ---------------------------------------------------------------------------------
; display_array
;
; Displays the contents of the array in hexadecimal format.
; Receives: nothing (uses global ARRAY_SIZE and pArray)
; Returns: nothing
; ---------------------------------------------------------------------------------
display_array PROC USES eax ebx ecx esi
    mov ecx, ARRAY_SIZE      ; Initialize loop counter
    mov esi, pArray          ; Point to the start of the array
    
L1:
    mov al, [esi]            ; Get a byte from the array
    mov ebx, TYPE BYTE       ; Set formatting type for WriteHexB
    call WriteHexB           ; Display the byte in Hex
    inc esi                  ; Move to next location
    loop L1                  ; Repeat until display is complete
    ret
display_array ENDP

END main