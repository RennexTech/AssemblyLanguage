INCLUDE Irvine32.inc

.data
; Strings to manipulate
string_1 BYTE "abcde////", 0
string_2 BYTE "ABCDE", 0
copy_string BYTE 20 DUP(0) ; buffer for Str_copy example

; Messages for output
msg_trim   BYTE "string_1 after trimming: ", 0
msg_upper  BYTE "string_1 in upper case: ", 0
msg_equal  BYTE "string_1 and string_2 are equal", 0
msg_less   BYTE "string_1 is less than string_2", 0
msg_greater BYTE "string_2 is less than string_1", 0
msg_length BYTE "Length of string_2 is ", 0
msg_copy   BYTE "Copy of string_2 is: ", 0

.code
main PROC
    ; ---------------------------
    ; Trim string_1
    ; ---------------------------
    call trim_string

    ; ---------------------------
    ; Convert string_1 to uppercase
    ; ---------------------------
    call upper_case

    ; ---------------------------
    ; Compare string_1 and string_2
    ; ---------------------------
    call compare_strings

    ; ---------------------------
    ; Display length of string_2
    ; ---------------------------
    call print_length

    ; ---------------------------
    ; Copy string_2 to copy_string
    ; ---------------------------
    call copy_string_demo

    exit
main ENDP

; ---------------------------
; Trim trailing characters from string_1
; ---------------------------
trim_string PROC
    INVOKE Str_trim, ADDR string_1, '/'
    mov edx, OFFSET msg_trim
    call WriteString
    mov edx, OFFSET string_1
    call WriteString
    call Crlf
    ret
trim_string ENDP

; ---------------------------
; Convert string_1 to uppercase
; ---------------------------
upper_case PROC
    mov edx, OFFSET msg_upper
    call WriteString
    INVOKE Str_ucase, ADDR string_1
    mov edx, OFFSET string_1
    call WriteString
    call Crlf
    ret
upper_case ENDP

; ---------------------------
; Compare string_1 to string_2
; ---------------------------
compare_strings PROC
    INVOKE Str_compare, ADDR string_1, ADDR string_2
    .IF ZERO?
        mov edx, OFFSET msg_equal
    .ELSEIF CARRY?
        mov edx, OFFSET msg_less
    .ELSE
        mov edx, OFFSET msg_greater
    .ENDIF
    call WriteString
    call Crlf
    ret
compare_strings ENDP

; ---------------------------
; Display length of string_2
; ---------------------------
print_length PROC
    mov edx, OFFSET msg_length
    call WriteString
    INVOKE Str_length, ADDR string_2
    call WriteDec
    call Crlf
    ret
print_length ENDP

; ---------------------------
; Copy string_2 to copy_string
; ---------------------------
copy_string_demo PROC
    mov edx, OFFSET msg_copy
    call WriteString
    INVOKE Str_copy, ADDR string_2, ADDR copy_string
    mov edx, OFFSET copy_string
    call WriteString
    call Crlf
    ret
copy_string_demo ENDP

END main
