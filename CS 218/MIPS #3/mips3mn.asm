#  CS 218, MIPS Assignment #3
#  MIPS assembly language main program and functions:

#  * MIPS assembly language void function, prtHeaders() to 
#    display some headers as per assignment format example.

#  * MIPS assembly language void function, calcTotalAreas(), 
#    to calculate the toal area for each square pyramid
#    in a series of square pyramids.

#  * MIPS assembly language void function, combSort(), to sort
#    the areas array (small to large) using the count sort
#    algorithm.

#  * MIPS assembly langauge, value returning function, median(),
#    to find the statistical median of an array.

#  * MIPS assembly langauge, value returning function, estMedian(),
#    to find the estimated median of an array.

#  * MIPS assembly language void function, totalAreasStats(),
#    that will find the minimum, maximum, estimated median, median,
#    percentage difference (between the median and estimated medain),
#    sum, and float average of the total areas array.  The function
#    must call the median(), and estMedian() functions.
#    Additionally, the routine must call the combSort() function.
#    The estimated median must be determine before the sort.
#    The minimum, maximum, and statistical median must be
#    determined after the sort.

#  * MIPS assembly language function, printAreas(), to
#    display the areas array statistical information:
#    sum, minimum, maximum, median, integer average, and
#    float average in the format shown in the example.
#    The numbers should be printed 8 per line (see example).


#####################################################################
#  data segment

.data

# -----
#  Data declarations for main.

bases1:		.word	 19,  17,  15,  13,  11,  19,  17,  15,  13,  11
		.word	 12,  14,  16,  18,  10,  29,  27,  25,  23,  21
		.word	 29,  27,  25,  23,  21,  22,  24,  26,  28,  20
slants1:	.word	 34,  32,  31,  35,  34,  33,  32,  37,  38,  39
		.word	 32,  30,  36,  38,  30,  44,  42,  41,  45,  44
		.word	 43,  42,  47,  48,  49,  42,  40,  46,  48,  40
totalAreas1:	.space	120
len1:		.word	30
min1:		.word	0
max1:		.word	0
med1:		.word	0
estMed1:	.word	0
pctDiff1:	.float	0.0
sum1:		.word	0
fAve1:		.float	0.0

bases2:		.word	 12,  11,  16,  17,  15,  10,  11,  13,  12,  15
		.word	 12,  13,  12,  19,  14,  11,  11,  18,  16,  17
		.word	 13,  15,  11,  19,  18,  19,  12,  14,  10,  11
		.word	 10,  14,  16,  17,  14,  15,  16,  19,  18,  12
		.word	 11,  13,  14,  16,  10,  16,  15,  17,  10,  16
		.word	 14,  12,  14,  16,  17,  14,  16,  10,  16,  13
		.word	 12,  13,  12,  12,  14,  11,  11,  18,  16,  17
		.word	 13,  15,  11,  19,  18,  19,  12,  14,  10,  11
		.word	 10,  14,  16,  17,  14,  15,  16,  19,  18,  12
		.word	 11,  13,  14,  16,  10,  16,  15,  17,  10,  16
		.word	 12,  15,  17,  13,  17,  17,  17,  19,  18,  14
		.word	 10,  11,  13,  12,  15,  10,  11,  12,  12,  12
		.word	 12,  11,  16,  17,  15,  11,  12,  13,  14,  15
		.word	 14,  12,  14,  16,  17,  14,  16,  10,  16,  13
		.word	 12,  15,  17,  12,  17,  17,  17,  19,  18
slants2:	.word	 45,  55,  43,  54,  68,  59,  42,  56,  49,  41
		.word	 55,  65,  53,  64,  18,  69,  52,  66,  59,  51
		.word	 57,  51,  67,  51,  67,  57,  57,  61,  61,  59
		.word	 52,  59,  55,  59,  53,  55,  51,  52,  54,  59
		.word	 56,  52,  52,  51,  56,  60,  64,  58,  68,  62
		.word	 67,  57,  69,  54,  53,  54,  55,  56,  55,  54
		.word	 61,  63,  56,  69,  61,  52,  60,  68,  51,  59
		.word	 47,  41,  57,  41,  57,  47,  47,  51,  51,  49
		.word	 42,  49,  45,  49,  43,  45,  41,  42,  44,  49
		.word	 46,  42,  42,  41,  46,  50,  54,  48,  58,  52
		.word	 57,  47,  59,  44,  43,  44,  45,  46,  45,  44
		.word	 51,  53,  46,  59,  51,  42,  50,  58,  41,  49
		.word	 59,  44,  47,  49,  52,  54,  46,  48,  52,  53
		.word	 42,  51,  56,  57,  46,  52,  61,  66,  67,  56
		.word	 69,  64,  67,  69,  62,  64,  56,  68,  62
