; Demonstrate GetLastError and FormatMessage (ErrorHandling.asm)
; Displays the most recent Windows API error as a string
INCLUDE Irvine32.inc

.data
    ; Strings for formatting error output
    WriteWindowsMsg_1 BYTE "Error ",0
    WriteWindowsMsg_2 BYTE ": ",0

    ; Variables to store error info
    messageId   DWORD ?      ; Stores the numeric error code
    pErrorMsg   DWORD ?      ; Pointer to the formatted error message

.code
; ---------------------------------------------------------
; Procedure: WriteWindowsMsg
; Purpose:   Display the most recent Windows API error
; Usage:     No parameters needed; returns nothing
; ---------------------------------------------------------
WriteWindowsMsg PROC USES eax edx
    ; ----- Step 1: Get the most recent error code -----
    call GetLastError
    mov messageId, eax          ; Save error code

    ; ----- Step 2: Display the error number -----
    ; Output "Error "
    mov edx, OFFSET WriteWindowsMsg_1
    call WriteString
    ; Output the numeric error code
    mov eax, messageId
    call WriteDec
    ; Output ": "
    mov edx, OFFSET WriteWindowsMsg_2
    call WriteString

    ; ----- Step 3: Retrieve the human-readable error message -----
    ; FormatMessage will allocate memory automatically for pErrorMsg
    INVOKE FormatMessage, FORMAT_MESSAGE_ALLOCATE_BUFFER + FORMAT_MESSAGE_FROM_SYSTEM, _
                         NULL, messageId, 0, ADDR pErrorMsg, 0, 0

    ; ----- Step 4: Display the error message -----
    mov edx, pErrorMsg
    call WriteString

    ; ----- Step 5: Free the memory allocated by FormatMessage -----
    INVOKE LocalFree, pErrorMsg

    ret
WriteWindowsMsg ENDP

; ---------------------------------------------------------
; Example usage of WriteWindowsMsg procedure
; ---------------------------------------------------------
main PROC
    ; Example: force an error by passing invalid parameters
    INVOKE GetStdHandle, -1            ; Invalid handle to force an error
    cmp eax, NULL
    jne noError                        ; If no error, skip

    ; Call our procedure to display the error
    call WriteWindowsMsg

noError:
    exit
main ENDP

END main
