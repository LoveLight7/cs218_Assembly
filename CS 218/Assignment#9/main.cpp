// CS 218 - Provided C++ program
//	This programs calls assembly language routines.

//  NOTE: To compile this program, and produce an object file
//	must use the "g++" compiler with the "-c" option.

//  Must ensure g++ compiler is installed:
//	sudo apt-get install g++

// ***************************************************************

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <string>
#include <iomanip>

using namespace std;

#define SUCCESS 0
#define NOSUCCESS 1

#define MIN_LENGTH 5
#define MAX_LENGTH 500

#define SUCCESS 0
#define NOSUCCESS 1
#define OUTOFRANGE 2
#define INPUTOVERFLOW 3
#define ENDOFINPUT 4


// ***************************************************************
//  Prototypes for external functions.
//	The "C" specifies to use the C-style standard calling convention.

extern "C" void combSort (int[], int);
extern "C" void basicStats (int[], int, int *, int *, int *, int *, int *);
extern "C" int intStdDev(int[], int, int);
extern "C" int readDozenalNumber (int *);


// ***************************************************************

int main()
{

// --------------------------------------------------------------------
//  Declare variables and display header
//	Note, by default, C++ integers are doublewords (32-bits).

	string	bars;
	bars.append(50,'-');

	int	status, newNumber;
	int	list[MAX_LENGTH];
	int	len = 0;
	int	min, max, med, sum, ave, iStd;
	bool	endOfNumbers = false;

	cout << bars << endl;
	cout << "CS 218 - Assignment #9" << endl << endl;

// --------------------------------------------------------------------
//  Loop to read numbers from user
//	prompts user
//	reads number (which returns a status)
//	checks status

	while (!endOfNumbers) {
		printf ("Enter Dozenal Value: " );
		fflush(stdout);
		status = readDozenalNumber(&newNumber);

		switch (status) {
			case SUCCESS:
				list[len] = newNumber;
				len++;
				break;
			case NOSUCCESS:
				printf ("Error, invalid number.  Please re-enter.\n");
				break;
			case OUTOFRANGE:
				printf ("Error, number of out of range.  Please re-enter.\n");
				break;
			case INPUTOVERFLOW:
				printf ("Error, input too long.  Please re-enter.\n");
				break;
			case ENDOFINPUT:
				endOfNumbers = true;
				break;
			default:
				printf ("Error, invalid return status.  Program terminated\n");
				exit(EXIT_FAILURE);
				break;
		}
		if (len > MAX_LENGTH)
			break;
	}

// --------------------------------------------------------------------
//  Ensure some numbers were read and, if so, display results.

	if (len < MIN_LENGTH) {
		cout << "Error, not enough numbers entered." << endl;
		cout << "Program terminated." << endl;
	} else {
		cout << "\n---------------------------------------------------------------";
		cout << endl << "Program Results" << endl << endl;

		combSort (list, len);
		basicStats (list, len, &min, &max, &med, &sum, &ave);
		iStd = intStdDev(list, len, ave);

		cout << "Sorted List: " << endl;

		for (int i=0; i < len; i++) {
			cout << list[i] << "  ";
			if ( i%10==9 || i==(len-1) ) cout << endl;
		}

		cout << "\nStatistical Results:\n"<< endl;

		cout << "              Length =  " << setw(12) << len << endl;
		cout << "             Minimum =  " << setw(12) << min << endl;
		cout << "             Maximum =  " << setw(12) << max << endl;
		cout << "              Median =  " << setw(12) << med << endl;
		cout << "                 Sum =  " << setw(12) << sum << endl;
		cout << "             Average =  " << setw(12) << ave << endl;
		cout << "  Standard Deviation =  " << setw(12) << iStd << endl;
		cout << endl;
	}

// --------------------------------------------------------------------
//  All done...

	return 0;

}

