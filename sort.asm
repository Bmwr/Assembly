%include "along64.inc"
					default  rel

; Due
;
;
; Bubble sort for assignment 4 ;
; (n-1)                        ;
; swapping 2 numbers           ;
;
;

; Author         : Andrea Beam
; Class          : CS 330
; Description    : Programming Assignment 4
; Creation Date  :
; Turn in Date   :

section .data

msg1      db   "Enter the values of the array.", 10, 13
					db   "Once done entering values, ", 10, 13
					db   "enter a zero to signify the end.", 10, 13, 0

msg3      db   "The sorted Array is: ", 10, 13, 0

msg4      db   "Error! Zeros are to be used for", 10, 13
					db   "signifying the end of the set of values.", 10, 13
					db   "End Program.", 10, 13, 0

arrayp    times 100 dq 0

Count     dq 100

section .text

global main

main:

							call   Clrscr            				; Clears the screen
							mov    rdx, msg1        				; puts msg1 into rdx
							call   WriteString    				  ; prints msg1
							mov    rbx, arrayp     				  ; moves the empty array into rbx
							xor    rcx, rcx          				; sets rcx to 0
							call   DumpRegs

INSERT:
							call   ReadInt          			  ; reads value into rax
							cmp    rax, 0           			  ; compares the value to Zero
							je     CHECKZERO                ; if equal: jumps to CHECKZERO
							mov    [arrayp + rcx*8], rax  	; adds value array
							inc		 rcx											; increments rcx by 1
							cmp    rcx, 99									; compares rcx to 99
							jne    INSERT										; if not equal calls INSERT
CHECKZERO:
							cmp    rcx, 0                   ; compares rcx to 0
							je     ERROR										; if equal jumps to error
							jne    BUBBLESORT								; if not equal : to BUBBLESORT

BUBBLESORT:

							push   rcx											; pushes rcx onto stack
							dec    rcx											; decreases rcx by 1
L1:
							push   rcx											; pushes rcx onto stack
							mov    rsi, arrayp							; puts arrayp address into rsi
L2:
							mov		 rax, [rsi]								; moves the value of rsi to rax
							cmp		 [rsi+8], rax							; compares  two values sidebyside
							jg     L3												;	jumps: value is greater than
							xchg   rax, [rsi+8]							; exchanges the two values
							mov    [rsi], rax								; moves rax into rsi
L3:
							add    rsi, 8										; adds 8 to rsi
							loop   L2												; calls L2

							pop    rcx											; pops rcx from stack
							loop   L1												; calls L1
L4:
							pop    rcx											; pops rcx
							mov    r15, 0										; moves 0 to r15
							mov    rdx, msg3								; moves msg3 to rdx
							call   WriteString							; prints msg3
L5:

							mov    rax, [arrayp + r15*8]		; moves value to rax
							call   WriteInt									; prints out value
							call   Crlf                     ; Goes to next line
							inc    r15											; increments r15
							cmp    rcx, r15									; compares rcx to r15
							je     EXIT											; jumps if equal to EXIT
							jmp    L5												; calls L5

ERROR:
							mov    rdx, msg4				        ; moves msg4 into rdx
							call   WriteString      				; prints out msg4
							call   ExitProc                 ; terminates program

EXIT:
					    call   ExitProc                 ; terminates program
