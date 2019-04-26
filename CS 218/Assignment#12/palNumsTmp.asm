;  CS 218 - Assignment #12
;  Palindromic Numbers Program
;  Provided template with threading calls

; -----


; ***************************************************************

section	.data

; -----
;  Define standard constants.

LF		equ	10			; line feed
NULL		equ	0			; end of string
ESC		equ	27			; escape character

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; Successful operation
NOSUCCESS	equ	1			; Unsuccessful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; call code for read
SYS_write	equ	1			; call code for write
SYS_open	equ	2			; call code for file open
SYS_close	equ	3			; call code for file close
SYS_fork	equ	57			; call code for fork
SYS_exit	equ	60			; call code for terminate
SYS_creat	equ	85			; call code for file open/create
SYS_time	equ	201			; call code for get time

; -----
;  Message strings

header		db	"**********************************************", LF
		db	ESC, "[1m", "Palindromic Numbers Program"
		db	ESC, "[0m", LF, LF, NULL
msgStart	db	"--------------------------------------", LF	
		db	"Start Counting", LF, NULL
palMsgMain	db	"Palindromic Numbers: ", NULL
msgProgDone	db	LF, LF, "Completed.", LF, NULL

numberLimit	dq	0		; limit (quad)
thdCount	dd	0		; thread Count

; -----
;  Globals (used by threads)

PAL_STEP	equ	10000
idxCounter	dq	1
palCount	dq	0

myLock1		dq	0
myLock2		dq	0

; -----
;  Thread data structures

pthreadID0	dq	0, 0, 0, 0, 0
pthreadID1	dq	0, 0, 0, 0, 0
pthreadID2	dq	0, 0, 0, 0, 0
pthreadID3	dq	0, 0, 0, 0, 0

; -----
;  Variables for thread function.

msgThread1	db	" ...Thread starting...", LF, NULL

; -----
;  Variables for printMessageValue

newLine		db	LF, NULL
comma		db	", ", NULL

; -----
;  Variables for getArguments function

THREAD_MIN	equ	1
THREAD_MAX	equ	4

LIMIT_MIN	equ	10
LIMIT_MAX	equ	5000000000

PRT_LIMIT	equ	1000
NUMS_PER_LINE	equ	10

errUsage	db	"Usgae: ./palNums <-t1|-t2|-t3|-t4> ",
		db	"-l <dozenalNumber>", LF, NULL
errOptions	db	"Error, invalid command line options."
		db	LF, NULL
errTHSpec	db	"Error, invalid thread count specifier."
		db	LF, NULL
errTHValue	db	"Error, thread count invalid."
		db	LF, NULL
errLMSpec	db	"Error, invalid limit specifier."
		db	LF, NULL
errLMValue	db	"Error, limit invalid."
		db	LF, NULL

; -----
;  Variables for int2dozenal function

tmpNum		dq	0

; -----
;  Uninitialized data

section	.bss

tmpString	resb	20


; ***************************************************************

section	.text

; -----
;  External statements for thread functions.

extern	pthread_create, pthread_join

; ================================================================
;  Palindromic numbers program.

global main
main:
	push	rbp
	mov	rbp, rsp

; -----
;  Get/check command line arguments

	mov	rdi, rdi			; argc
	mov	rsi, rsi			; argv
	mov	rdx, thdCount
	mov	rcx, numberLimit
	call	getArguments

	cmp	rax, TRUE
	jne	progDone

; -----
;  Initial actions:
;	Display initial messages

	mov	rdi, header
	call	printString

	mov	rdi, msgStart
	call	printString

; -----
;  Create new thread(s)
;	pthread_create(&pthreadID0, NULL, &findPalNums, NULL);

	mov	rdi, pthreadID0
	mov	rsi, NULL
	mov	rdx, findPalNums
	mov	rcx, NULL
	call	pthread_create


;	YOUR CODE GOES HERE
;	call other threads as needed based on user provided thread count.



;  Wait for thread(s) to complete.
;	pthread_join (pthreadID0, NULL);

WaitForThreadCompletion:
	mov	rdi, qword [pthreadID0]
	mov	rsi, NULL
	call	pthread_join


;	YOUR CODE GOES HERE
;	join other threads as appropriate...