totalAreas2:	.space	596
len2:		.word	149
min2:		.word	0
max2:		.word	0
med2:		.word	0
estMed2:	.word	0
pctDiff2:	.float	0.0
sum2:		.word	0
fAve2:		.float	0.0

bases3:		.word	 11,  18,  15,  13,  12,  10,  18,  11,  14,  12
		.word	 15,  12,  16,  12,  13,  19,  16,  12,  18,  11
		.word	 12,  15,  16,  17,  15,  14,  18,  10,  16,  13
		.word	 13,  12,  11,  11,  11,  13,  12,  16,  18,  13
		.word	 12,  19,  15,  19,  11,  15,  19,  12,  14,  19
		.word	 10,  14,  16,  17,  14,  17,  16,  19,  18,  12
		.word	 11,  13,  16,  19,  11,  12,  14,  18,  11,  15
		.word	 19,  14,  19,  12,  17,  14,  16,  11,  12,  13
		.word	 11,  13,  14,  16,  10,  16,  15,  17,  10,  16
		.word	 11,  18,  15,  13,  12,  10,  18,  11,  14,  12
		.word	 15,  12,  16,  12,  13,  19,  16,  12,  18,  11
		.word	 12,  15,  16,  17,  15,  14,  19,  10,  16,  13
		.word	 13,  12,  11,  11,  11,  14,  12,  16,  18,  19
		.word	 12,  19,  15,  19,  14,  15,  19,  12,  14,  19
		.word	 10,  14,  16,  17,  14,  15,  16,  19,  18,  12
		.word	 11,  13,  16,  19,  11,  12,  14,  18,  11,  15
		.word	 19,  14,  19,  12,  17,  14,  16,  11,  12,  13
		.word	 11,  13,  14,  16,  11,  16,  15,  17,  10,  16
slants3:	.word	 43,  42,  41,  41,  41,  44,  42,  46,  58,  43
		.word	 42,  49,  45,  49,  41,  55,  49,  42,  44,  49
		.word	 40,  44,  46,  57,  44,  35,  46,  29,  48,  42
		.word	 41,  43,  46,  49,  51,  52,  54,  58,  61,  65
		.word	 29,  14,  27,  19,  52,  41,  44,  56,  42,  33
		.word	 41,  53,  54,  46,  40,  56,  75,  27,  50,  46
		.word	 54,  55,  45,  62,  52,  41,  42,  56,  56,  43
		.word	 28,  59,  51,  42,  53,  41,  16,  51,  49,  56
		.word	 46,  19,  49,  37,  46,  54,  54,  56,  64,  42
		.word	 53,  52,  51,  51,  51,  54,  52,  56,  18,  53
		.word	 52,  59,  55,  59,  51,  25,  59,  52,  54,  59
		.word	 50,  54,  56,  17,  54,  45,  56,  39,  58,  52
		.word	 51,  53,  56,  59,  11,  22,  14,  18,  11,  25
		.word	 29,  24,  37,  09,  22,  51,  54,  26,  52,  43
		.word	 51,  23,  24,  56,  50,  16,  15,  17,  60,  56
		.word	 14,  15,  55,  12,  22,  21,  23,  36,  26,  53
		.word	 18,  19,  11,  52,  13,  23,  26,  21,  59,  26
		.word	 56,  39,  59,  47,  16,  14,  24,  16,  14,  52
totalAreas3:	.space	720
len3:		.word	180
min3:		.word	0
max3:		.word	0
med3:		.word	0
estMed3:	.word	0
pctDiff3:	.float	0.0
sum3:		.word	0
fAve3:		.float	0.0

