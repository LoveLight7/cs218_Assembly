;  CS 218, Assignment #6
;  Provided Main

;  Write a simple assembly language program to convert integers
;  to duodecimal/ASCII charatcers and output the duodecimal/ASCII
;  strings to the screen (using the provided routine).


; **********************************************************************************
;  Macro, "dozenal2int", to convert a signed duodecimal/ASCII string
;  into an integer.  The macro reads the ASCII string (byte-size,
;  signed, NULL terminated) and converts to a doubleword sized integer.
;	- Accepts both 'X' and 'x' (which are treated as the same thing).
;	- Accepts both 'E' and 'e' (which are treated as the same thing).
;	- Assumes valid/correct data.  As such, no error checking is performed.

;  Example:  given the ASCII string: "  +1Xe", NULL
;  (2 blanks, + sign, "1", followed by "X",  followed by "e", and NULL)
;  would be converted to integer 275.

; -----
;  Arguments
;	%1 -> string address
;	%2 -> destination integer number address

; -----
;  The first argument is the starting address of string.
;  So, first step will be to get address into a register,
;	mov   <some64-bitRegister>, %1
;  For example,
;	mov   rbx, %1

;  The second argument is the address of where to place the result.
;  For example, to save the final result,
;	mov   dword [%2], <regWithFinalResult>
;  For example, assuming the final answer is in register "eax",
;	mov   dword [%2], eax


%macro	dozenal2int	2

;	YOUR CODE GOES HERE


%endmacro

; **********************************************************************************
;  Macro, "int2dozenal", to convert a signed base-10 integer into
;  an ASCII string representing the Duodecimal value.  The macro stores
;  the result into an ASCII string (byte-size, right justified,
;  blank filled, NULL terminated).  Each integer is a doubleword value.
;  Assumes valid/correct data.  As such, no error checking is performed.
;  Note, places "X" and "E" (always uppercase) in string.

;  Example:  Since, 11 (base 10) is E (base 12), then the integer 11
;  would be converted to ASCII resulting in: "         +E", NULL
;  (9 spaces, + sign, and "E" followed a NULL for a total of 12).
;  Assuming the target string size is 12.

; -----
;  Arguments
;	%1 -> integer number (value)
;	%2 -> string address
;	%3 -> target string size (value)

; -----
;  The first argument is the integer value (32-bits) to be converted.
;  To get the value into a register,
;	mov  <some32BitRegister>, %1

;  The second argument is the address of where to store the characters.
;  To get the address (from the passed argument),
;	mov   <64BitRegister>, %2
;  For example, to get the address into rbx,
;	mov   rbx, %2

;  To get the string size (for the final result) into a register,
;	mov   <register>, %3
;  For example,
;	mov   rcx, %3


%macro	int2dozenal	3

;	YOUR CODE GOES HERE


%endmacro

; --------------------------------------------------------------
;  Simple macro to display a string to the console.
;	Call:	printString  <stringAddr>

;	Arguments:
;		%1 -> <stringAddr>, string address

;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

%macro	printString	1
	push	rax					; save altered registers
	push	rdi					; not required, but
	push	rsi					; does not hurt.  :-)
	push	rdx
	push	rcx

	mov	rdx, 0
	mov	rdi, %1
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write				; system call for write (SYS_write)
	mov	rdi, STDOUT				; standard output
	mov	rsi, %1					; address of the string
	syscall						; call the kernel

	pop	rcx					; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; --------------------------------------------------------------

section	.data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; successful operation
NOSUCCESS	equ	1

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; code for read
SYS_write	equ	1			; code for write
SYS_open	equ	2			; code for file open
SYS_close	equ	3			; code for file close
SYS_fork	equ	57			; code for fork
SYS_exit	equ	60			; code for terminate
SYS_creat	equ	85			; code for file open/create
SYS_time	equ	201			; code for get time

LF		equ	10
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

; -----
;  Define program specific constants.

MAX_STR_SIZE	equ	12
NUMS_PER_LINE	equ	5
STR_SIZE	equ	10

; -----
;  Misc. string definitions.

hdr1		db	"--------------------------------------------"
		db	LF, "CS 218 - Assignment #6", LF
		db	LF, LF, NULL
hdr2		db	LF, LF, "---------------------------"
		db	LF, "Final Results for List Sums"
		db	LF, NULL

firstNum	db	"Test Number (base-12):   ", NULL
firstNumPlus	db	"Number * -2 (base-12): ", NULL

lstSum		db	LF, "List Sum:"
		db	LF, NULL

newline		db	LF, NULL

; -----
;  Misc. data definitions (if any).



; -----
;  Assignment #6 Provided Data:

dStr1		db	"   +12X4E", NULL
iNum1		dd	0

dStrLst1	db	"    +1e9X", NULL, "     -3Ex", NULL, "   +1xe92", NULL, "   -82xXe", NULL
		db	"     +xex", NULL
len1		dd	5
sum1		dd	0

