; beroset.asm
;
; This is a primitive operating system.
;
; written on Tue  09-30-1997  by Ed Beroset
;
;**********************************************************************
code segment para public use16 '_CODE'
        .386
        assume cs:code, ds:code, es:code, ss:code
        org 0
Start:
        mov     ax,cs
        mov     ds,ax
        mov     es,ax
        mov     si,offset err_msg
        call    DisplayMsg
spin:
        jmp     spin


;****************************************************************************
; DisplayMsg
;
; displays the ASCIIZ message to the screen using int 10h calls
;
; Entry:
;    ds:si ==> ASCII string
;
; Exit:
;
; Destroyed:
;    none
;
;
;****************************************************************************
DisplayMsg proc
        push    ax bx si
        cld
nextchar:
        lodsb
        or      al,al
        jz      alldone
        mov     bx,0007h
        mov     ah,0eh
        int     10h
        jmp     nextchar
alldone:
        pop     si bx ax
        ret
DisplayMsg endp


err_msg db      "Operating system found and loaded.",0

code ends
        END