bases4:		.word	 23,  12,  26,  16,  20,  16,  24,  15,  25,  16
		.word	 11,  27,  10,  27,  14,  25,  11,  27,  11,  29
		.word	 23,  12,  26,  16,  20,  16,  24,  16,  25,  12
		.word	 11,  23,  13,  20,  15,  29,  15,  28,  13,  25
		.word	 24,  11,  22,  13,  26,  14,  26,  13,  26,  13
		.word	 17,  24,  10,  22,  14,  25,  16,  22,  18,  22
		.word	 21,  13,  23,  10,  27,  11,  25,  18,  23,  15
		.word	 17,  26,  12,  27,  17,  27,  19,  27,  15,  24
		.word	 23,  14,  22,  13,  26,  14,  26,  12,  26,  13
		.word	 14,  23,  12,  23,  10,  21,  12,  23,  19,  22
		.word	 21,  17,  20,  17,  24,  15,  21,  17,  21,  19
		.word	 13,  22,  16,  26,  10,  26,  14,  26,  15,  22
		.word	 21,  13,  23,  10,  25,  19,  25,  18,  23,  15
		.word	 14,  21,  12,  23,  16,  24,  16,  23,  16,  23
		.word	 27,  14,  20,  12,  24,  15,  26,  12,  28,  12
		.word	 15,  26,  12,  27,  17,  27,  19,  27,  15,  24
		.word	 22,  13,  26,  10,  25,  12,  24,  18,  23,  12
		.word	 11,  22,  11,  23,  16,  29,  14,  22,  15,  21
		.word	 24,  14,  24,  13,  26,  14,  26,  12,  26,  13
		.word	 19,  24,  14,  24,  17,  23,  19,  21,  15,  26
		.word	 23,  12,  26,  16,  20,  16,  24,  15,  25,  16
		.word	 11,  23,  13,  20,  17,  21,  15,  28,  13,  25
		.word	 27,  16,  22,  17,  27,  17,  24,  17,  25,  14
		.word	 13,  24,  12,  23,  16,  24,  16,  22,  16,  23
		.word	 24,  19,  22,  13,  20,  11,  22,  19,  23,  12
		.word	 15,  26,  12,  27,  17,  27,  19,  27,  15,  24
		.word	 23,  13,  26,  10,  25,  12,  24,  18,  23,  12
		.word	 11,  22,  11,  23,  16,  24,  14,  22,  15,  21
		.word	 24,  14,  22,  13,  26,  14,  26,  12,  26,  13
		.word	 19,  24,  14,  24,  17,  23,  19,  21,  15
slants4:	.word	 25,  44,  43,  37,  33,  34,  34,  36,  14,  42
		.word	 16,  32,  32,  31,  46,  30,  34,  38,  21,  12
		.word	 32,  25,  37,  32,  37,  47,  27,  19,  32,  14
		.word	 39,  36,  22,  31,  27,  27,  29,  27,  25,  34
		.word	 34,  41,  42,  33,  16,  34,  46,  33,  36,  13
		.word	 31,  38,  37,  43,  28,  32,  31,  30,  35,  30
		.word	 37,  44,  30,  12,  34,  35,  36,  32,  38,  12
		.word	 33,  32,  46,  26,  31,  36,  14,  35,  15,  36
		.word	 37,  33,  33,  40,  35,  31,  34,  38,  33,  32
		.word	 34,  32,  34,  26,  27,  34,  36,  30,  36,  33
		.word	 22,  31,  36,  17,  20,  30,  31,  33,  32,  45
		.word	 37,  11,  19,  31,  33,  34,  35,  36,  25,  14
		.word	 19,  36,  22,  27,  37,  27,  39,  27,  15,  14
		.word	 21,  35,  35,  32,  31,  35,  30,  39,  32,  34
		.word	 11,  32,  31,  32,  31,  39,  34,  32,  35,  31
		.word	 35,  34,  33,  37,  23,  24,  14,  36,  14,  32
		.word	 26,  22,  22,  31,  36,  10,  24,  18,  18,  32
		.word	 32,  35,  37,  22,  17,  37,  17,  29,  28,  34
		.word	 34,  12,  14,  16,  37,  14,  16,  20,  16,  13
		.word	 22,  31,  36,  27,  34,  20,  21,  13,  32,  35
		.word	 27,  27,  39,  21,  23,  13,  25,  26,  25,  34
		.word	 39,  36,  22,  11,  36,  37,  37,  33,  35,  14
		.word	 24,  31,  32,  23,  26,  24,  26,  23,  16,  23
		.word	 11,  38,  17,  33,  18,  12,  11,  20,  25,  10
		.word	 17,  34,  20,  12,  14,  35,  36,  32,  18,  32
		.word	 13,  32,  36,  26,  11,  26,  24,  35,  35,  26
		.word	 17,  23,  33,  30,  25,  11,  14,  18,  23,  12
		.word	 29,  26,  32,  37,  37,  27,  39,  17,  25,  14
		.word	 21,  35,  25,  22,  17,  25,  10,  29,  12,  20
		.word	 31,  22,  11,  12,  21,  19,  24,  12,  35
len4:		.word	299
totalAreas4:	.space	1196
min4:		.word	0
max4:		.word	0
med4:		.word	0
estMed4:	.word	0
pctDiff4:	.float	0.0
sum4:		.word	0
fAve4:		.float	0.0

