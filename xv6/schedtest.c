#include "user.h"
#include "pstat.h"

int main(int argc, char **argv) {
    // takes exactly 5 arguments
    if(argc != 6){
        printf(2, "We need exactly 6 arguments.\n");
        exit();
    }

    int sliceA = atoi(argv[1]);
    char *sleepA = argv[2];
    int sliceB = atoi(argv[3]);
    char *sleepB = argv[4];
    int sleepParent = atoi(argv[5]);
	struct pstat ps;

	int compticksA = 0;
	int compticksB = 0;

	int childA = fork2(sliceA);
    if (childA == 0){
        char *args[] = {"loop", sleepA, 0};
        exec("loop", args);
    }
  
    int childB = fork2(sliceB);
    if (childB == 0){
        char *args[] = {"loop", sleepB, 0};
        exec("loop", args);
    }
    sleep(sleepParent);

    if (getpinfo(&ps) == 0){
        for (int i = 0; i < NPROC; i++) {
            if (childA == ps.pid[i]) {
                compticksA = ps.compticks[i];
            }
            if (childB == ps.pid[i]) {
                compticksB = ps.compticks[i];
            }
        }
        printf(1, "%d %d\n", compticksA, compticksB); 
    }
    wait();
    wait();
    exit(); 
}