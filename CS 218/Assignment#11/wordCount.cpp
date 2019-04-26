// ----------------------------------------------------------------------
//  CS 218 -> Assignment #11
//  Word count program.
//  Provided main...

#include <cstdlib>
#include <iostream>

using	namespace	std;


// ----------------------------------------------------------------------
//  External functions (in seperate file).

extern "C" bool checkParameters(int, char *[], char [], bool *, long *);
extern "C" bool getWord(char [], int, long);
extern "C" void checkWord(char [], char [], bool, unsigned int *);
extern "C" void displayResults(char [], unsigned int);


// ----------------------------------------------------------------------
//  Main routine.

int main(int argc, char* argv[])
{
	static	const	unsigned int	MAXWORDLENGTH=80;
	char		searchWord[MAXWORDLENGTH+1];
	char		currentWord[MAXWORDLENGTH+1];
	long		rdFileDesc;
	bool		matchCase = false;
	unsigned int	wordCount=0;

	// check command line parameters
	if (checkParameters(argc, argv, searchWord, &matchCase, &rdFileDesc)) {

		// get next word
		while (getWord(currentWord, MAXWORDLENGTH, rdFileDesc)) {

			// check word against search word, update count as appropriate
			checkWord(searchWord, currentWord, matchCase, &wordCount);
		}

		// show final results
		displayResults(searchWord, wordCount);
	}


	return 0;
}