bases5:		.word	 19,  24,  17,  29,  12,  24,  16,  22,  12,  23
		.word	 20,  14,  26,  17,  24,  15,  26,  19,  28,  12
		.word	 11,  20,  11,  22,  19,  21,  11,  24,  12,  20
		.word	 23,  12,  22,  19,  20,  11,  21,  15,  28,  11
		.word	 12,  24,  15,  27,  11,  28,  13,  26,  16,  23
		.word	 21,  13,  24,  16,  21,  16,  25,  17,  29,  16
		.word	 15,  25,  15,  22,  17,  25,  10,  29,  12,  24
		.word	 20,  11,  21,  19,  20,  15,  21,  14,  28,  13
		.word	 11,  23,  14,  26,  10,  26,  15,  27,  10,  26
		.word	 24,  14,  22,  13,  26,  15,  26,  12,  26,  13
		.word	 14,  22,  17,  26,  17,  20,  16,  20,  16,  23
		.word	 23,  14,  27,  19,  22,  14,  26,  18,  22,  13
		.word	 15,  22,  16,  25,  10,  27,  13,  29,  12,  24
		.word	 26,  12,  22,  11,  26,  10,  24,  18,  24,  12
		.word	 17,  27,  17,  27,  17,  27,  17,  27,  17,  27
		.word	 27,  17,  29,  11,  23,  14,  25,  16,  25,  14
		.word	 14,  22,  14   26,  17,  24,  16,  20,  16,  23
		.word	 22,  15,  27,  12,  27,  17,  27,  19,  28,  13
		.word	 15,  22,  16,  25,  10,  27,  13,  29,  12,  24
		.word	 20,  10,  20,  13,  20,  13,  20,  11,  27,  13
		.word	 13,  22,  15,  22,  14,  21,  11,  23,  19,  29
		.word	 22,  14,  25,  17,  21,  18,  23,  16,  26,  11
		.word	 11,  23,  14,  26,  10,  26,  15,  27,  19,  26
		.word	 24,  11,  29,  11,  19,  11,  25,  11,  29,  11
		.word	 11,  23,  16,  29,  11,  23,  18,  22,  11,  27
		.word	 21,  14,  27,  19,  22,  14,  26,  18,  22,  13
		.word	 10,  21,  16,  27,  14,  25,  16,  29,  18,  22
		.word	 25,  15,  25,  12,  27,  15,  20,  19,  22,  14
		.word	 10,  21,  19,  29,  10,  25,  11,  24,  18,  23
		.word	 21,  13,  23,  16,  25,  16,  25,  17,  21,  16
		.word	 14,  24,  14,  23,  16,  24,  16,  22,  16,  23
		.word	 24,  12,  27,  16,  27,  14,  26,  10,  26,  13
		.word	 19,  24,  17,  29,  12,  24,  16,  28,  12,  23
		.word	 25,  12,  26,  15,  20,  17,  23,  19,  22,  14
		.word	 16,  22,  12,  21,  16,  20,  14,  28,  18,  22
		.word	 27,  17,  27,  17,  27,  11,  27,  17,  27,  17
		.word	 17,  27,  19,  21,  13,  24,  15,  26,  15,  24
		.word	 24,  12,  24   16,  27,  14,  26,  10,  26,  13
		.word	 12,  25,  17,  22,  17,  27,  17,  20,  18,  23
		.word	 25,  12,  26,  15,  20,  17,  23,  19,  22,  14
		.word	 11,  23,  16,  29,  11,  23,  18,  22,  11,  27
		.word	 21,  12,  21,  13,  25,  12,  21,  14,  23,  17
