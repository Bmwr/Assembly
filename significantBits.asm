%include "along64.inc"
					default  rel

; Reads in a Hexadecimal Number
; Prints out the LSB, MSB,
; and the number of 1 bits

; Author         : Andrea Beam
; Class          : CS 330
; Description    : Programming Assignment 3

section .data

msg1      db   "Enter the Hexadecimal.", 10, 13, 0

msg2      db   "The LSB is: ", 0

msg3      db   "The MSB is: ", 0

msg4      db   "The number of 1 bits is: ", 0

section .text

global main

main:

					call   Clrscr            ; Clears the screen
					mov    rdx, msg1         ; puts msg1 into rdx
					call   WriteString       ; prints msg1
					call   ReadHex           ; reads in a hexadecimal value
					call   WriteBin          ; Writes out the Binary Number
					call   Crlf              ; Goes to next line
					mov    rbx, rax          ; puts the value into rbx

					bsr    rax, rbx          ; places MSB index into rax
					mov    rdx, msg3         ; puts msg3 into rdx
					call   WriteString       ; prints msg3
					call   WriteInt          ; prints the index of MSB
					call   Crlf              ; Goes to next line

					bsf    rax, rbx          ; places LSB index into rax
					mov    rdx, msg2         ; puts msg2 into rdx
					call   WriteString       ; prints msg2
					call   WriteInt          ; prints the index of LSB
					call   Crlf              ; Goes to next line

					xor    rcx, rcx          ; sets rcx to 0
					xor    r15, r15          ; sets r15 to 0
					clc                      ; CF = 0
					call   Loop1             ; calls Loop1

					call   ExitProc          ; terminates program

Loop1:
					cmp    rcx, 64           ; compares rcx with 63
					je     Print						 ; jumps to Print if equal to 63
					shl    rbx, 1            ; shifts rbx left by 1 bit
					adc    r15, 0            ; adds the carry bit to r15
					add    rcx, 1            ; increments rcx by 1
					call   Loop1             ; Calls Loop1 again

Print:
					mov    rax, r15          ; moves the rcx into rax
					mov    rdx, msg4         ; puts msg4 into rdx
					call   WriteString       ; prints msg4
					call   WriteInt          ; prints the number of 1 bits
					call   Crlf              ; Goes to next line

					call   ExitProc          ; terminates program
