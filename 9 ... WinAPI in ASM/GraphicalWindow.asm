include "graphwin.inc"

.data
className db "WinApp", 0      ; Name of the window class
instance HANDLE               ; Handle to the application instance
window HANDLE                 ; Handle to the main window
msg MSG                       ; Message structure for the message loop

.code
start:
    ;------------------------------------------------------------
    ; Register the window class
    ; This step is required to define the characteristics of the window.
    ; The class includes the name, cursor, background, and event handler.
    ;------------------------------------------------------------
    invoke RegClassEx, addr className

    ;------------------------------------------------------------
    ; Create the main window
    ; Parameters:
    ;   0                : Extended window style
    ;   addr className   : Name of the registered window class
    ;   addr className   : Window title
    ;   WS_OVERLAPPEDWINDOW : Standard overlapped window style
    ;   0, 0             : Initial x and y position (0 = default)
    ;   CW_USEDEFAULT    : Default width
    ;   CW_USEDEFAULT    : Default height
    ;   HWND_DESKTOP     : Parent window (desktop)
    ;   0                : Menu handle (none)
    ;   instance         : Handle to application instance
    ;   0                : Additional parameters (none)
    ;------------------------------------------------------------
    invoke CreateWindowEx, 0, addr className, addr className, WS_OVERLAPPEDWINDOW, 0, 0, CW_USEDEFAULT, CW_USEDEFAULT, HWND_DESKTOP, 0, instance, 0
    mov window, eax            ; Store the handle to the main window

    ;------------------------------------------------------------
    ; Show the main window
    ; SW_SHOW makes the window visible on the screen.
    ;------------------------------------------------------------
    invoke ShowWindow, window, SW_SHOW

    ;------------------------------------------------------------
    ; Message loop
    ; This loop retrieves messages from the message queue, 
    ; translates them (for keyboard input), and dispatches them 
    ; to the window procedure.
    ;------------------------------------------------------------
messageLoop:
    invoke GetMessage, addr msg, 0, 0, 0  ; Retrieve next message
    cmp eax, -1                           ; Check for error
    je end                                ; Exit loop if error

    ; Translate virtual-key messages to character messages
    invoke TranslateMessage, addr msg

    ; Send message to the window procedure for handling
    invoke DispatchMessage, addr msg

    jmp messageLoop                        ; Repeat loop

end:
    ; Exit the program
    invoke ExitProcess, 0

;------------------------------------------------------------
; NOTES:
; 1. This program creates a simple window titled "WinApp".
; 2. The window is centered on the desktop and has standard overlapped window style.
; 3. Mouse events can be handled by defining a window procedure in graphwin.inc.
; 4. Clicking the left mouse button can trigger a MessageBox (if handled in window proc).
; 5. To build:
;    - Create a MASM project in Visual Studio.
;    - Add WinApp.asm and GraphWin.inc.
;    - Link kernel32.lib and user32.lib.
;    - Set subsystem to Windows (/SUBSYSTEM:WINDOWS).
; 6. Running the program will display a simple window with title "WinApp".
;------------------------------------------------------------