slants5:	.word	 52,  19,  25,  39,  31,  35,  39,  52,  44,  49
		.word	 23,  23,  13,  10,  05,  39,  23,  38,  23,  25
		.word	 21,  05,  27,  23,  16,  28,  21,  47,  31,  16
		.word	 22,  19,  35,  29,  11,  15,  19,  42,  44,  29
		.word	 51,  53,  16,  59,  21,  42,  34,  38,  31,  15
		.word	 12,  12,  22,  22,  32,  31,  20,  22,  11,  22
		.word	 13,  02,  20,  12,  12,  32,  22,  10,  12,  22
		.word	 10,  75,  37,  02,  17,  17,  37,  19,  28,  24
		.word	 12,  19,  25,  19,  31,  25,  39,  12,  14,  39
		.word	 22,  64,  38,  71,  25,  11,  32,  07,  21,  31
		.word	 12,  15,  57,  52,  57,  47,  27,  59,  18,  14
		.word	 59,  54,  56,  57,  54,  55,  16,  59,  48,  22
		.word	 41,  43,  46,  49,  51,  52,  54,  58,  61,  15
		.word	 59,  53,  54,  56,  40,  56,  15,  07,  55,  26
		.word	 52,  51,  16,  27,  10,  50,  51,  53,  52,  45
		.word	 47,  53,  53,  40,  15,  51,  54,  58,  53,  52
		.word	 31,  53,  54,  56,  40,  56,  25,  27,  10,  26
		.word	 34,  52,  14,  06,  17,  54,  56,  50,  56,  53
		.word	 42,  15,  57,  52,  57,  47,  17,  19,  28,  34
		.word	 19,  51,  59,  51,  49,  51,  09,  21,  29,  41
		.word	 23,  33,  53,  50,  25,  53,  43,  48,  53,  55
		.word	 21,  35,  57,  13,  26,  18,  21,  27,  34,  16
		.word	 32,  39,  15,  29,  50,  55,  59,  42,  14,  49
		.word	 41,  43,  46,  49,  31,  51,  54,  58,  11,  65
		.word	 50,  52,  52,  52,  52,  51,  22,  51,  26,  22
		.word	 22,  52,  52,  52,  33,  50,  12,  12,  52,  52
		.word	 22,  15,  57,  52,  57,  47,  17,  59,  18,  34
		.word	 52,  39,  55,  59,  51,  55,  59,  52,  54,  59
		.word	 34,  54,  58,  11,  15,  21,  32,  17,  11,  21
		.word	 41,  43,  46,  29,  51,  52,  54,  58,  11,  25
		.word	 12,  39,  15,  19,  11,  35,  39,  32,  54,  59
		.word	 21,  35,  37,  22,  17,  57,  27,  29,  28,  24
		.word	 19,  14,  16,  17,  24,  25,  36,  09,  18,  22
		.word	 51,  53,  31,  29,  21,  12,  54,  18,  11,  35
		.word	 19,  13,  24,  16,  20,  16,  25,  37,  25,  36
		.word	 12,  31,  26,  27,  30,  10,  11,  33,  10,  25
		.word	 52,  33,  13,  10,  25,  21,  24,  28,  23,  12
		.word	 11,  23,  34,  26,  10,  16,  35,  17,  20,  16
		.word	 44,  12,  14,  26,  17,  34,  16,  20,  16,  13
		.word	 12,  25,  17,  12,  17,  17,  37,  59,  38,  14
		.word	 29,  31,  19,  11,  29,  21,  49,  21,  29,  11
		.word	 51,  33,  26,  59,  21,  12,  24,  18,  11,  25
totalAreas5:	.space	1680
len5:		.word	420
min5:		.word	0
max5:		.word	0
med5:		.word	0
estMed5:	.word	0
pctDiff5:	.float	0.0
sum5:		.word	0
fAve5:		.float	0.0

# -----
#  Variables for main.

asstHeader:	.ascii	"\nMIPS Assignment #3\n"
		.asciiz	"Square Pyramid Total Areas Program\n\n"

# -----
#  Variables/constants for prtHeaders() function.

hdrTitle:	.ascii	"\n**********************************"
		.ascii	"**********************************"
		.asciiz	"\nSquare Pyramid Data Set #"
hdrLength:	.asciiz	"\nLength: "

hdrStats:	.asciiz	"\nTotal Areas Stats: \n"
hdrAreas:	.asciiz	"\n\nTotal Areas Values: \n"

# -----
#  Variables for totalAreasStats (if any)

fOneHundred:	.float	100.0

# -----
#  Variables/constants for combSort() function (if any).


# -----
#  Variables/constants for printResults() function.

spc:		.asciiz	"     "
newLine:	.asciiz	"\n"

str1:		.asciiz	"   min      = "
str2:		.asciiz	"\n   max      = "
str3:		.asciiz	"\n   med      = "
str4:		.asciiz	"\n   est med  = "
str5:		.asciiz	"\n   pct diff = %"
str6:		.asciiz	"\n   sum      = "
str7:		.asciiz	"\n   flt ave  = "


#####################################################################
#  text/code segment

# -----
#  Basic flow:
#	for each data set:
#	  * display headers
#	  * calculate total areas, includes sort
#	  * calculate total area stats (min, max, med, estMed, sum, and fAve)
#	  * display results

.text
.globl	main
.ent main
main:

# --------------------------------------------------------
#  Display Program Header.

	la	$a0, asstHeader
	li	$v0, 4
	syscall					# print header
	li	$s0, 1				# counter, data set number

# --------------------------------------------------------
#  Data Set #1

	move	$a0, $s0
	lw	$a1, len1
	jal	prtHeaders
	add	$s0, $s0, 1

#  Square pyramid total areas calculation function
#  HLL Call:
#	calcTotalAreas(totalAreas, len, bases, slants);

	la	$a0, totalAreas1
	lw	$a1, len1
	la	$a2, bases1
	la	$a3, slants1
	jal	calcTotalAreas

