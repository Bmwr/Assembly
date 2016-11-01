%include "along64.inc"
          default  rel

; Reads in N integers
; Computes the Average
; Prints out how many numbers were read in and their average.

; Author         : Andrea Beam
; Class          : CS 330
; Description    : Programming Assignment 2

section .data

msg1      db   "Enter the values to be averaged.", 10, 13
          db   "Once done entering values, ", 10, 13
          db   "enter a zero to signify the end.", 10, 13, 0

msg2      db   10, 13, "The average is: ", 10, 13, 0

msg3      db   "The number of integers added together was: ", 10, 13, 0

msg4      db   10, 13, 0

msg5      db   "Error! Zeros are to be used for", 10, 13
          db   "signifying the end of the set of values.", 10, 13
          db   "End Program.", 10, 13, 0

section .text

global main

main:

          call   Clrscr            ; Clears the screen
          mov    rdx, msg1         ; puts msg1 into rdx
          call   WriteString       ; prints msg1
          xor    rcx, rcx          ; sets rcx to 0
          call   ADD               ; calls ADD loop

ADD:
          call   ReadInt           ; reads value into rax
          cmp    rax, 0            ; compares the value to Zero
          je     AVERAGE           ; if equal: exits loop, goes to AVERAGE
          add    rbx, rax          ; adds the value to rbx
          add    rcx, 1            ; increments rcx by 1
          call   ADD               ; calls the loop again

AVERAGE:
          cmp    rcx, 0            ; compares rcx to Zero
          je     ERROR             ; jumps to ERROR if equal

          mov    rdx, msg3         ; moves ms3 into rdx
          call   WriteString       ; prints msg3
          mov    rax, rcx          ; moves rcx into rax
          call   WriteInt          ; prints the value of rax

          mov    rax, rbx          ; moves the sum into rax
          cqo                      ; sign extends rax into rdx:rax
          idiv   rcx               ; divides number of values into sum

          mov    rdx, msg2         ; moves msg2 into rdx
          call   WriteString       ; prints msg2
          call   WriteInt          ; prints value in rax

          mov    rdx, msg4         ; moves msg4 into rdx
          call   WriteString       ; prints msg4

          call   ExitProc          ; terminates program

ERROR:
          mov    rdx, msg5         ; moves msg5 into rdx
          call   WriteString       ; prints out msg5

          call   ExitProc          ; terminates program
