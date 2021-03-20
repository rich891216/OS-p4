
_loop:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"
int main(int argc, char *argv[]) {
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	8b 41 04             	mov    0x4(%ecx),%eax
    if (argc != 2) {
  16:	83 39 02             	cmpl   $0x2,(%ecx)
  19:	74 05                	je     20 <main+0x20>
        // incorrect number of arguments
        exit();
  1b:	e8 35 02 00 00       	call   255 <exit>
    }
    int sleepticks = atoi(argv[1]);
  20:	83 ec 0c             	sub    $0xc,%esp
  23:	ff 70 04             	pushl  0x4(%eax)
  26:	e8 c0 01 00 00       	call   1eb <atoi>
  2b:	89 c3                	mov    %eax,%ebx
    if (sleepticks <= 0) {
  2d:	83 c4 10             	add    $0x10,%esp
  30:	85 c0                	test   %eax,%eax
  32:	7e 3c                	jle    70 <main+0x70>
        // argv[1] can't be coverted
        printf(2, "sleepticks is negative\n");
        exit();
    }
    printf(1, "sleeping for %d ticks\n", sleepticks);
  34:	83 ec 04             	sub    $0x4,%esp
  37:	50                   	push   %eax
  38:	68 8c 06 00 00       	push   $0x68c
  3d:	6a 01                	push   $0x1
  3f:	e8 72 03 00 00       	call   3b6 <printf>
    sleep(sleepticks);
  44:	89 1c 24             	mov    %ebx,(%esp)
  47:	e8 99 02 00 00       	call   2e5 <sleep>
    printf(1, "slept for %d ticks\n", sleepticks);
  4c:	83 c4 0c             	add    $0xc,%esp
  4f:	53                   	push   %ebx
  50:	68 a3 06 00 00       	push   $0x6a3
  55:	6a 01                	push   $0x1
  57:	e8 5a 03 00 00       	call   3b6 <printf>
	
    int i = 0;
    int j = 0;
    while (i < 800000000) {
  5c:	83 c4 10             	add    $0x10,%esp
    int i = 0;
  5f:	b8 00 00 00 00       	mov    $0x0,%eax
    while (i < 800000000) {
  64:	3d ff 07 af 2f       	cmp    $0x2faf07ff,%eax
  69:	7f 19                	jg     84 <main+0x84>
        j += i * j + 1;
        i++;
  6b:	83 c0 01             	add    $0x1,%eax
  6e:	eb f4                	jmp    64 <main+0x64>
        printf(2, "sleepticks is negative\n");
  70:	83 ec 08             	sub    $0x8,%esp
  73:	68 74 06 00 00       	push   $0x674
  78:	6a 02                	push   $0x2
  7a:	e8 37 03 00 00       	call   3b6 <printf>
        exit();
  7f:	e8 d1 01 00 00       	call   255 <exit>
    }
    printf(1, "loop done\n");
  84:	83 ec 08             	sub    $0x8,%esp
  87:	68 b7 06 00 00       	push   $0x6b7
  8c:	6a 01                	push   $0x1
  8e:	e8 23 03 00 00       	call   3b6 <printf>
    exit();
  93:	e8 bd 01 00 00       	call   255 <exit>

00000098 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  98:	f3 0f 1e fb          	endbr32 
  9c:	55                   	push   %ebp
  9d:	89 e5                	mov    %esp,%ebp
  9f:	56                   	push   %esi
  a0:	53                   	push   %ebx
  a1:	8b 75 08             	mov    0x8(%ebp),%esi
  a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a7:	89 f0                	mov    %esi,%eax
  a9:	89 d1                	mov    %edx,%ecx
  ab:	83 c2 01             	add    $0x1,%edx
  ae:	89 c3                	mov    %eax,%ebx
  b0:	83 c0 01             	add    $0x1,%eax
  b3:	0f b6 09             	movzbl (%ecx),%ecx
  b6:	88 0b                	mov    %cl,(%ebx)
  b8:	84 c9                	test   %cl,%cl
  ba:	75 ed                	jne    a9 <strcpy+0x11>
    ;
  return os;
}
  bc:	89 f0                	mov    %esi,%eax
  be:	5b                   	pop    %ebx
  bf:	5e                   	pop    %esi
  c0:	5d                   	pop    %ebp
  c1:	c3                   	ret    

000000c2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c2:	f3 0f 1e fb          	endbr32 
  c6:	55                   	push   %ebp
  c7:	89 e5                	mov    %esp,%ebp
  c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  cf:	0f b6 01             	movzbl (%ecx),%eax
  d2:	84 c0                	test   %al,%al
  d4:	74 0c                	je     e2 <strcmp+0x20>
  d6:	3a 02                	cmp    (%edx),%al
  d8:	75 08                	jne    e2 <strcmp+0x20>
    p++, q++;
  da:	83 c1 01             	add    $0x1,%ecx
  dd:	83 c2 01             	add    $0x1,%edx
  e0:	eb ed                	jmp    cf <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
  e2:	0f b6 c0             	movzbl %al,%eax
  e5:	0f b6 12             	movzbl (%edx),%edx
  e8:	29 d0                	sub    %edx,%eax
}
  ea:	5d                   	pop    %ebp
  eb:	c3                   	ret    

