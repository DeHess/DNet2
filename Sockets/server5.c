// Server side C/C++ program to demonstrate Socket programming
// adopted by Karl Rege from sample of
// https://www.geeksforgeeks.org/socket-programming-cc/
// for windows: Link with ws2_32 library.
// gcc server.c -lws2_32 -o server.exe
// platform: Linux and Windows

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
    #include <netdb.h>
#endif

#define BUFSIZE 1024
#define PORT 8000
char* rank[10] = {
		"Mueller Stefan;02:31:14\n",
		"Marti Adrian;02:30:09\n",
		"Kiptum Daniel;02:11:31\n",
		"Ancay Tarcis;02:20:02\n",
		"Kreibuhl Christian;02:21:47\n",
		"Ott Michael;02:33:48\n",
		"Menzi Christoph;02:27:26\n",
		"Oliver Ruben;02:32:12\n",
		"Elmer Beat;02:33:53\n",
		"Kuehni Martin;02:33:36\n"
};
#ifdef WIN32
char* GetErrorMessage(DWORD dwErrorCode) { 
    static char* pBuffer = NULL;
    DWORD cchBufferLength = 200;
    if (pBuffer == NULL) { // only allocate once
        pBuffer = malloc(cchBufferLength*sizeof(char));
    }
    pBuffer[0] = '\0';
    DWORD cchMsg = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
                                 NULL, dwErrorCode, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
                                 pBuffer, cchBufferLength, NULL);
    return pBuffer ;
}
#else
int GetLastError() {
    return errno;
}
char* GetErrorMessage(int dwErrorCode) { 
    return strerror(dwErrorCode);
}    
#endif

void sleep_ms(int milliseconds) { // cross-platform sleep function
#ifdef WIN32
    Sleep(milliseconds);
#else
    usleep(milliseconds * 1000);
#endif
}

void error(char* msg){
    int err = GetLastError();
    fprintf(stderr,"%s \n",msg);
    fprintf(stderr,"ERROR %d %s \n",err, GetErrorMessage(err));
}

// send data immediately but degrades performance
void send_nodelay(int sock, char* msg, int len, int d) {
    int flag = 1; 
    setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, (char *) &flag, sizeof(int));
    send(sock, msg, len , d);
    flag = 0; 
    setsockopt(sock, IPPROTO_TCP, TCP_NODELAY, (char *) &flag, sizeof(int));
    sleep_ms(1);  // to give the socket thread the time to send
}

int main(int argc, char const *argv[]) {
    int server_fd, sock, valread;
    struct sockaddr_in address;
    int i, opt = 1;
    int addrlen = sizeof(address);
    char buffer[BUFSIZE] = {0};

#ifdef WIN32
    // Initialize Winsock
    WSADATA wsaData;
    if (WSAStartup(MAKEWORD(2,2), &wsaData) != 0) {
        error("init failed");
		exit(EXIT_FAILURE);
    }
#endif

    // Creating socket file descriptor
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        error("socket failed");
        exit(EXIT_FAILURE);
    }
    
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(PORT);
       
    // Forcefully attaching socket to the port 
    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address))<0) {
        error("bind failed");
        exit(EXIT_FAILURE);
    }
    printf("listen on port %d... \n",PORT);
    if (listen(server_fd, 3) < 0) {
        error("listen failed");
        exit(EXIT_FAILURE);
    }
   
    while (1) {
		printf("accepting ...\n");
		fflush(stdout);
		if ((sock = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen))<0) {
			error("accept failed");
			continue;
		}
	
	// send line
#if defined(WIN32) || !defined(FILEDESC)
		for (i = 0; i < 10; i++) {
			send_nodelay(sock , rank[i] , strlen(rank[i]) , 0);
			printf (".");
		}
#else
	    int fd_copy = dup(sock);
        FILE *write_fh = fdopen(fd_copy, "w");
        int i;
		for (i = 0; i < 10; i++) {   
			fprintf(write_fh,"%s", rank[i]);
			fflush(write_fh);
			sleep_ms(1);
		}
#endif
		printf("\nSENT: %d lines\n",i);
		sleep_ms(100);
		shutdown (sock,2);
	}
    return 0;
}