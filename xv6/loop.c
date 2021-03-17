#include "user.h"
#include "syscall.h"

int main(int argc, char *argv[]) {
    if (argc != 2) {
        // incorrect number of arguments
        exit(1);
    }
    int sleepticks = atoi(argv[1]);
    if (sleepticks == 0) {
        // argv[1] can't be coverted
        exit(1);
    }
    // sleep for <sleepticks> seconds
    
    int i = 0, j = 0;
    while (i < 800000000) {
        j += i * j + 1;
        i++;
    }
}