#  Calculate total areas stats.
#	Note, function also calls the median() and
#	estMedian() functions.
#  HLL Call:
#	totalAreasStats(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas1		# arg 1
	lw	$a1, len1			# arg 2
	la	$a2, min1			# arg 3
	la	$a3, max1			# arg 4
	subu	$sp, $sp, 20
	la	$t0, med1
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, estMed1
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, pctDiff1
	sw	$t0, 8($sp)			# arg 7, on stack
	la	$t0, sum1
	sw	$t0, 12($sp)			# arg 7, on stack
	la	$t6, fAve1
	sw	$t6, 16($sp)			# arg 8, on stack
	jal	totalAreasStats
	addu	$sp, $sp, 20			# clear stack

#  Show final total areas array stats.
#  HLL Call:
#	printResults(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas1		# arg 1
	lw	$a1, len1			# arg 2
	lw	$a2, min1			# arg 3
	lw	$a3, max1			# arg 4
	subu	$sp, $sp, 20
	lw	$t0, med1
	sw	$t0, ($sp)			# arg 5, on stack
	lw	$t0, estMed1
	sw	$t0, 4($sp)			# arg 6, on stack
	lw	$t0, pctDiff1
	sw	$t0, 8($sp)			# arg 7, on stack
	lw	$t0, sum1
	sw	$t0, 12($sp)			# arg 7, on stack
	l.s	$f6, fAve1
	s.s	$f6, 16($sp)			# arg 8, on stack
	jal	printResults
	addu	$sp, $sp, 20			# clear stack

# --------------------------------------------------------
#  Data Set #2

	move	$a0, $s0
	lw	$a1, len2
	jal	prtHeaders
	add	$s0, $s0, 1

#  Square pyramid total areas calculation function
#  HLL Call:
#	calcTotalAreas(totalAreas, len, bases, slants);

	la	$a0, totalAreas2
	lw	$a1, len2
	la	$a2, bases2
	la	$a3, slants2
	jal	calcTotalAreas

#  Calculate total areas stats.
#	Note, function also calls the median() and
#	estMedian() functions.
#  HLL Call:
#	totalAreasStats(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas2		# arg 1
	lw	$a1, len2			# arg 2
	la	$a2, min2			# arg 3
	la	$a3, max2			# arg 4
	subu	$sp, $sp, 20
	la	$t0, med2
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, estMed2
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, pctDiff2
	sw	$t0, 8($sp)			# arg 7, on stack
	la	$t0, sum2
	sw	$t0, 12($sp)			# arg 7, on stack
	la	$t6, fAve2
	sw	$t6, 16($sp)			# arg 8, on stack
	jal	totalAreasStats
	addu	$sp, $sp, 20			# clear stack

#  Show final total areas array stats.
#  HLL Call:
#	printResults(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas2		# arg 1
	lw	$a1, len2			# arg 2
	lw	$a2, min2			# arg 3
	lw	$a3, max2			# arg 4
	subu	$sp, $sp, 20
	lw	$t0, med2
	sw	$t0, ($sp)			# arg 5, on stack
	lw	$t0, estMed2
	sw	$t0, 4($sp)			# arg 6, on stack
	lw	$t0, pctDiff2
	sw	$t0, 8($sp)			# arg 7, on stack
	lw	$t0, sum2
	sw	$t0, 12($sp)			# arg 7, on stack
	l.s	$f6, fAve2
	s.s	$f6, 16($sp)			# arg 8, on stack
	jal	printResults
	addu	$sp, $sp, 20			# clear stack

# --------------------------------------------------------
#  Data Set #3

	move	$a0, $s0
	lw	$a1, len3
	jal	prtHeaders
	add	$s0, $s0, 1

#  Square pyramid total areas calculation function
#  HLL Call:
#	calcTotalAreas(totalAreas, len, bases, slants);

	la	$a0, totalAreas3
	lw	$a1, len3
	la	$a2, bases3
	la	$a3, slants3
	jal	calcTotalAreas

#  Calculate total areas stats.
#	Note, function also calls the median() and
#	estMedian() functions.
#  HLL Call:
#	totalAreasStats(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas3		# arg 1
	lw	$a1, len3			# arg 2
	la	$a2, min3			# arg 3
	la	$a3, max3			# arg 4
	subu	$sp, $sp, 20
	la	$t0, med3
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, estMed3
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, pctDiff3
	sw	$t0, 8($sp)			# arg 7, on stack
	la	$t0, sum3
	sw	$t0, 12($sp)			# arg 7, on stack
	la	$t6, fAve3
	sw	$t6, 16($sp)			# arg 8, on stack
	jal	totalAreasStats
	addu	$sp, $sp, 20			# clear stack

