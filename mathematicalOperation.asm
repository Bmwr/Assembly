%include "along64.inc"
          default  rel

; Reads in 2 integers
; Computes formula [ A * B - (A + B)/(A - B)]
; Prints Error if denominator = 0

; Author         : Andrea Beam
; Class          : CS 330
; Description    : Programming Assignment 1

section .data

msg1      db   "Enter the first value: ", 0

msg2      db   "Enter the second value: ", 0

msg3      db   "Error. Denominator cannot equal '0'. ", 0

msg4      db   "The solution to the problem is: ", 0

section .text

global main

main:
          mov    rdx, msg1         ; puts msg1 into rdx
          call   WriteString       ; prints msg1
          call   ReadInt           ; reads 1st value into rax
          call   Crlf              ; Goes to next line
          mov    rbx, rax          ; moves 1st value into rbx

          mov    rdx, msg2         ; moves msg2 into rdx
          call   WriteString       ; prints msg2
          call   ReadInt           ; reads 2nd value into rax
          call   Crlf              ; Goes to next line

          cmp    rbx, rax          ; Compares val1 with val2
          je     EQUAL             ; Jumps to msg3 "error msg" if equal

          mov    rcx, rbx          ; rax = 2nd value, rbx & rcx = 1st value
          sub    rcx, rax          ; subtracts 2nd value from 1st
          push   rcx               ; pushes new value to stack

          mov    rcx, rbx          ; rax = 2nd value, rbx & rcx = 1st value
          add    rcx, rax          ; adds 2nd value to 1st
          push   rcx               ; pushes new value to stack

          mov    rcx, rbx          ; rax = 2nd value, rbx & rcx = 1st value
          imul   rcx, rax          ; multiplies 2nd value to 1st
          pop    rax               ; pops 2nd solution from stack
          pop    rbx               ; pops 1st solution from stack

          cqo                      ; sign extends rax into rdx:rax
          idiv   rbx               ; divides 2nd solution by 1st solution
          sub    rcx, rax          ; subtracts quotient from product

          mov    rax, rcx          ; moves final solution to rax
          mov    rdx, msg4         ; moves msg4 into rdx
          call   WriteString       ; prints out msg4
          call   WriteInt          ; prints out the solution
          call   Crlf              ; goes to next line

          call   ExitProc          ; terminates program


EQUAL:
          mov    rdx, msg3         ; moves msg3 into rdx
          call   WriteString       ; prints out msg3
          call   Crlf              ; goes to next line

          call   ExitProc          ; terminates program
