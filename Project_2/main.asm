; Author: Austin Chayka
; Program name: CS-271 Program #2
; Description:
;	Asks the user for a term number from 1-46 and validates the input,
;	program then calculates and displays fibbonacci sequence out to
;	specified term

INCLUDE	Irvine32.inc

NAME_SIZE = 32

.data
	;print strings
	writeHead1 BYTE "Fibonacci Numbers", 13, 10, 0
	writeHead2 BYTE "Programmed by Austin Chayka", 13, 10, 0
	namePrompt BYTE "What's your name? ", 0
	nameGreeting BYTE "Hello, ", 0
	fibIntro BYTE "Enter the number of Fibonacci terms to be displayed... It should be and integer in the range [1, 46]...", 13, 10, 0
	fibGetRange BYTE "How many Fibonacci terms do you want? ", 0
	rangeError BYTE "Out of range. Enter number in [1, 46]", 13, 10, 0
	newLine BYTE 13, 10, 0
	spacing BYTE "	", 0
	closing BYTE "Results certified by Austin Chayka.", 13, 10, 0
	goodbye BYTE "Goodbye, ", 0
	period BYTE ".", 0
	;variables
	username BYTE NAME_SIZE + 1 DUP (?)
	terms DWORD ?
	n DWORD ?
	n0 DWORD 0
	n1 DWORD 1
	counter DWORD 0

.code

main PROC
;print intro
	mov		edx, OFFSET writeHead1
	call	WriteString
	mov		edx, OFFSET writeHead2
	call	WriteString
	mov		edx, OFFSET namePrompt
	call	WriteString
;get user's name
	mov		ecx, NAME_SIZE
	mov		edx, OFFSET username
	call	ReadString
;greet user
	mov		edx, OFFSET nameGreeting
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	mov		edx, OFFSET newLine
	call	WriteString
;get number of terms from the user
	jmp		getInput
rangeErrorMsg:
	mov		edx, OFFSET rangeError
	call	WriteString
getInput:
	;get input
	mov		edx, OFFSET fibIntro
	call	WriteString
	mov		edx, OFFSET fibGetRange
	call	WriteString
	call	ReadInt
	;check lower bounds
	mov		terms, eax
	cmp		terms, 1
	jl		rangeErrorMsg
	;check upper bounds
	cmp		terms, 46
	jg		rangeErrorMsg
fibLoop:
;displays fib series
	;print current term
	mov		eax, n1
	call	WriteInt
	mov		edx, OFFSET spacing
	call	WriteString
	;calculate next term
	mov		eax, n0
	add		eax, n1
	mov		n, eax
	mov		eax, n1
	mov		n0, eax
	mov		eax, n
	mov		n1, eax
	;increment loop
	add		counter, 1
	mov		eax, counter
	cmp		terms, eax
	jle		endLoop
	;maintain line format
	mov		edx, 0
	mov		eax, counter
	mov		ebx, 4
	div		ebx
	cmp		edx, 0
	jne		fibLoop
	mov		edx, OFFSET newLine
	call	WriteString
	jmp		fibLoop
endLoop:
;print closing message
	mov		edx, OFFSET newLine
	call	WriteString
	mov		edx, OFFSET closing
	call	WriteString
	mov		edx, OFFSET goodbye
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	mov		edx, OFFSET period
	call	WriteString

	exit
main ENDP

END main