000000ec <strlen>:

uint
strlen(const char *s)
{
  ec:	f3 0f 1e fb          	endbr32 
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f6:	b8 00 00 00 00       	mov    $0x0,%eax
  fb:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  ff:	74 05                	je     106 <strlen+0x1a>
 101:	83 c0 01             	add    $0x1,%eax
 104:	eb f5                	jmp    fb <strlen+0xf>
    ;
  return n;
}
 106:	5d                   	pop    %ebp
 107:	c3                   	ret    

00000108 <memset>:

void*
memset(void *dst, int c, uint n)
{
 108:	f3 0f 1e fb          	endbr32 
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	57                   	push   %edi
 110:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 113:	89 d7                	mov    %edx,%edi
 115:	8b 4d 10             	mov    0x10(%ebp),%ecx
 118:	8b 45 0c             	mov    0xc(%ebp),%eax
 11b:	fc                   	cld    
 11c:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 11e:	89 d0                	mov    %edx,%eax
 120:	5f                   	pop    %edi
 121:	5d                   	pop    %ebp
 122:	c3                   	ret    

00000123 <strchr>:

char*
strchr(const char *s, char c)
{
 123:	f3 0f 1e fb          	endbr32 
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	8b 45 08             	mov    0x8(%ebp),%eax
 12d:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 131:	0f b6 10             	movzbl (%eax),%edx
 134:	84 d2                	test   %dl,%dl
 136:	74 09                	je     141 <strchr+0x1e>
    if(*s == c)
 138:	38 ca                	cmp    %cl,%dl
 13a:	74 0a                	je     146 <strchr+0x23>
  for(; *s; s++)
 13c:	83 c0 01             	add    $0x1,%eax
 13f:	eb f0                	jmp    131 <strchr+0xe>
      return (char*)s;
  return 0;
 141:	b8 00 00 00 00       	mov    $0x0,%eax
}
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    

00000148 <gets>:

char*
gets(char *buf, int max)
{
 148:	f3 0f 1e fb          	endbr32 
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	57                   	push   %edi
 150:	56                   	push   %esi
 151:	53                   	push   %ebx
 152:	83 ec 1c             	sub    $0x1c,%esp
 155:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 158:	bb 00 00 00 00       	mov    $0x0,%ebx
 15d:	89 de                	mov    %ebx,%esi
 15f:	83 c3 01             	add    $0x1,%ebx
 162:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 165:	7d 2e                	jge    195 <gets+0x4d>
    cc = read(0, &c, 1);
 167:	83 ec 04             	sub    $0x4,%esp
 16a:	6a 01                	push   $0x1
 16c:	8d 45 e7             	lea    -0x19(%ebp),%eax
 16f:	50                   	push   %eax
 170:	6a 00                	push   $0x0
 172:	e8 f6 00 00 00       	call   26d <read>
    if(cc < 1)
 177:	83 c4 10             	add    $0x10,%esp
 17a:	85 c0                	test   %eax,%eax
 17c:	7e 17                	jle    195 <gets+0x4d>
      break;
    buf[i++] = c;
 17e:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 182:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 185:	3c 0a                	cmp    $0xa,%al
 187:	0f 94 c2             	sete   %dl
 18a:	3c 0d                	cmp    $0xd,%al
 18c:	0f 94 c0             	sete   %al
 18f:	08 c2                	or     %al,%dl
 191:	74 ca                	je     15d <gets+0x15>
    buf[i++] = c;
 193:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 195:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 199:	89 f8                	mov    %edi,%eax
 19b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19e:	5b                   	pop    %ebx
 19f:	5e                   	pop    %esi
 1a0:	5f                   	pop    %edi
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    

000001a3 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a3:	f3 0f 1e fb          	endbr32 
 1a7:	55                   	push   %ebp
 1a8:	89 e5                	mov    %esp,%ebp
 1aa:	56                   	push   %esi
 1ab:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ac:	83 ec 08             	sub    $0x8,%esp
 1af:	6a 00                	push   $0x0
 1b1:	ff 75 08             	pushl  0x8(%ebp)
 1b4:	e8 dc 00 00 00       	call   295 <open>
  if(fd < 0)
 1b9:	83 c4 10             	add    $0x10,%esp
 1bc:	85 c0                	test   %eax,%eax
 1be:	78 24                	js     1e4 <stat+0x41>
 1c0:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1c2:	83 ec 08             	sub    $0x8,%esp
 1c5:	ff 75 0c             	pushl  0xc(%ebp)
 1c8:	50                   	push   %eax
 1c9:	e8 df 00 00 00       	call   2ad <fstat>
 1ce:	89 c6                	mov    %eax,%esi
  close(fd);
 1d0:	89 1c 24             	mov    %ebx,(%esp)
 1d3:	e8 a5 00 00 00       	call   27d <close>
  return r;
 1d8:	83 c4 10             	add    $0x10,%esp
}
 1db:	89 f0                	mov    %esi,%eax
 1dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
    return -1;
 1e4:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1e9:	eb f0                	jmp    1db <stat+0x38>

000001eb <atoi>:

int
atoi(const char *s)
{
 1eb:	f3 0f 1e fb          	endbr32 
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	53                   	push   %ebx
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 1f6:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1fb:	0f b6 01             	movzbl (%ecx),%eax
 1fe:	8d 58 d0             	lea    -0x30(%eax),%ebx
 201:	80 fb 09             	cmp    $0x9,%bl
 204:	77 12                	ja     218 <atoi+0x2d>
    n = n*10 + *s++ - '0';
 206:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 209:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 20c:	83 c1 01             	add    $0x1,%ecx
 20f:	0f be c0             	movsbl %al,%eax
 212:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
 216:	eb e3                	jmp    1fb <atoi+0x10>
  return n;
}
 218:	89 d0                	mov    %edx,%eax
 21a:	5b                   	pop    %ebx
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    

0000021d <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 21d:	f3 0f 1e fb          	endbr32 
 221:	55                   	push   %ebp
 222:	89 e5                	mov    %esp,%ebp
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	8b 75 08             	mov    0x8(%ebp),%esi
 229:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 22c:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 22f:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 231:	8d 58 ff             	lea    -0x1(%eax),%ebx
 234:	85 c0                	test   %eax,%eax
 236:	7e 0f                	jle    247 <memmove+0x2a>
    *dst++ = *src++;
 238:	0f b6 01             	movzbl (%ecx),%eax
 23b:	88 02                	mov    %al,(%edx)
 23d:	8d 49 01             	lea    0x1(%ecx),%ecx
 240:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 243:	89 d8                	mov    %ebx,%eax
 245:	eb ea                	jmp    231 <memmove+0x14>
  return vdst;
}
 247:	89 f0                	mov    %esi,%eax
 249:	5b                   	pop    %ebx
 24a:	5e                   	pop    %esi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    