dStrLst2	db	"     +3E8", NULL, "   -E6791", NULL, "   +193X0", NULL, "   -250x0", NULL
		db	"  +x13081", NULL, "   -14X21", NULL, "   +22432", NULL, "   -11010", NULL
		db	"   -11201", NULL, "    +1000", NULL, "       -X", NULL, "      -E6", NULL
		db	"     -791", NULL, "    -X009", NULL, "   -19345", NULL, "   -15557", NULL
		db	"    +2369", NULL, "   -189x0", NULL, "   +x12x4", NULL, "   +11111", NULL
		db	"   +12x2e", NULL, "   -11692", NULL, "   +15x10", NULL, "   +1X667", NULL
		db	"    +E726", NULL, "    -X312", NULL, "     +420", NULL, "    -5532", NULL
		db	"   +26516", NULL, "    -5182", NULL, "     +192", NULL, "   +21344", NULL
		db	"    +18e4", NULL, "    +79x6", NULL, "   +24e12", NULL, "   +1X231", NULL
		db	"    +97X5", NULL, "   -17312", NULL, "     +812", NULL, "     +704", NULL
		db	"   -12344", NULL, "   +278x1", NULL, "       +7", NULL, "       -E", NULL
		db	"   -81512", NULL, "    +7e52", NULL, "   +11E44", NULL, "   +10134", NULL
		db	"    -7e64", NULL, "    +4X71", NULL, "    -2344", NULL, "     -2x4", NULL
		db	"   -11212", NULL, "   +11xx5", NULL, "    -2012", NULL, "   -22X30", NULL
		db	"    +7164", NULL, "    +1067", NULL, "   +11721", NULL, "   +21000", NULL
		db	"    -2174", NULL, "    -2127", NULL, "   -23212", NULL, "     +117", NULL
		db	"   -20163", NULL, "   +12112", NULL, "   +11345", NULL, "   +11064", NULL
		db	"   +11721", NULL, "   +26000", NULL, "   -23575", NULL, "   +13725", NULL
		db	"    +3110", NULL, "     -120", NULL, "   +13332", NULL, "   +10022", NULL
		db	"    -7560", NULL, "   +12313", NULL, "   +11760", NULL, "    +4312", NULL
		db	"   +17465", NULL, "   +23241", NULL, "   -27431", NULL, "     -730", NULL
		db	"    +4313", NULL, "   +30233", NULL, "   +13657", NULL, "   -31113", NULL
		db	"    +1661", NULL, "   +11312", NULL, "   +17555", NULL, "   -12241", NULL
		db	"   +13231", NULL, "    +3270", NULL, "    -7653", NULL, "   +15127", NULL
		db	"      +X5", NULL, "   +7e3e1", NULL, "  +XexEXE", NULL, "    +1e9x", NULL
len2		dd	100
sum2		dd	0


; **********************************************************************************

section	.bss

num1String	resb	MAX_STR_SIZE
tempString	resb	MAX_STR_SIZE
tempNum		resd	1


; **********************************************************************************

section	.text
global	_start
_start:

; **********************************************************************************
;  Main program
;	display headers
;	calls the macro on various data items
;	display results to screen (via provided macro's)

;  Note, since the print macros do NOT perform an error checking,
;  	if the conversion macros do not work correctly,
;	the print string will not work!

; **********************************************************************************
;  Prints some cute headers...

	printString	hdr1
	printString	firstNum
	printString	dStr1
	printString	newline

; -----
;  STEP #1
;	Convert duodecimal/ASCII NULL terminated string at 'dNum1'
;	into an integer which should be placed into 'iNum1'
;	Note, 12x4e (base-12) = 25691 (base-10)


;	YOUR CODE GOES HERE
;	DO NOT USE MACRO HERE!!


; -----
;  Perform (iNum1 * -2) operation.
;	Note, 25691 (base-10) * -2 (base-10) = -51382 (base-10)

	mov	eax, dword [iNum1]
	mov	ebx, -2
	imul	ebx
	mov	dword [iNum1], eax

; -----
;  STEP #2
;	Convert the integer (dNum1) into a duodecimal/ASCII string
;	which should be stored into the 'num1String'
;	Note, -51382 (base-10) = -2589X (base-12)


;	YOUR CODE GOES HERE
;	DO NOT USE MACRO HERE!!


; -----
;  Display a simple header and then the ASCII/octal string.

	printString	firstNumPlus
	printString	num1String

; -----
;  For the initial testing, you can uncomment the below jmp.
;	This will jump to the end of the program (skipping the macro calls).

;	jmp	last

; **********************************************************************************
;  Next, repeatedly call the macro on each value in an array.

	printString	hdr2

; ==================================================
;  Data Set #1 (short list)

	mov	rcx, 0
	mov	ecx, dword [len1]			; length
	mov	rsi, 0					; starting index of integer list
	mov	rdi, dStrLst1				; address of string

cvtLoop1:
	push	rcx
	push	rdi

	dozenal2int	rdi, tempNum

	mov	eax, dword [tempNum]
	add	dword [sum1], eax

	pop	rdi
	add	rdi, STR_SIZE

	pop	rcx
	dec	rcx					; check length
	cmp	rcx, 0
	ja	cvtLoop1

	; convert integer to string (MAX_STR_SIZE) long
	int2dozenal	dword [sum1], tempString, MAX_STR_SIZE

	printString	lstSum				; display header string
	printString	tempString			; print string
	printString	newline

; ==================================================
;  Data Set #2 (long list)

	mov	rcx, 0
	mov	ecx, dword [len2]			; length
	mov	rsi, 0					; starting index of integer list
	mov	rdi, dStrLst2				; address of string

cvtLoop2:
	push	rcx
	push	rdi

	dozenal2int	rdi, tempNum

	mov	eax, dword [tempNum]
	add	dword [sum2], eax

	pop	rdi
	add	rdi, STR_SIZE

	pop	rcx
	dec	rcx					; check length
	cmp	rcx, 0
	ja	cvtLoop2

	; convert integer to string
	int2dozenal	dword [sum2], tempString, MAX_STR_SIZE

	printString	lstSum				; display header string
	printString	tempString			; print string
	printString	newline


; **********************************************************************************
; Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rbx, SUCCESS
	syscall

