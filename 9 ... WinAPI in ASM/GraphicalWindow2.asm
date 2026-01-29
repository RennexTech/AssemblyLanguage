;------------------------------------------------------------
; Simple Windows Application in MASM
; Demonstrates:
; - RECT, MSG, WNDCLASS structures
; - WinMain and WinProc procedures
; - MessageBox usage on left mouse click
;------------------------------------------------------------

include "windows.inc"
include "kernel32.inc"
include "user32.inc"
includelib "kernel32.lib"
includelib "user32.lib"

.data
;----------------------------------------
; Window Class Name
;----------------------------------------
className db "MyWinClass", 0

;----------------------------------------
; Message Strings
;----------------------------------------
msgText db "Hello, this is a message box!", 0
msgCaption db "MessageBox Example", 0

;----------------------------------------
; Application Instance and Window Handle
;----------------------------------------
hInstance HANDLE ?
hWnd HANDLE ?

;----------------------------------------
; MSG structure for message loop
;----------------------------------------
msg MSG <>

;----------------------------------------
; Rectangle structure (for reference)
;----------------------------------------
; RECT struct example
myRect RECT <0,0,500,300>  ; left=0, top=0, right=500, bottom=300

.code

;------------------------------------------------------------
; WinMain Procedure
; Entry point of the Windows application
;------------------------------------------------------------
WinMain PROC
    ;--------------------------------------------------------
    ; Save the program instance handle
    ;--------------------------------------------------------
    invoke GetModuleHandle, NULL
    mov hInstance, eax

    ;--------------------------------------------------------
    ; Fill out WNDCLASS structure
    ;--------------------------------------------------------
    LOCAL wc:WNDCLASS
    mov wc.style, CS_HREDRAW or CS_VREDRAW    ; Window redraw style
    mov wc.lpfnWndProc, OFFSET WinProc        ; Pointer to event handler
    mov wc.cbClsExtra, 0                      ; Extra memory for class (none)
    mov wc.cbWndExtra, 0                      ; Extra memory per window (none)
    mov wc.hInstance, hInstance               ; Current program instance
    mov wc.hIcon, NULL                        ; Default icon
    mov wc.hCursor, NULL                      ; Default cursor
    mov wc.hbrBackground, COLOR_WINDOW+1      ; Background color
    mov wc.lpszMenuName, NULL                 ; No menu
    mov wc.lpszClassName, OFFSET className    ; Name of the class

    ;--------------------------------------------------------
    ; Register the window class
    ;--------------------------------------------------------
    invoke RegisterClass, ADDR wc

    ;--------------------------------------------------------
    ; Create the main window
    ;--------------------------------------------------------
    invoke CreateWindowEx, 0, ADDR className, ADDR className, WS_OVERLAPPEDWINDOW, \
                           CW_USEDEFAULT, CW_USEDEFAULT, 500, 300, \
                           NULL, NULL, hInstance, NULL
    mov hWnd, eax

    ;--------------------------------------------------------
    ; Show and update the window
    ;--------------------------------------------------------
    invoke ShowWindow, hWnd, SW_SHOW
    invoke UpdateWindow, hWnd

    ;--------------------------------------------------------
    ; Message loop
    ; Retrieves messages and dispatches them to WinProc
    ;--------------------------------------------------------
messageLoop:
    invoke GetMessage, ADDR msg, NULL, 0, 0
    cmp eax, 0
    je endLoop
    invoke TranslateMessage, ADDR msg
    invoke DispatchMessage, ADDR msg
    jmp messageLoop

endLoop:
    invoke ExitProcess, 0
WinMain ENDP

;------------------------------------------------------------
; WinProc Procedure
; Handles all window messages (mouse, keyboard, paint, etc.)
;------------------------------------------------------------
WinProc PROC hWnd:HANDLE, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    LOCAL retVal:DWORD

    cmp uMsg, WM_LBUTTONDOWN       ; Check if left mouse button was clicked
    jne defaultHandler

    ;--------------------------------------------------------
    ; Display a message box on left click
    ;--------------------------------------------------------
    invoke MessageBox, hWnd, ADDR msgText, ADDR msgCaption, MB_OK
    mov eax, 0
    ret

defaultHandler:
    ; Call default handler for messages we don't process
    invoke DefWindowProc, hWnd, uMsg, wParam, lParam
    ret
WinProc ENDP

END WinMain