0000024d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 24d:	b8 01 00 00 00       	mov    $0x1,%eax
 252:	cd 40                	int    $0x40
 254:	c3                   	ret    

00000255 <exit>:
SYSCALL(exit)
 255:	b8 02 00 00 00       	mov    $0x2,%eax
 25a:	cd 40                	int    $0x40
 25c:	c3                   	ret    

0000025d <wait>:
SYSCALL(wait)
 25d:	b8 03 00 00 00       	mov    $0x3,%eax
 262:	cd 40                	int    $0x40
 264:	c3                   	ret    

00000265 <pipe>:
SYSCALL(pipe)
 265:	b8 04 00 00 00       	mov    $0x4,%eax
 26a:	cd 40                	int    $0x40
 26c:	c3                   	ret    

0000026d <read>:
SYSCALL(read)
 26d:	b8 05 00 00 00       	mov    $0x5,%eax
 272:	cd 40                	int    $0x40
 274:	c3                   	ret    

00000275 <write>:
SYSCALL(write)
 275:	b8 10 00 00 00       	mov    $0x10,%eax
 27a:	cd 40                	int    $0x40
 27c:	c3                   	ret    

0000027d <close>:
SYSCALL(close)
 27d:	b8 15 00 00 00       	mov    $0x15,%eax
 282:	cd 40                	int    $0x40
 284:	c3                   	ret    

