;=================================================================================
; Combined Windows Application (MASM)
; Programs / Procedures included:
; 1. WinMain           - Main program entry point
; 2. WinProc           - Window procedure (handles events/messages)
; 3. ErrorHandler      - Handles errors in registration or window creation
; 4. MessageBox Demo   - Popup messages on WM_CREATE, WM_LBUTTONDOWN, WM_CLOSE
; 5. Example Window    - Shows greeting message after creation
;=================================================================================

.386
.model flat, STDCALL
INCLUDE windows.inc
INCLUDE kernel32.inc
INCLUDE user32.inc
INCLUDE GraphWin.inc
includelib kernel32.lib
includelib user32.lib

;=================================================================================
; DATA SECTION
;=================================================================================
.data
; Window titles and messages
AppLoadMsgTitle BYTE "Application Loaded",0
AppLoadMsgText  BYTE "This window displays when the WM_CREATE message is received",0
PopupTitle      BYTE "Popup Window",0
PopupText       BYTE "This window was activated by a WM_LBUTTONDOWN message",0
GreetTitle      BYTE "Main Window Active",0
GreetText       BYTE "This window is shown immediately after CreateWindow and UpdateWindow are called.",0
CloseMsg        BYTE "WM_CLOSE message received",0
ErrorTitle      BYTE "Error",0
WindowName      BYTE "ASM Windows App",0
className       BYTE "ASMWin",0

; MSG structure for message loop
msg MSGStruct <>
; Rectangle structure (optional usage)
winRect RECT <>
; Handles for instance and main window
hMainWnd DWORD ?
hInstance DWORD ?

; Define the application's window class structure
MainWin WNDCLASS <NULL,WinProc,NULL,NULL,NULL,NULL,NULL,COLOR_WINDOW,NULL,className>

;=================================================================================
; CODE SECTION
;=================================================================================
.code

;=================================================================================
; WinMain - Program Entry Point
;=================================================================================
WinMain PROC
    ;---------------------------------------------
    ; Get handle to the current program instance
    ;---------------------------------------------
    INVOKE GetModuleHandle, NULL
    mov hInstance, eax
    mov MainWin.hInstance, eax

    ;---------------------------------------------
    ; Load icon and cursor
    ;---------------------------------------------
    INVOKE LoadIcon, NULL, IDI_APPLICATION
    mov MainWin.hIcon, eax
    INVOKE LoadCursor, NULL, IDC_ARROW
    mov MainWin.hCursor, eax

    ;---------------------------------------------
    ; Register window class
    ;---------------------------------------------
    INVOKE RegisterClass, ADDR MainWin
    .IF eax == 0
        call ErrorHandler
        jmp Exit_Program
    .ENDIF

    ;---------------------------------------------
    ; Create the main window
    ;---------------------------------------------
    INVOKE CreateWindowEx, 0, ADDR className, ADDR WindowName, MAIN_WINDOW_STYLE, \
           CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, \
           NULL, NULL, hInstance, NULL
    .IF eax == 0
        call ErrorHandler
        jmp Exit_Program
    .ENDIF
    mov hMainWnd, eax

    ;---------------------------------------------
    ; Show and update window
    ;---------------------------------------------
    INVOKE ShowWindow, hMainWnd, SW_SHOW
    INVOKE UpdateWindow, hMainWnd

    ;---------------------------------------------
    ; Display greeting message box
    ;---------------------------------------------
    INVOKE MessageBox, hMainWnd, ADDR GreetText, ADDR GreetTitle, MB_OK

    ;---------------------------------------------
    ; Message handling loop
    ;---------------------------------------------
Message_Loop:
    INVOKE GetMessage, ADDR msg, NULL, NULL, NULL
    .IF eax == 0
        jmp Exit_Program
    .ENDIF
    INVOKE DispatchMessage, ADDR msg
    jmp Message_Loop

Exit_Program:
    INVOKE ExitProcess, 0
WinMain ENDP

;=================================================================================
; WinProc - Window Procedure
; Handles messages like WM_CREATE, WM_LBUTTONDOWN, WM_CLOSE
;=================================================================================
WinProc PROC hWnd:DWORD, localMsg:DWORD, wParam:DWORD, lParam:DWORD
    mov eax, localMsg

    .IF eax == WM_CREATE
        ; Display message when window is created
        INVOKE MessageBox, hWnd, ADDR AppLoadMsgText, ADDR AppLoadMsgTitle, MB_OK
        jmp WinProcExit

    .ELSEIF eax == WM_LBUTTONDOWN
        ; Display message when left mouse button is clicked
        INVOKE MessageBox, hWnd, ADDR PopupText, ADDR PopupTitle, MB_OK
        jmp WinProcExit

    .ELSEIF eax == WM_CLOSE
        ; Display message on close and quit
        INVOKE MessageBox, hWnd, ADDR CloseMsg, ADDR WindowName, MB_OK
        INVOKE PostQuitMessage, 0
        jmp WinProcExit

    .ELSE
        ; Default handler for all other messages
        INVOKE DefWindowProc, hWnd, localMsg, wParam, lParam
        jmp WinProcExit
    .ENDIF

WinProcExit:
    ret
WinProc ENDP

;=================================================================================
; ErrorHandler - Display system error messages
;=================================================================================
ErrorHandler PROC
    .data
    pErrorMsg DWORD ?
    messageID DWORD ?

    .code
    ; Get system error number
    INVOKE GetLastError
    mov messageID, eax

    ; Retrieve formatted error message
    INVOKE FormatMessage, FORMAT_MESSAGE_ALLOCATE_BUFFER + FORMAT_MESSAGE_FROM_SYSTEM, \
           NULL, messageID, NULL, ADDR pErrorMsg, NULL, NULL

    ; Display error message
    INVOKE MessageBox, NULL, pErrorMsg, ADDR ErrorTitle, MB_ICONERROR + MB_OK

    ; Free allocated memory
    INVOKE LocalFree, pErrorMsg
    ret
ErrorHandler ENDP

END WinMain
