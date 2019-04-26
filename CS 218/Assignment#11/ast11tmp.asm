;  CS 218 - Assignment #11
;  Provided Template

; -----
;  The provided main calls four functions.

;  1) checkParameters()
;	Get command line arguments (word, match case flag, and
;	file descriptor), performs appropriate error checking,
;	opens file, and returns the word, match case flag, and
;	the file descriptor and word.  Ifthere any errors in
;	command line arguments, display appropriate error
;	message, and return NOSUCCESS status code.

;  2) getWord()
;	Get a single word of text (which must be verified
;	as no more than MAXWORDLENGTH characters).
;	Returned word is terminated with an NULL.
;	Note, this routine performs all buffer management.

;  NOTE: The buffer management is a significant portion of
;	the assignment.  Omitting or skipping the I/O
;	buffering will significantly impact the score.

;  3) checkWord()
;       Given the new word from the file and the user specified
;       word and the current count, update the count if the 
;	words match.

;  4) displayResults()
;	Display a formatted summary of the results.


;----------------------------------------------------------------------------

section	.data

; -----
;  Define standard constants.

LF		equ	10			; line feed
NULL		equ	0			; end of string
SPACE		equ	0x20			; space

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; Successful operation
NOSUCCESS	equ	1			; Unsuccessful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; system call code for read
SYS_write	equ	1			; system call code for write
SYS_open	equ	2			; system call code for file open
SYS_close	equ	3			; system call code for file close
SYS_fork	equ	57			; system call code for fork
SYS_exit	equ	60			; system call code for terminate
SYS_creat	equ	85			; system call code for file open/create
SYS_time	equ	201			; system call code for get time

O_CREAT		equ	0x40
O_TRUNC		equ	0x200
O_APPEND	equ	0x400

O_RDONLY	equ	000000q			; file permission - read only
O_WRONLY	equ	000001q			; file permission - write only
O_RDWR		equ	000002q			; file permission - read and write

S_IRUSR		equ	00400q
S_IWUSR		equ	00200q
S_IXUSR		equ	00100q

; -----
;  Variables for getFileDescriptors()

usageMsg	db	"Usage: ./wordCount -w <searchWord> <-mc|-ic> -f <inputFile>"
		db	LF, NULL

errbadCLQ	db	"Error, invalid command line arguments."
		db	LF, NULL

errWordSpec	db	"Error, invalid search word specifier."
		db	LF, NULL

errWordLength	db	"Error, search word length must be < 80 "
		db	"characters."
		db	LF, NULL

errFileSpec	db	"Error, invalid input file specifier."
		db	LF, NULL

errCaseSpec	db	"Error, invalid match case specifier."
		db	LF, NULL

errOpenIn	db	"Error, can not open input file."
		db	LF, NULL

; -----
;  Define constants and variables for getWord()

MAXWORDLENGTH	equ	80
BUFFSIZE	equ	300000
;BUFFSIZE	equ	3

bfMax		dq	BUFFSIZE
curr		dq	BUFFSIZE

wasEOF		db	FALSE

errFileRead	db	"Error reading input file."
		db	LF, NULL

; -----
;  Define constants and variables for displayResults()

resultStart	db	"Found '", NULL
resultSpace	db	"' ", NULL
resultEnd	db	" times.", LF, NULL

; -------------------------------------------------------

section	.bss

buff		resb	BUFFSIZE+1
tmpString	resb	MAXWORDLENGTH+1


; -------------------------------------------------------

section	.text

; -------------------------------------------------------
;  Check and return command line parameters.
;	Assignment #11 requires a word to search for, flag for
;	case handling and a file name.
;	Example:    % ./wordCount -w <searchWord> <-mc|-ic> -f <infile>

; -----
; HLL Call:
;	bool = checkParameters(ARGC, ARGV, searchWord, matchCase, rdFileDesc)

;  Arguments passed:
;	1) argc, value
;	2) argv, address
;	3) search word string, address
;	4) match case boolean, address
;	5) input file descriptor, address





; -------------------------------------------------------
;  Get a single word of text and return.
;  Implements basic C++ (searchWord << inFile) functionality.

;  A "word" is considered a set of contiguous non-white space
;  characters.  White space includes spaces, tabs, and LF.
;  Any character <= a space character is considered white space.
;  Function terminates word string with a NULL.

;  If a word exceeds the passed max length, must not over-write
;  the buffer.  Instead, just skip remaining characters.
;  This returns a partial word (which is ok in this context).

;  This routine handles the I/O buffer management.
;	- if buffer is empty, get more chars from file
;	- return word and update buffer pointers

;  If a word is returned, return TRUE.
;  Otherwise, return FALSE.

; -----
; HLL Call:
;	bool = getWord(currentWord, maxLength, rdFileDesc)

;  Arguments passed:
;	1) word buffer, address
;	2) max word length (excluding NULL), value
;	3) file descriptor, value







; -------------------------------------------------------
;  Compare strings, searchWord to currWord.
;  If same, increment word count.
;  Must handle match based on case flag.

; -----
;  HLL Call:
;	call checkWord(searchWord, currentWord, matchCase, wordCount)

;  Argument passed:
;	1) searchWord, address
;	2) currentWord, address
;	3) match case flag, value
;	4) word count, address






; -------------------------------------------------------
;  Display formatted results to screen.
;	includes search word and count (in Dozenal).
;	format:
;		Found '<searchWord>' <wordCount> times.

; -----
;  HLL Call:
;	displayResults(searchWord, wordCount)

;  Arguments passed:
;	1) search word string, address
;	2) word count, value






; ******************************************************************
;  Generic function to display a string to the screen.
;  String must be NULL terminated.

;  Algorithm:
;	Count characters in string (excluding NULL)
;	Uses syscall to output characters

; -----
;  HLL Call:
;	printString(stringAddr);

;  Arguments:
;	1) address, string
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