00000285 <kill>:
SYSCALL(kill)
 285:	b8 06 00 00 00       	mov    $0x6,%eax
 28a:	cd 40                	int    $0x40
 28c:	c3                   	ret    

0000028d <exec>:
SYSCALL(exec)
 28d:	b8 07 00 00 00       	mov    $0x7,%eax
 292:	cd 40                	int    $0x40
 294:	c3                   	ret    

00000295 <open>:
SYSCALL(open)
 295:	b8 0f 00 00 00       	mov    $0xf,%eax
 29a:	cd 40                	int    $0x40
 29c:	c3                   	ret    

0000029d <mknod>:
SYSCALL(mknod)
 29d:	b8 11 00 00 00       	mov    $0x11,%eax
 2a2:	cd 40                	int    $0x40
 2a4:	c3                   	ret    

000002a5 <unlink>:
SYSCALL(unlink)
 2a5:	b8 12 00 00 00       	mov    $0x12,%eax
 2aa:	cd 40                	int    $0x40
 2ac:	c3                   	ret    

000002ad <fstat>:
SYSCALL(fstat)
 2ad:	b8 08 00 00 00       	mov    $0x8,%eax
 2b2:	cd 40                	int    $0x40
 2b4:	c3                   	ret    

000002b5 <link>:
SYSCALL(link)
 2b5:	b8 13 00 00 00       	mov    $0x13,%eax
 2ba:	cd 40                	int    $0x40
 2bc:	c3                   	ret    

000002bd <mkdir>:
SYSCALL(mkdir)
 2bd:	b8 14 00 00 00       	mov    $0x14,%eax
 2c2:	cd 40                	int    $0x40
 2c4:	c3                   	ret    

000002c5 <chdir>:
SYSCALL(chdir)
 2c5:	b8 09 00 00 00       	mov    $0x9,%eax
 2ca:	cd 40                	int    $0x40
 2cc:	c3                   	ret    

000002cd <dup>:
SYSCALL(dup)
 2cd:	b8 0a 00 00 00       	mov    $0xa,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <getpid>:
SYSCALL(getpid)
 2d5:	b8 0b 00 00 00       	mov    $0xb,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <sbrk>:
SYSCALL(sbrk)
 2dd:	b8 0c 00 00 00       	mov    $0xc,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <sleep>:
SYSCALL(sleep)
 2e5:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <uptime>:
SYSCALL(uptime)
 2ed:	b8 0e 00 00 00       	mov    $0xe,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <setslice>:
SYSCALL(setslice);
 2f5:	b8 16 00 00 00       	mov    $0x16,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <getslice>:
SYSCALL(getslice);
 2fd:	b8 17 00 00 00       	mov    $0x17,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <fork2>:
SYSCALL(fork2);
 305:	b8 18 00 00 00       	mov    $0x18,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <getpinfo>:
