#include "types.h"
#include "user.h"
#include "syscall.h"
#include <stddef.h>
#include "pstat.h"
#include "param.h"

// static int schedtestFork(int slice, char *sleepT) {
// 	int pid = fork2(slice);
// 	int child = -1;

// 	if (pid != -1) {
// 		if (pid == 0) {
// 			child = getpid();
// 			char *args[] = {"loop", sleepT};
// 			exec(args[0], args);

// 			printf(2, "exec failed\n");
// 			exit();
// 		} else {
// 			wait();
// 		}
// 	} else {
// 		printf(2, "fork failed\n");
// 	}
// 	return child;
// }

int main(int argc, char *argv[]) {
    if (argc != 6) {
		printf(2, "Usage: schedtest sliceA sleepA sliceB sleepB sleepParent\n");
		exit();
	}
    int sliceA = atoi(argv[1]);
    char *sleepA = argv[2];
    int sliceB = atoi(argv[3]);
    char *sleepB = argv[4];
    int sleepParent = atoi(argv[5]);
	struct pstat ps;

	// int childA = schedtestFork(sliceA, sleepA);
	// int childB = schedtestFork(sliceB, sleepB);

	int childA = fork2(sliceA);
	int childB = 0;
	if (childA == 0) {
		char *args[] = {"loop", sleepA, 0};
		exec(args[0], args);
		exit();
	} else if ((childB = fork2(sliceB)) == 0) {
		char *args[] = {"loop", sleepB, 0};
		exec(args[0], args);
		exit();
	} else {
		wait();
		sleep(sleepParent);
		int compticksA = 0;
		int compticksB = 0;
		if (getpinfo(&ps) == 0) {
			for(int i = 0; i < NPROC; i++) {
				if (childA == ps.pid[i]) {
						compticksA = ps.compticks[i];
				} else if (childB == ps.pid[i]) {
					compticksB = ps.compticks[i];
				}
			}
			printf(1, "%d %d\n", compticksA, compticksB);
			exit();
		}
	}

	// sleep(sleepParent);

	// int compticksA = 0;
	// int compticksB = 0;

	// if (getpinfo(&ps) == 0) {
	// 	for (int i = 0; i < NPROC; i++) {
	// 		if (childA == ps.pid[i]) {
	// 			compticksA = ps.compticks[i];
	// 		}

	// 		if (childB == ps.compticks[i]) {
	// 			compticksB = ps.compticks[i];
	// 		}
	// 	}
	// 	printf(1, "%d %d\n", compticksA, compticksB);
	// } else {
	// 	printf(2, "Error: Could not access ptable correctly.\n");
	// }
	exit();
}
