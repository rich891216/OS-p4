#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "pstat.h"

int sys_fork(void)
{
	return fork();
}

int sys_exit(void)
{
	exit();
	return 0; // not reached
}

int sys_wait(void)
{
	return wait();
}

int sys_kill(void)
{
	int pid;

	if (argint(0, &pid) < 0)
		return -1;
	return kill(pid);
}

int sys_getpid(void)
{
	return myproc()->pid;
}

int sys_sbrk(void)
{
	int addr;
	int n;

	if (argint(0, &n) < 0)
		return -1;
	addr = myproc()->sz;
	if (growproc(n) < 0)
		return -1;
	return addr;
}

int sys_sleep(void)
{
	int n;
	struct proc *p = myproc();

	if (argint(0, &n) < 0)
		return -1;
	acquire(&tickslock);
	
	p->sleepdeadline = n;
	sleep(&ticks, &tickslock);

	release(&tickslock);
	return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
	uint xticks;

	acquire(&tickslock);
	xticks = ticks;
	release(&tickslock);
	return xticks;
}

// sets time slice for given proc
int sys_setslice(void)
{
	int pid;
	int slice;
	if (argint(0, &pid) < 0 || argint(1, &slice))
	{
		return -1;
	}
	else
	{
		return setslice(pid, slice);
	}
}

// gets time slice given pid
int sys_getslice(void)
{
	int pid;
	if (argint(0, &pid) < 0)
	{
		return -1;
	}
	else
	{
		return getslice(pid);
	}
}

//fork2, same as fork except can set time slice
int sys_fork2(void)
{
	int slice;
	if (argint(0, &slice) < 0)
	{
		return -1;
	}
	else
	{
		return fork2(slice);
	}
}

//gets pstat's information
int sys_getpinfo(void)
{
	struct pstat *ps;
	if (argptr(0, (void *)&ps, sizeof(*ps)) < 0) //ps is invalid
	{
		return -1;
	}
	else
	{
		return getpinfo(ps);
	}
}