SYSCALL(getpinfo);
 30d:	b8 19 00 00 00       	mov    $0x19,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 315:	55                   	push   %ebp
 316:	89 e5                	mov    %esp,%ebp
 318:	83 ec 1c             	sub    $0x1c,%esp
 31b:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 31e:	6a 01                	push   $0x1
 320:	8d 55 f4             	lea    -0xc(%ebp),%edx
 323:	52                   	push   %edx
 324:	50                   	push   %eax
 325:	e8 4b ff ff ff       	call   275 <write>
}
 32a:	83 c4 10             	add    $0x10,%esp
 32d:	c9                   	leave  
 32e:	c3                   	ret    

0000032f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 32f:	55                   	push   %ebp
 330:	89 e5                	mov    %esp,%ebp
 332:	57                   	push   %edi
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	83 ec 2c             	sub    $0x2c,%esp
 338:	89 45 d0             	mov    %eax,-0x30(%ebp)
 33b:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 33d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 341:	0f 95 c2             	setne  %dl
 344:	89 f0                	mov    %esi,%eax
 346:	c1 e8 1f             	shr    $0x1f,%eax
 349:	84 c2                	test   %al,%dl
 34b:	74 42                	je     38f <printint+0x60>
    neg = 1;
    x = -xx;
 34d:	f7 de                	neg    %esi
    neg = 1;
 34f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 356:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 35b:	89 f0                	mov    %esi,%eax
 35d:	ba 00 00 00 00       	mov    $0x0,%edx
 362:	f7 f1                	div    %ecx
 364:	89 df                	mov    %ebx,%edi
 366:	83 c3 01             	add    $0x1,%ebx
 369:	0f b6 92 cc 06 00 00 	movzbl 0x6cc(%edx),%edx
 370:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 374:	89 f2                	mov    %esi,%edx
 376:	89 c6                	mov    %eax,%esi
 378:	39 d1                	cmp    %edx,%ecx
 37a:	76 df                	jbe    35b <printint+0x2c>
  if(neg)
 37c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 380:	74 2f                	je     3b1 <printint+0x82>
    buf[i++] = '-';
 382:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 387:	8d 5f 02             	lea    0x2(%edi),%ebx
 38a:	8b 75 d0             	mov    -0x30(%ebp),%esi
 38d:	eb 15                	jmp    3a4 <printint+0x75>
  neg = 0;
 38f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 396:	eb be                	jmp    356 <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 398:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 39d:	89 f0                	mov    %esi,%eax
 39f:	e8 71 ff ff ff       	call   315 <putc>
  while(--i >= 0)
 3a4:	83 eb 01             	sub    $0x1,%ebx
 3a7:	79 ef                	jns    398 <printint+0x69>
}
 3a9:	83 c4 2c             	add    $0x2c,%esp
 3ac:	5b                   	pop    %ebx
 3ad:	5e                   	pop    %esi
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret    
 3b1:	8b 75 d0             	mov    -0x30(%ebp),%esi
 3b4:	eb ee                	jmp    3a4 <printint+0x75>

