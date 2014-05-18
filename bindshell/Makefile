CC=clang
CFLAGS= -Wall -Wextra -pedantic -O2 
FILE= bindshell_test


all: ${FILE}

tester: ${FILE}.c
	${CC} ${CFLAGS} ${FILE}.c -o ${FILE}

bind_cleaned: bindshell_no_bad_values.s
	nasm -f macho64 bindshell_no_bad_values.s -o bindshell_no_bad_values.o
	ld  -arch x86_64 -macosx_version_min 10.7.0 -lSystem bindshell_no_bad_values.o -o bindshell_no_bad_values

bind: bindshell.s
	nasm -f macho64 bindshell.s -o bindshell.o
	ld  -arch x86_64 -macosx_version_min 10.7.0 -lSystem bindshell.o -o bindshell

clean:
	@rm -rf ${FILE} 2> /dev/null || true
	@rm -rf *.dSYM/ 2> /dev/null || true
	@rm *.o bindshell_no_bad_values bindshell 2> /dev/null || true
