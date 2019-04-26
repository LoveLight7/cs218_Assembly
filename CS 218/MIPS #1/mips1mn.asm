#  CS 218, MIPS Assignment #1

#  Example program to find the:
#	min, max, and average of a list of perimeters.
#	min, max, and average of the even perimeters values.
#	min, max, and average of the perimeters values eveny divisible by 9.

###########################################################
#  data segment

.data

sides:	.word	 252,  193,  982,  339,  564,  631,  421,  148,  936,  157
	.word	 117,  171,  697,  161,  147,  137,  327,  151,  147,  354
	.word	 432,  551,  176,  487,  490,  810,  111,  523,  532,  445
	.word	 163,  745,  571,  529,  218,  219,  122,  934,  370,  121
	.word	 315,  145,  313,  174,  118,  259,  672,  126,  230,  135
	.word	 199,  105,  106,  107,  124,  625,  126,  229,  248,  991
	.word	 132,  133,  936,  136,  338,  941,  843,  645,  447,  449
	.word	 171,  271,  477,  228,  178,  184,  586,  186,  388,  188
	.word	 950,  852,  754,  256,  658,  760,  161,  562,  263,  764
	.word	 199,  213,  124,  366,  740,  356,  375,  387,  115,  426
len:	.word	100

perims:	.space	400			# 100*4 bytes each

min:	.word	0
max:	.word	0
ave:	.word	0

eMin:	.word	0
eMax:	.word	0
eAve:	.word	0

d9Min:	.word	0
d9Max:	.word	0
d9Ave:	.word	0

hdr:	.ascii	"MIPS Assignment #1\n\n"
	.ascii	"Program to find: \n"
	.ascii	"   * min, max, and average for a list of perimeters.\n"
	.ascii	"   * min, max, and average of the even perimeter values.\n"
	.ascii	"   * min, max, and average of the perimeters values divisible by 9."
new_ln:	.asciiz	"\n"

a1_st:	.asciiz	"\n    List min = "
a2_st:	.asciiz	"\n    List max = "
a3_st:	.asciiz	"\n    List ave = "

a4_st:	.asciiz	"\n\n    Even min = "
a5_st:	.asciiz	"\n    Even max = "
a6_st:	.asciiz	"\n    Even ave = "

a7_st:	.asciiz	"\n\n    Divisible by 9 min = "
a8_st:	.asciiz	"\n    Divisible by 9 max = "
a9_st:	.asciiz	"\n    Divisible by 9 ave = "


###########################################################
#  text/code segment

.text
.globl	chk1
.globl	main
.ent	main
main:

# ********************
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall

# ********************




#	YOUR CODE GOES HERE




# ********************
#  Display results.

#  Print list min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall						# print "List min = "

	lw	$a0, min
	li	$v0, 1
	syscall						# print list min

#  Print max message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall						# print "List max = "

	lw	$a0, max
	li	$v0, 1
	syscall						# print max

#  Print average message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall						# print "List ave = "

	lw	$a0, ave
	li	$v0, 1
	syscall						# print average

# -----
#  Display results - even numbers.

#  Print min message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall						# print "Even min = "

	lw	$a0, eMin
	li	$v0, 1
	syscall						# print min

#  Print max message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall						# print "Even max = "

	lw	$a0, eMax
	li	$v0, 1
	syscall						# print max

#  Print average message followed by result.

	la	$a0, a6_st
	li	$v0, 4
	syscall						# print "Even ave = "

	lw	$a0, eAve
	li	$v0, 1
	syscall						# print average

# -----
#  Display results - divisible by 9 numbers.

#  Print min message followed by result.

	la	$a0, a7_st
	li	$v0, 4
	syscall						# print message

	lw	$a0, d9Min
	li	$v0, 1
	syscall						# print min

#  Print max message followed by result.

	la	$a0, a8_st
	li	$v0, 4
	syscall						# print message

	lw	$a0, d9Max
	li	$v0, 1
	syscall						# print max

#  Print average message followed by result.

	la	$a0, a9_st
	li	$v0, 4
	syscall						# print message

	lw	$a0, d9Ave
	li	$v0, 1
	syscall						# print average

	la	$a0, new_ln				# print a newline
	li	$v0, 4
	syscall


# -----
#  Done, terminate program.

	li	$v0, 10
	syscall						# all done!

.end main