000003b6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3b6:	f3 0f 1e fb          	endbr32 
 3ba:	55                   	push   %ebp
 3bb:	89 e5                	mov    %esp,%ebp
 3bd:	57                   	push   %edi
 3be:	56                   	push   %esi
 3bf:	53                   	push   %ebx
 3c0:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3c3:	8d 45 10             	lea    0x10(%ebp),%eax
 3c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 3c9:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 3ce:	bb 00 00 00 00       	mov    $0x0,%ebx
 3d3:	eb 14                	jmp    3e9 <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 3d5:	89 fa                	mov    %edi,%edx
 3d7:	8b 45 08             	mov    0x8(%ebp),%eax
 3da:	e8 36 ff ff ff       	call   315 <putc>
 3df:	eb 05                	jmp    3e6 <printf+0x30>
      }
    } else if(state == '%'){
 3e1:	83 fe 25             	cmp    $0x25,%esi
 3e4:	74 25                	je     40b <printf+0x55>
  for(i = 0; fmt[i]; i++){
 3e6:	83 c3 01             	add    $0x1,%ebx
 3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ec:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 3f0:	84 c0                	test   %al,%al
 3f2:	0f 84 23 01 00 00    	je     51b <printf+0x165>
    c = fmt[i] & 0xff;
 3f8:	0f be f8             	movsbl %al,%edi
 3fb:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 3fe:	85 f6                	test   %esi,%esi
 400:	75 df                	jne    3e1 <printf+0x2b>
      if(c == '%'){
 402:	83 f8 25             	cmp    $0x25,%eax
 405:	75 ce                	jne    3d5 <printf+0x1f>
        state = '%';
 407:	89 c6                	mov    %eax,%esi
 409:	eb db                	jmp    3e6 <printf+0x30>
      if(c == 'd'){
 40b:	83 f8 64             	cmp    $0x64,%eax
 40e:	74 49                	je     459 <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 410:	83 f8 78             	cmp    $0x78,%eax
 413:	0f 94 c1             	sete   %cl
 416:	83 f8 70             	cmp    $0x70,%eax
 419:	0f 94 c2             	sete   %dl
 41c:	08 d1                	or     %dl,%cl
 41e:	75 63                	jne    483 <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 420:	83 f8 73             	cmp    $0x73,%eax
 423:	0f 84 84 00 00 00    	je     4ad <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 429:	83 f8 63             	cmp    $0x63,%eax
 42c:	0f 84 b7 00 00 00    	je     4e9 <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 432:	83 f8 25             	cmp    $0x25,%eax
 435:	0f 84 cc 00 00 00    	je     507 <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 43b:	ba 25 00 00 00       	mov    $0x25,%edx
 440:	8b 45 08             	mov    0x8(%ebp),%eax
 443:	e8 cd fe ff ff       	call   315 <putc>
        putc(fd, c);
 448:	89 fa                	mov    %edi,%edx
 44a:	8b 45 08             	mov    0x8(%ebp),%eax
 44d:	e8 c3 fe ff ff       	call   315 <putc>
      }
      state = 0;
 452:	be 00 00 00 00       	mov    $0x0,%esi
 457:	eb 8d                	jmp    3e6 <printf+0x30>
        printint(fd, *ap, 10, 1);
 459:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 45c:	8b 17                	mov    (%edi),%edx
 45e:	83 ec 0c             	sub    $0xc,%esp
 461:	6a 01                	push   $0x1
 463:	b9 0a 00 00 00       	mov    $0xa,%ecx
 468:	8b 45 08             	mov    0x8(%ebp),%eax
 46b:	e8 bf fe ff ff       	call   32f <printint>
        ap++;
 470:	83 c7 04             	add    $0x4,%edi
 473:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 476:	83 c4 10             	add    $0x10,%esp
      state = 0;
 479:	be 00 00 00 00       	mov    $0x0,%esi
 47e:	e9 63 ff ff ff       	jmp    3e6 <printf+0x30>
        printint(fd, *ap, 16, 0);
 483:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 486:	8b 17                	mov    (%edi),%edx
 488:	83 ec 0c             	sub    $0xc,%esp
 48b:	6a 00                	push   $0x0
 48d:	b9 10 00 00 00       	mov    $0x10,%ecx
 492:	8b 45 08             	mov    0x8(%ebp),%eax
 495:	e8 95 fe ff ff       	call   32f <printint>
        ap++;
 49a:	83 c7 04             	add    $0x4,%edi
 49d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4a0:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4a3:	be 00 00 00 00       	mov    $0x0,%esi
 4a8:	e9 39 ff ff ff       	jmp    3e6 <printf+0x30>
        s = (char*)*ap;
 4ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b0:	8b 30                	mov    (%eax),%esi
        ap++;
 4b2:	83 c0 04             	add    $0x4,%eax
 4b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 4b8:	85 f6                	test   %esi,%esi
 4ba:	75 28                	jne    4e4 <printf+0x12e>
          s = "(null)";
 4bc:	be c2 06 00 00       	mov    $0x6c2,%esi
 4c1:	8b 7d 08             	mov    0x8(%ebp),%edi
 4c4:	eb 0d                	jmp    4d3 <printf+0x11d>
          putc(fd, *s);
 4c6:	0f be d2             	movsbl %dl,%edx
 4c9:	89 f8                	mov    %edi,%eax
 4cb:	e8 45 fe ff ff       	call   315 <putc>
          s++;
 4d0:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 4d3:	0f b6 16             	movzbl (%esi),%edx
 4d6:	84 d2                	test   %dl,%dl
 4d8:	75 ec                	jne    4c6 <printf+0x110>
      state = 0;
 4da:	be 00 00 00 00       	mov    $0x0,%esi
 4df:	e9 02 ff ff ff       	jmp    3e6 <printf+0x30>
 4e4:	8b 7d 08             	mov    0x8(%ebp),%edi
 4e7:	eb ea                	jmp    4d3 <printf+0x11d>
        putc(fd, *ap);
 4e9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4ec:	0f be 17             	movsbl (%edi),%edx
 4ef:	8b 45 08             	mov    0x8(%ebp),%eax
 4f2:	e8 1e fe ff ff       	call   315 <putc>
        ap++;
 4f7:	83 c7 04             	add    $0x4,%edi
 4fa:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 4fd:	be 00 00 00 00       	mov    $0x0,%esi
 502:	e9 df fe ff ff       	jmp    3e6 <printf+0x30>
        putc(fd, c);
 507:	89 fa                	mov    %edi,%edx
 509:	8b 45 08             	mov    0x8(%ebp),%eax
 50c:	e8 04 fe ff ff       	call   315 <putc>
      state = 0;
 511:	be 00 00 00 00       	mov    $0x0,%esi
 516:	e9 cb fe ff ff       	jmp    3e6 <printf+0x30>
    }
  }
}
 51b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51e:	5b                   	pop    %ebx
 51f:	5e                   	pop    %esi
 520:	5f                   	pop    %edi
 521:	5d                   	pop    %ebp
 522:	c3                   	ret    

