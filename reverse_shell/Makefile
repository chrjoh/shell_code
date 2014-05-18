CC=clang
CFLAGS= -Wall -Wextra -pedantic -O2 
FILE= reverse_shell_test


all: ${FILE}

tester: ${FILE}.c
	${CC} ${CFLAGS} ${FILE}.c -o ${FILE}

reverse_cleaned: reverse_shell_no_bad_values.s
	nasm -f macho64 reverse_shell_no_bad_values.s -o reverse_shell_no_bad_values.o
	ld  -arch x86_64 -macosx_version_min 10.7.0 -lSystem reverse_shell_no_bad_values.o -o reverse_shell_no_bad_values

reverse: reverse_shell.s
	nasm -f macho64 reverse_shell.s -o reverse_shell.o
	ld  -arch x86_64 -macosx_version_min 10.7.0 -lSystem reverse_shell.o -o reverse_shell

clean:
	rm -rf ${FILE} 2> /dev/null || true
	rm -rf *.dSYM/ 2> /dev/null || true
	rm *.o reverse_shell_no_bad_values reverse_shell 2> /dev/null || true
