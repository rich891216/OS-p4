#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"

void loop(int sleepticks) {
    // sleep for <sleepticks> seconds
    sleep(sleepticks);
    int i = 0, j = 0;
    while (i < 800000000) {
        j += i * j + 1;
        i++;
    }
}
int main(int argc, char *argv[]) {
    if (argc != 2) {
        // incorrect number of arguments
        exit();
    }
    int sleepticks = atoi(argv[1]);
    if (sleepticks == 0) {
        // argv[1] can't be coverted
        exit();
    }
    loop(sleepticks);
    return 0;
}
