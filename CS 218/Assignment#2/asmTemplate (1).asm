;  Must include:
;	Name
;	Assignmnet Number
;	Section

; -----
;  Short description of program goes here...


; *****************************************************************
;  Static Data Declarations (initialized)

section	.data

; -----
;  Define standard constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; Successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Declare variables.

;	Place data declarations here...




; ----------------------------------------------
;  Uninitialized Static Data Declarations.

section	.bss

;	Place data declarations for uninitialized data here...
;	(i.e., large arrays that are not initialized)


; *****************************************************************

section	.text
global _start
_start:


; -----
;	YOUR CODE GOES HERE...




; *****************************************************************
;	Done, terminate program.

last:
	mov	eax, SYS_exit		; call call for exit (SYS_exit)
	mov	ebx, SUCCESS		; return code of 0 (no error)
	syscall