00000523 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 523:	f3 0f 1e fb          	endbr32 
 527:	55                   	push   %ebp
 528:	89 e5                	mov    %esp,%ebp
 52a:	57                   	push   %edi
 52b:	56                   	push   %esi
 52c:	53                   	push   %ebx
 52d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 530:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 533:	a1 70 09 00 00       	mov    0x970,%eax
 538:	eb 02                	jmp    53c <free+0x19>
 53a:	89 d0                	mov    %edx,%eax
 53c:	39 c8                	cmp    %ecx,%eax
 53e:	73 04                	jae    544 <free+0x21>
 540:	39 08                	cmp    %ecx,(%eax)
 542:	77 12                	ja     556 <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 544:	8b 10                	mov    (%eax),%edx
 546:	39 c2                	cmp    %eax,%edx
 548:	77 f0                	ja     53a <free+0x17>
 54a:	39 c8                	cmp    %ecx,%eax
 54c:	72 08                	jb     556 <free+0x33>
 54e:	39 ca                	cmp    %ecx,%edx
 550:	77 04                	ja     556 <free+0x33>
 552:	89 d0                	mov    %edx,%eax
 554:	eb e6                	jmp    53c <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 556:	8b 73 fc             	mov    -0x4(%ebx),%esi
 559:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 55c:	8b 10                	mov    (%eax),%edx
 55e:	39 d7                	cmp    %edx,%edi
 560:	74 19                	je     57b <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 562:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 565:	8b 50 04             	mov    0x4(%eax),%edx
 568:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 56b:	39 ce                	cmp    %ecx,%esi
 56d:	74 1b                	je     58a <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 56f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 571:	a3 70 09 00 00       	mov    %eax,0x970
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 57b:	03 72 04             	add    0x4(%edx),%esi
 57e:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 581:	8b 10                	mov    (%eax),%edx
 583:	8b 12                	mov    (%edx),%edx
 585:	89 53 f8             	mov    %edx,-0x8(%ebx)
 588:	eb db                	jmp    565 <free+0x42>
    p->s.size += bp->s.size;
 58a:	03 53 fc             	add    -0x4(%ebx),%edx
 58d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 590:	8b 53 f8             	mov    -0x8(%ebx),%edx
 593:	89 10                	mov    %edx,(%eax)
 595:	eb da                	jmp    571 <free+0x4e>

