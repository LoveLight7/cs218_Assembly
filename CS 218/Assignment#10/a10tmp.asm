;  Assignment #10

;  Support Functions.
;  Provided Template

; -----
;  Function getParams()
;	Gets, checks, converts, and returns command line arguments.

;  Function drawCircle()
;	Plots provided circle function

; ---------------------------------------------------------

;	MACROS (if any) GO HERE


; ---------------------------------------------------------

section  .data

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
;  OpenGL constants

GL_COLOR_BUFFER_BIT	equ	16384
GL_POINTS		equ	0
GL_POLYGON		equ	9
GL_PROJECTION		equ	5889

GLUT_RGB		equ	0
GLUT_SINGLE		equ	0

; -----
;  Define program constants.

SP_MIN		equ	1
SP_MAX		equ	1000

DC_MIN		equ	0
DC_MAX		equ	16777215

BK_MIN		equ	0
BK_MAX		equ	16777215


; -----
;  Local variables for getParams procedure.

STR_LENGTH	equ	12

errUsage	db	"Usage: circles -sp <dozenalNumber> -dc <dozenalNumber> "
		db	"-bk <dozenalNumber>"
		db	LF, NULL
errBadCL	db	"Error, invalid or incomplete command line argument."
		db	LF, NULL

errSPsp		db	"Error, speed specifier incorrect."
		db	LF, NULL
errSPvalue	db	"Error, speed value must be between 1 and 6E4(12)."
		db	LF, NULL

errDCsp		db	"Error, draw color specifier incorrect."
		db	LF, NULL
errDCvalue	db	"Error, draw color value must be between "
		db	"0 and 5751053(12)."
		db	LF, NULL

errBKsp		db	"Error, background color specifier incorrect."
		db	LF, NULL
errBKvalue	db	"Error, background color value must be between "
		db	"0 and 5751053(12)."
		db	LF, NULL

errDCBKsame	db	"Error, draw color and background color can "
		db	"not be the same."
		db	LF, NULL

; -----
;  Local variables for draw circles routine.

red		dd	0			; 0-255
green		dd	0			; 0-255
blue		dd	0			; 0-255

pi		dq	3.14159265358979	; constant
fltZero		dq	0.0
fltOne		dq	1.0
fltTwo		dq	2.0

t		dq	0.0			; loop variable
tStep		dq	0.001			; t step
x		dq	0.0			; current x
y		dq	0.0			; current y
speed		dq	0.0			; circle deformation speed
s		dq	0.0
scale		dq	10000.0			; scale factor for speed

tmp1		dq	0.0
tmp2		dq	0.0

; ------------------------------------------------------------

section  .text

; -----
; Open GL routines.

extern glutInit, glutInitDisplayMode, glutInitWindowSize
extern glutInitWindowPosition
extern glutCreateWindow, glutMainLoop
extern glutDisplayFunc, glutIdleFunc, glutReshapeFunc, glutKeyboardFunc
extern glutSwapBuffers
extern gluPerspective
extern glClearColor, glClearDepth, glDepthFunc, glEnable, glShadeModel
extern glClear, glLoadIdentity, glMatrixMode, glViewport
extern glTranslatef, glRotatef, glBegin, glEnd, glVertex3f, glColor3f
extern glVertex2f, glVertex2i, glColor3ub, glOrtho, glFlush, glVertex2d
extern glutPostRedisplay

extern	cos, sin


; ******************************************************************
;  Generic procedure to display a string to the screen.
;  String must be NULL terminated.
;  Algorithm:
;	Count characters in string (excluding NULL)
;	Use syscall to output characters

;  Arguments:
;	1) address, string
;  Returns:
;	nothing

global	printString
printString:
	push	rbp
	mov	rbp, rsp
	push	rbx
	push	rsi
	push	rdi
	push	rdx

; -----
;  Count characters in string.

	mov	rbx, rdi			; str addr
	mov	rdx, 0
strCountLoop:
	cmp	byte [rbx], NULL
	je	strCountDone
	inc	rbx
	inc	rdx
	jmp	strCountLoop
strCountDone:

	cmp	rdx, 0
	je	prtDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; EDX=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

prtDone:
	pop	rdx
	pop	rdi
	pop	rsi
	pop	rbx
	pop	rbp
	ret

; ******************************************************************
;  Boolean value returning function getParams()
;	Gets draw speed, draw color, and background color
;	from the line argument.

;	Performs error checking, converts ASCII/Dozenal to integer.
;	Command line format (fixed order):
;	  "-sp <dozenalNumber> -dc <dozenalNumber> -bk <dozenalNumber>"

; -----
;  Arguments:
;	1) ARGC, double-word, value
;	2) ARGV, double-word, address
;	3) speed, double-word, address
;	4) draw color, double-word, address
;	5) background color, double-word, address





; ******************************************************************
;  Draw circles function.
;  Plots the following equations:

;	for (s=0.0; s<=1.0; sStep)
;		for (t=0.0; t<(2*pi); t+=tStep)
;			x = (1-s)*cos(t+pi*s)+s*cos(2*t)
;			y = (1-s)*sin(t+pi*s)-s*sin(2*t)
;		plot

; -----
;  Global variables accessed.

common	drawSpeed	1:4			; speed
common	drawColor	1:4			; draw color
common	backColor	1:4			; background color

; -----

global drawCircles
drawCircles:

; -----
;  Save registers
	push	rpb				; Note, rbp is changed indirectly
	push	rbx				; leave these push's/pop's as is
	push	r12

; -----
; Prepare for drawing
	; glClear(GL_COLOR_BUFFER_BIT);
	mov	rdi, GL_COLOR_BUFFER_BIT
	call	glClear

; -----
;  set draw colors, red, green and blue.


; ----
;  Set openGL drawing color.

	mov	edi, dword [red]
	mov	esi, dword [green]
	mov	edx, dword [blue]
	call	glColor3ub			; call glColor3ub(r,g,b)

; ----
;  Init drawing canvas.

	; glBegin();
	mov	rdi, GL_POINTS
	call	glBegin

; -----
;  Set speed based on user entered drawSpeed
;	speed = drawSpeed / 10000




; -----
;  Plot (x,y) based on provided equations
;	x = (1-s)*cos(t+pi*s)+s*cos(2*t)
;	y = (1-s)*sin(t+pi*s)-s*sin(2*t)






; -----
;  End drawing operations and flush unwritten operations.
;  Set-up for next call.

	call	glEnd
	call	glFlush

	call	glutPostRedisplay

; -----
;  Update speed for next call.


; -----
;  Check if s is > 1.0 and if so, reset s to 0.0

 	ucomisd	xmm0, qword [fltOne]
	jb	sIsSet



sIsSet:

; -----
;  Restore registers and return to main.

	pop	r12
	pop	rbx
	pop	rbp
	ret

; ******************************************************************

