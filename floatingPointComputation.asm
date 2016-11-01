%include "along64.inc"
					default  rel

;
; Floating Point Computation
; AX^2 + BX + C = 0
; Compute X
; X = (-b +- sqrt(b^2 - 4ac))/2a
; sqrtsd, addsd, subsd, mulsd, divsd
;

; Author         : Andrea Beam
; Class          : CS 330
; Description    : Programming Assignment 5

section .data

Zero			dq				0

Two       dq				2.0

Four      dq        4.0

msg1      db    "Enter the first value (A): ", 0

msg2      db    "Enter the second value (B): ", 0

msg3      db    "Enter the third value (C): ", 0

msg4      db    "Error. Denominator cannot equal '0'. ", 0

msg5      db    "The first possible solution (addition) is: ",0

msg6      db    "The second possible solution (subtraction) is: ", 0

section .text

global main

main:

					mov     rdx, msg1				 ; puts msg1 into rdx
					call    WriteString			 ; prints msg1
					call    ReadFloat				 ; reads in Floating point Number (FPN)

					mov 		rax, Zero        ; moves 0 into rax
					COMISD  xmm0 , [rax]     ; compares with Zero
					je      ERROR						 ; if Zero: Jumps to Error
					movq    xmm5, [rax]      ; Zeros out xmm5
					movq    xmm1, xmm0       ; moves A into xmm1

					mov     rax, Two				 ; moves 2 to rax
					movq    xmm2, [rax]      ; moves address rax into xmm2
					mulsd   xmm2, xmm1			 ; multiplies by 2 (2A)
					movq    xmm3, xmm2       ; moves 2A into xmm3

				  mov     rdx, msg2				 ; puts msg2 into rdx
					call    WriteString			 ; prints msg2
					call    ReadFloat				 ; reads in FPN

					movq    xmm6, xmm0       ; moves B into xmm6
					mulsd   xmm6, xmm6       ; squares B in xmm6
					subsd   xmm5, xmm0       ; creats -B in xmm5
					movq    xmm4, xmm5       ; moves B into xmm4

					mov     rdx, msg3				 ; puts ms3 into rdx
					call    WriteString			 ; prints msg3
					call    ReadFloat				 ; reads in FPN

					movq    xmm7, xmm0       ; moves C into xmm7
					mov     rax, Four        ; moves 4 into rax
					movq    xmm0, [rax]      ; moves that address into xmm0
					mulsd   xmm7, xmm1       ; multiplies A & C
					mulsd   xmm7, xmm0       ; multiplies solution of A*C with 4
					subsd   xmm6, xmm7       ; subtracts 4AC from B^2
					sqrtsd  xmm8, xmm6       ; put the sqrt of that solution into xmm8

					addsd   xmm4, xmm8       ; adds xmm8 to -B
					subsd   xmm5, xmm8       ; Subtracts xmm8 from -B

					divsd   xmm4, xmm2       ; Divides xmm4 by 2A
					divsd   xmm5, xmm2       ; Divides xmm5 by 2a

					movq    xmm0, xmm4       ; moves addition solution to xmm0
					mov			rdx, msg5				 ; moves msg5 into rdx
					call 		WriteString			 ; prints out msg5
					call    WriteFloat			 ; prints out Float solution
					call    Crlf             ; Goes to next line

					movq    xmm0, xmm5       ; moves subtraction solution to xmm0
					mov			rdx, msg6				 ; moves msg6 into rdx
					call 		WriteString			 ; prints out msg5
					call    WriteFloat			 ; prints out Float solution
					call    Crlf             ; Goes to next line

					call    END					  	 ; calls END when done

ERROR:
					mov    rdx, msg4         ; moves msg3 into rdx
					call   WriteString       ; prints out msg3
					call   Crlf              ; goes to next line

END:
					call   Crlf              ; goes to next line
					call   ExitProc          ; terminates program
