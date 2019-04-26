;  CS 218 - Assignment 8
;  Functions Template.

; **********************************************************************************
;  Write assembly language functions.

;  * Void function combSort() sorts the numbers into descending order
;    (large to small).  Must use the comb sort algorithm (from asst #7).

;  * Void function basicStats() finds the minimum, maximum, median, sum,
;    and average for a list of numbers.  Note, for an odd number of items,
;    the median value is defined as the middle value.  For an even number
;    of values, it is the integer average of the two middle values.

;  * Value returning function iSqrt() computes and returns the integer
;    square root of a given number.

;  * Value returning function iStdDev() finds and standard deviation.
;    The summation for the a (alpha) value must be performed as a quad-word.


; ********************************************************************************

section	.data

; -----
;  Define standard constants.

LF		equ	10			; line feed
CR		equ	13			; carridge return
NULL		equ	0			; end of string

TRUE		equ	0
FALSE		equ	-1

SUCCESS		equ	0			; Successful operation
NOSUCCESS	equ	1			; Unsuccessful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_exit	equ	1			; system call code for terminate
SYS_fork	equ	2			; system call code for fork
SYS_read	equ	3			; system call code for read
SYS_write	equ	4			; system call code for write
SYS_open	equ	5			; system call code for file open
SYS_close	equ	6			; system call code for file close
SYS_create	equ	8			; system call code for file open/create

; -----
;  Local variables for combSort() procedure (if any)



; -----
;  Local variables for basicStats() procedure (if any)



; -----
;  Local variables for iSqrt() function (if any)



; -----
;  Local variables for iStdDev() function (if any)




; ---------------------------------------------

section .bss




; ********************************************************************************

section	.text

; *******************************************************************************
;  Comb sort function.
;	Note, must update the comb sort algorithm to sort
;	in desending order

; -----
;  HLL Call:
;	combSort(list, len)

;  Arguments Passed:
;	1) list, addr
;	2) length, value

;  Returns:
;	sorted list (list passed by reference)

global	combSort
combSort:


;	YOUR CODE GOES HERE



	ret


; *******************************************************************************
;  Find the minimum, maximum, median, sum, and average for
;  a list of integers

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  Note, assumes the list is already sorted.

; -----
;  HLL Call:
;	basicStats(list, len, min, med, max)

;  Arguments Passed:
;	1) list, addr
;	2) length, value
;	3) minimum, addr
;	4) maximum, addr
;	5) median, addr
;	6) sum, addr
;	7) average, addr

;  Returns:
;	minimum, maximum, median, sum, and average via 
;	pass-by-reference (addresses on stack)

global basicStats
basicStats:


;	YOUR CODE GOES HERE



	ret


; *******************************************************************************
;  Find the integer square root of a passed number.
;	iSqrt_est = [ (iNumber/iSqrt_est) + iSqrt_est] / 2

; -----
;  HLL Call:
;	ans = iSqrt(num)

;  Arguments Passed:
;	1) number, value

;  Returns:
;	integer square root (in eax)

global iSqrt
iSqrt:


;	YOUR CODE GOES HERE



	ret


; *******************************************************************************
;  Function to calculate the integer standard deviation for an
;  array of numbers.

; -----
;  HLL Call:
;	bValue = iStdDev(list, len)

;  Arguments Passed:
;	1) list, addr
;	2) length, value
;	3) average (integer), value

;  Returns:
;	standard deviation (in eax)

global intStdDev
intStdDev:


;	YOUR CODE GOES HERE



	ret

; ********************************************************************************


