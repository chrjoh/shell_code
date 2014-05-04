reverse_shell
=============

program that call out to a service that is listening to port 4444, the ip is set to any for simplicity.

It is written for mac osx 64 bit

Usage:
  Start a listening server with the command: nc -l 4444 in another folder for example your home directory

  nasm -g -f macho64 reverse_shell.s
  ld  -arch x86_64 -macosx_version_min 10.7.0 -lSystem -o reverse_shell reverse_shell.o
  run ./reverse_shell
  
  Go back to the terminal that you started nc in and type ls, you should now see a directory listing of the directory you started
  reverse_shell in.
  
To use the code as a payload, one need to remove the NULL values, these can be found by running: otool -lV reverse_shell and identify
the mov instructions that need to be modified. See the code for two example on how to change the mov instruction