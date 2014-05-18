shell_code
=============
Various shell code programs for osx 64 bit system. In each subproject there is a makefile to compile the different sources.

#### reverse_shell
  Program that call out to a service that is listening to port 4444, the ip is set to any for simplicity. 

#### bindshell
  bindshell start a listening server that you can connect to with the command: `nc -nv 127.0.0.1 4444` in another folder for example your home directory
  (Had some problem with the code, but @norsec0de and @TheColonial helped me to fix it, big thx to them for the help)
