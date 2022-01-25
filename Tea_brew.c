#include<stdio.h>
#include<time.h>
#include <stdio.h> 
#include <stdio.h>   
#include <unistd.h>  
#include <fcntl.h>   
#include <termios.h> 
#include <signal.h>

#define COM 9

int main()
{
    short portfd=- COM;
    int n,f,len, stat;
    char buf[8],*s;

        portfd = open("/dev/ttyUSB0", O_RDWR|O_NDELAY);
        if (portfd >= 0){
            printf("port openend\n");
            n = fcntl(portfd, F_GETFL, 0);
            (void) fcntl(portfd, F_SETFL, n & ~O_NDELAY);
        }
        
        portfd = open("/dev/ttyUSB0", O_RDWR);

        if (portfd >= 0) 
        {
            if (len == 0) len = strlen(s);
            for(f = 0; f < len && f <100; f++)
                buf[f] = *s++ | 0x80;
            write(portfd, buf, f);
            printf("Do write\n");
            while(portfd>=0){
                printf("%s\n",buf);
                for (int i = 0, i < 9, i++)
                {
                    if (buf[i] = 1){
                        stat = 1;
                    }
                    else{
                        stat = 0;
                    }
                }
                if (stat = 1;){
                    time_t t;
                    t = time(NULL);
                    struct tm tm;
                    tm = *localtime(&t);
                    printf("Current Date: %d-%d-%d\n", tm.tm_mday, tm.tm_mon+1, tm.tm_year+1900);
                    printf("Current Time: %d:%d:%d", tm.tm_hour, tm.tm_min, tm.tm_sec);
                    return 0;
                }
            }
        }

    signal(SIGALRM, SIG_IGN);
    if (portfd < 0) {
        printf("Cannot Open %s. \n", "/dev/ttyUSB0");
    }
}