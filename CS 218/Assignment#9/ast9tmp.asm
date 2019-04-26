;  CS 218 - Assignment 9
;  Provided Functions Template.

; **********************************************************************************
;  Write assembly language functions.

;  * Void function readDozenalNumber() to read an duodecimal number from the
;    user interactively.  Includes error checking.

;  * Void function combSort() sorts the numbers into ascending order
;    (small to large).  Uses the comb sort algorithm (from asst #7).

;  * Void function basicStats() finds the minimum, maximum, median, sum, and
;    average for a list of integer numbers.
;    Note, for an odd number of items, the median value is defined as the
;    middle value.  For an even number of values, it is the integer average
;    of the two middle values.

;  * Value returning function intStdDev() finds and returns the intger
;    standard deviation.  The summation must be performed
;    as a quad-word.

;  * Value returning function iSqrt() finds integer square root.

;  Note, you may add additional functions as needed.
;  Suggest adding a function for the dozenal to integer conversion
;  (i.e., converting the macro into a function and adding the error
;  checking).  Such a function will be useful on a future
;  assignment.


; ************************************************************************************

section	.data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation

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

LF		equ	10
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

SUCCESS 	equ	0
NOSUCCESS	equ	1
OUTOFRANGE	equ	2
INPUTOVERFLOW	equ	3
ENDOFINPUT	equ	4


; -----
;  Program specific constants.

MIN_NUM		equ	-100000
MAX_NUM		equ	100000

BUFFSIZE	equ	51			; 50 chars plus NULL

; -----
;  NO STATIC LOCAL VARIABLES
;  LOCALS MUST BE DEFINED ON THE STACK!!


; =============================================================================

section	.text

; *****************************************************************************
;  Read an ASCII base-12 number from the user.
;  Includes error checking and conversion to integer.
;  Prompt was already performed by the calling routine.

;  Return codes:
;	SUCCESS		Successful conversion and number within required range
;	NOSUCCESS	Invalid input entered
;	OUTOFRANGE	Valid number, but out of range
;	INPUTOVERFLOW	User entry character count exceeds maximum length
;	ENDOFINPUT	Return entered, no characters (for end of the input)

;  Note, you may add additional functions as needed.
;  Suggest adding a function for the dozenal to integer conversion
;  (i.e., converting the macro into a function and adding the error
;  checking).  Such a function will be useful on a future
;  assignment.

; -----
;  HLL Call:
;	status = readDozenalNumber(&numberRead);

;  Arguments Passed:
;	- numberRead, addr

;  Returns:
;	number read (via reference)
;	status code (as above)




;	YOUR CODE GOES HERE




; *******************************************************************************
;  Comb sort function.
;	Note, must update the comb sort algorithm to sort
;	in asending order (small to large)

; -----
;  HLL Call:
;	combSort(list, len)

;  Arguments Passed:
;	1) list, add
;	2) length, value

;  Returns:
;	sorted list (list passed by reference)



;	YOUR CODE GOES HERE




; *******************************************************************************
;  Find the minimum, maximum, median, sum, and average for
;  a list of integers

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  Note, assumes the list is already sorted.

; -----
;  HLL Call:
;	basicStats(list, len, min, med, max, sum, ave)

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



;	YOUR CODE GOES HERE



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



;	YOUR CODE GOES HERE




; *******************************************************************************
;  Function to calculate the integer standard deviation for an
;  array of numbers.

; -----
;  HLL Call:
;	ans = intStdDev(list, len)

;  Arguments Passed:
;	1) list, addr
;	2) length, value
;	3) average (integer), value

;  Returns:
;	standard deviation (in eax)



;	YOUR CODE GOES HERE




; ********************************************************************************

