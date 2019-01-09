#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
 
int main(void)
{
	regex_t    preg;
	char       *aim = "a very simple simple simple string se sre";
	char       *pattern = "s.*?e";
	int        rc;
	int status, i;
	char    buffer[100];

	size_t     nmatch = 1;
	regmatch_t pmatch[1];
 
	regcomp(&preg, pattern, REG_EXTENDED);
	rc = regexec(&preg, aim, nmatch, pmatch, 0);

	if ( rc != 0 ) {
		regerror(rc, &preg, buffer, 100);
		printf("Failed to match '%s' with '%s'\nReturning %d.\nError: %s",
			aim, pattern, rc, buffer);
	} else {
		status = regexec(&preg, aim, nmatch, pmatch, 0);
		if ( status == 0 ) {
			for(i = pmatch[0].rm_so; i<pmatch[0].rm_eo; ++i) {
				putchar(aim[i]);
			}
			printf("\nwith pattern: %s", pattern);
		}
	}
	regfree(&preg);
	return 0;
/*
	c的regex.h（POSIX的regex库）不支持非贪婪匹配——都为贪婪匹配！
*/
}
