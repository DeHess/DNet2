// Client side C/C++ program to demonstrate Socket programming
// adopted by Karl Rege from sample of
// https://www.geeksforgeeks.org/socket-programming-cc/
// for windows: Link with ws2_32 library.
// gcc client.c -lws2_32 -o client.exe

#ifdef _MSC_VER
    #include <Ws2tcpip.h>
    #include <Mswsock.h>
#else
    #include <unistd.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef WIN32
    #include <Winsock2.h>
    #include <windows.h> 
    #include <wininet.h>
    #include <stdlib.h>
    typedef int socklen_t;
#else
    #include <unistd.h>
    #include <errno.h>
    #include <sys/socket.h>
    #include <sys/ioctl.h>
    #include <netinet/in.h>
    #include <netinet/tcp.h>
    #include <arpa/inet.h>
    #include <netdb.h>
int GetLastError() {return errno;}        
#endif

#define BUFSIZE 1024
#define IPPORT 8000
char IPADDR[] = "127.0.0.1";
   
// connect socket
int connectSocket(char* ipAddr, int port) {
    int error;
    int sock = 0;
    static struct sockaddr_in serv_addr;

#ifdef WIN32
    // Initialize Winsock
    WSADATA wsaData;
    if (WSAStartup(MAKEWORD(2,2), &wsaData) != 0) {
        return -WSAGetLastError();
    }
#endif
    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0) return -GetLastError();
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);
    serv_addr.sin_addr.s_addr = inet_addr(ipAddr);
    
    if (connect(sock, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) return -GetLastError();    
    return sock;
}

// read line from socket
char* sgets(char* buffer, int bufsize, int sock) {
    int valread = recv( sock , buffer, bufsize,0);
    buffer[valread] = '\0';
    return (valread > 0)?buffer:NULL;
}
   
int main(int argc, char const *argv[]) {
    int sock = 0;
    char buffer[BUFSIZE] = {0};
    sock = connectSocket(IPADDR,IPPORT);
    if (sock > 0) {
        // receiving
        while (sgets(buffer,BUFSIZE,sock) != NULL) {
            printf("RECEIVED: %s",buffer );
        }
    } else {
        fprintf(stderr,"\nSocket error %d\n",-sock);
    }
    shutdown (sock,2);
    close(sock);
    return 0;
}