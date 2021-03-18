#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

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
	uint ticks0;
	struct proc *p = myproc(); // proc to put to sleep

	if (argint(0, &n) < 0)
		return -1;
	acquire(&tickslock);
	ticks0 = ticks;

	p->deadline = ticks0 + n;
	p->compticks = n;
	if (myproc()->killed)
	{
		release(&tickslock);
		return -1;
	}
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

int sys_setslice(void)
{
	int pid;
	int sticks;
	if (argint(0, &pid) < 0) {
		return -1;
	}
	if (argint(0, &sticks) < 0) {
		return -1;
	}
	return setslice(pid, (uint)sticks);
}

int sys_getslice(void)
{
	int pid;
	if(argint(0, &pid) < 0) {
		return -1;
	}
	return getslice(pid);
}

int sys_fork2(void)
{
	int slice;
	if (argint(0, &slice) < 0) {
		return -1;
	}
	return fork2(slice);
}

int sys_getpinfo(void)
{
	struct pstat *p;
	if(argptr(0, (void*)&p, sizeof(p)) < 0) {
		return -1;
	}
	return getpinfo(p);
}