#  Show final total areas array stats.
#  HLL Call:
#	printResults(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas3		# arg 1
	lw	$a1, len3			# arg 2
	lw	$a2, min3			# arg 3
	lw	$a3, max3			# arg 4
	subu	$sp, $sp, 20
	lw	$t0, med3
	sw	$t0, ($sp)			# arg 5, on stack
	lw	$t0, estMed3
	sw	$t0, 4($sp)			# arg 6, on stack
	lw	$t0, pctDiff3
	sw	$t0, 8($sp)			# arg 7, on stack
	lw	$t0, sum3
	sw	$t0, 12($sp)			# arg 7, on stack
	l.s	$f6, fAve3
	s.s	$f6, 16($sp)			# arg 8, on stack
	jal	printResults
	addu	$sp, $sp, 20			# clear stack

# --------------------------------------------------------
#  Data Set #4

	move	$a0, $s0
	lw	$a1, len4
	jal	prtHeaders
	add	$s0, $s0, 1

#  Square pyramid total areas calculation function
#  HLL Call:
#	calcTotalAreas(totalAreas, len, bases, slants);

	la	$a0, totalAreas4
	lw	$a1, len4
	la	$a2, bases4
	la	$a3, slants4
	jal	calcTotalAreas

#  Calculate total areas stats.
#	Note, function also calls the median() and
#	estMedian() functions.
#  HLL Call:
#	totalAreasStats(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas4		# arg 1
	lw	$a1, len4			# arg 2
	la	$a2, min4			# arg 3
	la	$a3, max4			# arg 4
	subu	$sp, $sp, 20
	la	$t0, med4
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, estMed4
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, pctDiff4
	sw	$t0, 8($sp)			# arg 7, on stack
	la	$t0, sum4
	sw	$t0, 12($sp)			# arg 7, on stack
	la	$t6, fAve4
	sw	$t6, 16($sp)			# arg 8, on stack
	jal	totalAreasStats
	addu	$sp, $sp, 20			# clear stack

#  Show final total areas array stats.
#  HLL Call:
#	printResults(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas4		# arg 1
	lw	$a1, len4			# arg 2
	lw	$a2, min4			# arg 3
	lw	$a3, max4			# arg 4
	subu	$sp, $sp, 20
	lw	$t0, med4
	sw	$t0, ($sp)			# arg 5, on stack
	lw	$t0, estMed4
	sw	$t0, 4($sp)			# arg 6, on stack
	lw	$t0, pctDiff4
	sw	$t0, 8($sp)			# arg 7, on stack
	lw	$t0, sum4
	sw	$t0, 12($sp)			# arg 7, on stack
	l.s	$f6, fAve4
	s.s	$f6, 16($sp)			# arg 8, on stack
	jal	printResults
	addu	$sp, $sp, 20			# clear stack

# --------------------------------------------------------
#  Data Set #5

	move	$a0, $s0
	lw	$a1, len5
	jal	prtHeaders
	add	$s0, $s0, 1

#  Square pyramid total areas calculation function
#  HLL Call:
#	calcTotalAreas(totalAreas, len, bases, slants);

	la	$a0, totalAreas5
	lw	$a1, len5
	la	$a2, bases5
	la	$a3, slants5
	jal	calcTotalAreas

#  Calculate total areas stats.
#	Note, function also calls the median() and
#	estMedian() functions.
#  HLL Call:
#	totalAreasStats(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas5		# arg 1
	lw	$a1, len5			# arg 2
	la	$a2, min5			# arg 3
	la	$a3, max5			# arg 4
	subu	$sp, $sp, 20
	la	$t0, med5
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, estMed5
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, pctDiff5
	sw	$t0, 8($sp)			# arg 7, on stack
	la	$t0, sum5
	sw	$t0, 12($sp)			# arg 7, on stack
	la	$t6, fAve5
	sw	$t6, 16($sp)			# arg 8, on stack
	jal	totalAreasStats
	addu	$sp, $sp, 20			# clear stack

#  Show final total areas array stats.
#  HLL Call:
#	printResults(totalAreas, len, min, max, med, estMed,
#						pctDiff, sum, fAve);

	la	$a0, totalAreas5		# arg 1
	lw	$a1, len5			# arg 2
	lw	$a2, min5			# arg 3
	lw	$a3, max5			# arg 4
	subu	$sp, $sp, 20
	lw	$t0, med5
	sw	$t0, ($sp)			# arg 5, on stack
	lw	$t0, estMed5
	sw	$t0, 4($sp)			# arg 6, on stack
	lw	$t0, pctDiff5
	sw	$t0, 8($sp)			# arg 7, on stack
	lw	$t0, sum5
	sw	$t0, 12($sp)			# arg 7, on stack
	l.s	$f6, fAve5
	s.s	$f6, 16($sp)			# arg 8, on stack
	jal	printResults
	addu	$sp, $sp, 20			# clear stack