; -----
;  Display final count

showFinalResults:
	mov	rdi, newLine
	call	printString

	mov	rdi, palMsgMain
	call	printString
	mov	rdi, qword [palCount]
	mov	rsi, tmpString
	call	int2dozenal
	mov	rdi, tmpString
	call	printString
	mov	rdi, newLine
	call	printString

; -----
;  Program done, display final message
;	and terminate.

doMsg:
	mov	rdi, msgProgDone
	call	printString

progDone:
	pop	rbp
	mov	rax, SYS_exit			; system call for exit
	mov	rdi, SUCCESS			; return code SUCCESS
	syscall

; ******************************************************************
;  Function getArguments()
;	Get, check, convert, verify range, and return the
;	sequential/parallel option and the limit.

;  Example HLL call:
;	stat = getArguments(argc, argv, &thdConut, &numberLimit)

;  This routine performs all error checking, conversion of
;  ASCII/dozenal to integer, verifies legal range.
;  For errors, applicable message is displayed and FALSE is returned.
;  For good data, all values are returned via addresses with TRUE returned.

;  Command line format (fixed order):
;	<-t1|-t2|-t3|-t4> -l <dozenalNumber>

; -----
;  Arguments:
;	- ARGC, value
;	- ARGV, address
;	- thread count (dword), address
;	- limit (qword), address


;	YOUR CODE GOES HERE



; ******************************************************************
;  Thread function, findPalNums()
;	Find palindromic numbers.

; -----
;  Arguments:
;	N/A (global variable accessed)
;  Returns:
;	N/A (global variable accessed)

global findPalNums
findPalNums:


;	YOUR CODE GOES HERE


	ret

; ******************************************************************
;  Mutex lock
;	checks lock (shared gloabl variable)
;		if unlocked, sets lock
;		if locked, lops to recheck until lock is free

global	spinLock1
spinLock1:
	mov	rax, 1			; Set the RAX register to 1.

lock	xchg	rax, qword [myLock1]	; Atomically swap the RAX register with
					;  the lock variable.
					; This will always store 1 to the lock, leaving
					;  the previous value in the RAX register.

	test	rax, rax	        ; Test RAX with itself. Among other things, this will
					;  set the processor's Zero Flag if RAX is 0.
					; If RAX is 0, then the lock was unlocked and
					;  we just locked it.
					; Otherwise, RAX is 1 and we didn't acquire the lock.

	jnz	spinLock1		; Jump back to the MOV instruction if the Zero Flag is
					;  not set; the lock was previously locked, and so
					; we need to spin until it becomes unlocked.
	ret

; ******************************************************************
;  Mutex unlock
;	unlock the lock (shared global variable)

global	spinUnlock1
spinUnlock1:
	mov	rax, 0			; Set the RAX register to 0.

	xchg	rax, qword [myLock1]	; Atomically swap the RAX register with
					;  the lock variable.
	ret

; ******************************************************************
;  Function: Check and convert ASCII/dozenal string
;		to integer.

;  HLL Call:
;	bool = dozenal2int(dozenalStr, &num);


;	YOUR CODE GOES HERE



; ******************************************************************
;  Convert integer to ASCII/dozenal string.
;	Note, no error checking done on integer.
;	No leading spaces placed in string.

; -----
;  HLL Call:
;	int2dozenal(integer, strAddr)

; -----
;  Arguments:
;	- integer, value
;	- string, address

; -----
;  Returns:
;	ASCII/dozenal string (NULL terminated)


;	YOUR CODE GOES HERE



; ******************************************************************
;  Generic function to display a string to the screen.
;  String must be NULL terminated.
;  Algorithm:
;	Count characters in string (excluding NULL)
;	Use syscall to output characters

;  Arguments:
;	- address, string
;  Returns:
;	nothing

global	printString
printString:

; -----
;  Count characters to write.

	mov	rdx, 0
strCountLoop:
	cmp	byte [rdi+rdx], NULL
	je	strCountLoopDone
	inc	rdx
	jmp	strCountLoop
strCountLoopDone:
	cmp	rdx, 0
	je	printStringDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; rdx=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

printStringDone:
	ret

; ******************************************************************

