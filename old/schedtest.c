#include "types.h"
#include "user.h"
#include "syscall.h"
#include <stddef.h>

int main(int argc, char *argv[]) {
    if (argc != 6) {
        // incorrect number of arguments
        exit();
    }
    int sliceA = atoi(argv[1]);
    char *sleepA = argv[2];
    int sliceB = atoi(argv[3]);
    char *sleepB = argv[4];
    int sleepParent = atoi(argv[5]);


    int childA = fork2(sliceA);
    if(childA == 0) {
        char *args[] = {"./loop", sleepA, NULL};
        // exec
        exec("./loop", args);
    } else {
        int childB = fork2(sliceB);
        if(childB == 0) {
            char *args[] = {"./loop", sleepB, NULL};
            // exec
            exec("./loop", args);
        } else {
            // parent
            sleep(sleepParent);
            printf(1, "parent slept");
            // getpinfo
        }
    }
    return 0;
}