# --------------------------------------------------------
#  Done, terminate program.

	li	$v0, 10
	syscall					# au revoir...
.end

#####################################################################
#  Display headers.
#	Simple utility function to display formatted hgeaders
#	for each data set.

.globl	prtHeaders
.ent	prtHeaders
prtHeaders:
	sub	$sp, $sp, 8
	sw	$s0, ($sp)
	sw	$s1, 4($sp)

	move	$s0, $a0
	move	$s1, $a1

	la	$a0, hdrTitle
	li	$v0, 4
	syscall

	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, hdrLength
	li	$v0, 4
	syscall

	move	$a0, $s1
	li	$v0, 1
	syscall

	lw	$s0, ($sp)
	lw	$s1, 4($sp)
	add	$sp, $sp, 8

	jr	$ra
.end	prtHeaders

#####################################################################
#  MIPS assembly language void function to calculate the
#    total area for each square pyramid in a series of
#    square pyramids.

# -----
#  HLL Call:
#	calcTotalAreas(totalAreas, len, bases, slants)

#    Arguments:
#	$a0	- starting address of the total areas array
#	$a1	- starting address of the length
#	$a2	- starting address of the bases array
#	$a3	- starting address of the slants array

#    Returns:
#	totalAreas[] areas array via the passed address

.globl	calcTotalAreas
calcTotalAreas:


#	YOUR CODE GOES HERE


	jr	$ra
.end calcTotalAreas

#####################################################################
#  MIPS assembly language void function, combSort(), to sort
#    the areas array (small to large) using the comb sort
#    algorithm.

# -----
#  HLL Call:
#	combSort(array, len)

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length

#    Returns:
#	sorted list (via reference)

.globl combSort
.ent combSort
combSort:


#	YOUR CODE GOES HERE


	jr	$ra
.end combSort

#####################################################################
#  MIPS assembly langauge value returning function, median(),
#    to find the statistical median of an array.

# -----
#  HLL Call:
#	med = findMedian(array, len)

# -----
#    Arguments:
#	$a0   - integer
#	$a1   - len

#    Returns:
#	$v0   - median

.globl	findMedian
.ent	findMedian
findMedian:


#	YOUR CODE GOES HERE


	jr	$ra
.end	findMedian

#####################################################################
#  * MIPS assembly langauge, value returning function, estMedian(),
#    to find the estimated median of an array.

# -----
#  HLL Call:
#	med = estMedian(array, len)

# -----
#    Arguments:
#	$a0   - integer
#	$a1   - len

#    Returns:
#	$v0   - median

.globl	estMedian
.ent	estMedian
estMedian:


#	YOUR CODE GOES HERE


	jr	$ra
.end	estMedian

#####################################################################
#  MIPS assembly language void function, totalAreasStats(),
#    that will find the minimum, maximum, estimated median, median,
#    percentage difference (between the median and estimated medain),
#    sum, and float average of the total areas array.  The function
#    must call the median(), and estMedian() functions.
#    Additionally, the routine must call the combSort() function.
#    The estimated median must be determine before the sort.
#    The minimum, maximum, and statistical median must be
#    determined after the sort.

# -----
#  HLL Call:
#	totalAreasStats(areas, len, min, max, med, estMed,
#						pctDiff, sum, fAve)

# -----
#    Arguments:
#	$a0	- starting address of the areas array
#	$a1	- list length
#	$a2	- addr of min
#	$a3	- addr of max
#	($fp)	- addr of med
#	4($fp)	- addr of estMed
#	8($fp)  - addr of pctDiff
#	12($fp)	- addr of sum
#	16($fp)	- addr of fAve

#    Returns (via reference):
#	min, max, med, estMed, sum, fAve

.globl totalAreasStats
.ent totalAreasStats
totalAreasStats:


#	YOUR CODE GOES HERE


	jr	$ra
.end totalAreasStats

#####################################################################
#  MIPS assembly language function, printResults(), to display
#    the final statistical information to console.

#  Note, due to the system calls, the saved registers must be used.
#	As such, push/pop saved registers altered.

# HLL Call
#	printResults(areas, len, min, max, med, estMed,
#					pctDiff, sum, fAve)

# -----
#    Arguments:
#	$a0	- starting address of diags[]
#	$a1	- length
#	$a2	- min
#	$a3	- max
#	($fp)	- med
#	4($fp)	- estMed
#	8($fp)	- pctDiff (flt)
#	12($fp)	- sum
#	16($fp)	- fAve (flt)

#    Returns:
#	N/A

.globl	printResults
.ent	printResults
printResults:


#	YOUR CODE GOES HERE


	jr	$ra
.end printResults

#####################################################################