00000597 <morecore>:

static Header*
morecore(uint nu)
{
 597:	55                   	push   %ebp
 598:	89 e5                	mov    %esp,%ebp
 59a:	53                   	push   %ebx
 59b:	83 ec 04             	sub    $0x4,%esp
 59e:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 5a0:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 5a5:	77 05                	ja     5ac <morecore+0x15>
    nu = 4096;
 5a7:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 5ac:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 5b3:	83 ec 0c             	sub    $0xc,%esp
 5b6:	50                   	push   %eax
 5b7:	e8 21 fd ff ff       	call   2dd <sbrk>
  if(p == (char*)-1)
 5bc:	83 c4 10             	add    $0x10,%esp
 5bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 5c2:	74 1c                	je     5e0 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5c4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5c7:	83 c0 08             	add    $0x8,%eax
 5ca:	83 ec 0c             	sub    $0xc,%esp
 5cd:	50                   	push   %eax
 5ce:	e8 50 ff ff ff       	call   523 <free>
  return freep;
 5d3:	a1 70 09 00 00       	mov    0x970,%eax
 5d8:	83 c4 10             	add    $0x10,%esp
}
 5db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5de:	c9                   	leave  
 5df:	c3                   	ret    
    return 0;
 5e0:	b8 00 00 00 00       	mov    $0x0,%eax
 5e5:	eb f4                	jmp    5db <morecore+0x44>

000005e7 <malloc>:

void*
malloc(uint nbytes)
{
 5e7:	f3 0f 1e fb          	endbr32 
 5eb:	55                   	push   %ebp
 5ec:	89 e5                	mov    %esp,%ebp
 5ee:	53                   	push   %ebx
 5ef:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5f2:	8b 45 08             	mov    0x8(%ebp),%eax
 5f5:	8d 58 07             	lea    0x7(%eax),%ebx
 5f8:	c1 eb 03             	shr    $0x3,%ebx
 5fb:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5fe:	8b 0d 70 09 00 00    	mov    0x970,%ecx
 604:	85 c9                	test   %ecx,%ecx
 606:	74 04                	je     60c <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 608:	8b 01                	mov    (%ecx),%eax
 60a:	eb 4b                	jmp    657 <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 60c:	c7 05 70 09 00 00 74 	movl   $0x974,0x970
 613:	09 00 00 
 616:	c7 05 74 09 00 00 74 	movl   $0x974,0x974
 61d:	09 00 00 
    base.s.size = 0;
 620:	c7 05 78 09 00 00 00 	movl   $0x0,0x978
 627:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 62a:	b9 74 09 00 00       	mov    $0x974,%ecx
 62f:	eb d7                	jmp    608 <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 631:	74 1a                	je     64d <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 633:	29 da                	sub    %ebx,%edx
 635:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 638:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 63b:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 63e:	89 0d 70 09 00 00    	mov    %ecx,0x970
      return (void*)(p + 1);
 644:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 647:	83 c4 04             	add    $0x4,%esp
 64a:	5b                   	pop    %ebx
 64b:	5d                   	pop    %ebp
 64c:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 64d:	8b 10                	mov    (%eax),%edx
 64f:	89 11                	mov    %edx,(%ecx)
 651:	eb eb                	jmp    63e <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 653:	89 c1                	mov    %eax,%ecx
 655:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 657:	8b 50 04             	mov    0x4(%eax),%edx
 65a:	39 da                	cmp    %ebx,%edx
 65c:	73 d3                	jae    631 <malloc+0x4a>
    if(p == freep)
 65e:	39 05 70 09 00 00    	cmp    %eax,0x970
 664:	75 ed                	jne    653 <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 666:	89 d8                	mov    %ebx,%eax
 668:	e8 2a ff ff ff       	call   597 <morecore>
 66d:	85 c0                	test   %eax,%eax
 66f:	75 e2                	jne    653 <malloc+0x6c>
 671:	eb d4                	jmp    647 <malloc+0x60>
