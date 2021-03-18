
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  15:	e8 cd 01 00 00       	call   1e7 <fork>
  1a:	85 c0                	test   %eax,%eax
  1c:	7f 05                	jg     23 <main+0x23>
    sleep(5);  // Let child exit before parent.
  exit();
  1e:	e8 cc 01 00 00       	call   1ef <exit>
    sleep(5);  // Let child exit before parent.
  23:	83 ec 0c             	sub    $0xc,%esp
  26:	6a 05                	push   $0x5
  28:	e8 52 02 00 00       	call   27f <sleep>
  2d:	83 c4 10             	add    $0x10,%esp
  30:	eb ec                	jmp    1e <main+0x1e>

00000032 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  32:	f3 0f 1e fb          	endbr32 
  36:	55                   	push   %ebp
  37:	89 e5                	mov    %esp,%ebp
  39:	56                   	push   %esi
  3a:	53                   	push   %ebx
  3b:	8b 75 08             	mov    0x8(%ebp),%esi
  3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  41:	89 f0                	mov    %esi,%eax
  43:	89 d1                	mov    %edx,%ecx
  45:	83 c2 01             	add    $0x1,%edx
  48:	89 c3                	mov    %eax,%ebx
  4a:	83 c0 01             	add    $0x1,%eax
  4d:	0f b6 09             	movzbl (%ecx),%ecx
  50:	88 0b                	mov    %cl,(%ebx)
  52:	84 c9                	test   %cl,%cl
  54:	75 ed                	jne    43 <strcpy+0x11>
    ;
  return os;
}
  56:	89 f0                	mov    %esi,%eax
  58:	5b                   	pop    %ebx
  59:	5e                   	pop    %esi
  5a:	5d                   	pop    %ebp
  5b:	c3                   	ret    

0000005c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  5c:	f3 0f 1e fb          	endbr32 
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 4d 08             	mov    0x8(%ebp),%ecx
  66:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  69:	0f b6 01             	movzbl (%ecx),%eax
  6c:	84 c0                	test   %al,%al
  6e:	74 0c                	je     7c <strcmp+0x20>
  70:	3a 02                	cmp    (%edx),%al
  72:	75 08                	jne    7c <strcmp+0x20>
    p++, q++;
  74:	83 c1 01             	add    $0x1,%ecx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	eb ed                	jmp    69 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
  7c:	0f b6 c0             	movzbl %al,%eax
  7f:	0f b6 12             	movzbl (%edx),%edx
  82:	29 d0                	sub    %edx,%eax
}
  84:	5d                   	pop    %ebp
  85:	c3                   	ret    

00000086 <strlen>:

uint
strlen(const char *s)
{
  86:	f3 0f 1e fb          	endbr32 
  8a:	55                   	push   %ebp
  8b:	89 e5                	mov    %esp,%ebp
  8d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  90:	b8 00 00 00 00       	mov    $0x0,%eax
  95:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  99:	74 05                	je     a0 <strlen+0x1a>
  9b:	83 c0 01             	add    $0x1,%eax
  9e:	eb f5                	jmp    95 <strlen+0xf>
    ;
  return n;
}
  a0:	5d                   	pop    %ebp
  a1:	c3                   	ret    

000000a2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a2:	f3 0f 1e fb          	endbr32 
  a6:	55                   	push   %ebp
  a7:	89 e5                	mov    %esp,%ebp
  a9:	57                   	push   %edi
  aa:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ad:	89 d7                	mov    %edx,%edi
  af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  b5:	fc                   	cld    
  b6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  b8:	89 d0                	mov    %edx,%eax
  ba:	5f                   	pop    %edi
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    

000000bd <strchr>:

char*
strchr(const char *s, char c)
{
  bd:	f3 0f 1e fb          	endbr32 
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  cb:	0f b6 10             	movzbl (%eax),%edx
  ce:	84 d2                	test   %dl,%dl
  d0:	74 09                	je     db <strchr+0x1e>
    if(*s == c)
  d2:	38 ca                	cmp    %cl,%dl
  d4:	74 0a                	je     e0 <strchr+0x23>
  for(; *s; s++)
  d6:	83 c0 01             	add    $0x1,%eax
  d9:	eb f0                	jmp    cb <strchr+0xe>
      return (char*)s;
  return 0;
  db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    

000000e2 <gets>:

char*
gets(char *buf, int max)
{
  e2:	f3 0f 1e fb          	endbr32 
  e6:	55                   	push   %ebp
  e7:	89 e5                	mov    %esp,%ebp
  e9:	57                   	push   %edi
  ea:	56                   	push   %esi
  eb:	53                   	push   %ebx
  ec:	83 ec 1c             	sub    $0x1c,%esp
  ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  f2:	bb 00 00 00 00       	mov    $0x0,%ebx
  f7:	89 de                	mov    %ebx,%esi
  f9:	83 c3 01             	add    $0x1,%ebx
  fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
  ff:	7d 2e                	jge    12f <gets+0x4d>
    cc = read(0, &c, 1);
 101:	83 ec 04             	sub    $0x4,%esp
 104:	6a 01                	push   $0x1
 106:	8d 45 e7             	lea    -0x19(%ebp),%eax
 109:	50                   	push   %eax
 10a:	6a 00                	push   $0x0
 10c:	e8 f6 00 00 00       	call   207 <read>
    if(cc < 1)
 111:	83 c4 10             	add    $0x10,%esp
 114:	85 c0                	test   %eax,%eax
 116:	7e 17                	jle    12f <gets+0x4d>
      break;
    buf[i++] = c;
 118:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 11c:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 11f:	3c 0a                	cmp    $0xa,%al
 121:	0f 94 c2             	sete   %dl
 124:	3c 0d                	cmp    $0xd,%al
 126:	0f 94 c0             	sete   %al
 129:	08 c2                	or     %al,%dl
 12b:	74 ca                	je     f7 <gets+0x15>
    buf[i++] = c;
 12d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 12f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 133:	89 f8                	mov    %edi,%eax
 135:	8d 65 f4             	lea    -0xc(%ebp),%esp
 138:	5b                   	pop    %ebx
 139:	5e                   	pop    %esi
 13a:	5f                   	pop    %edi
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    

0000013d <stat>:

int
stat(const char *n, struct stat *st)
{
 13d:	f3 0f 1e fb          	endbr32 
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 146:	83 ec 08             	sub    $0x8,%esp
 149:	6a 00                	push   $0x0
 14b:	ff 75 08             	pushl  0x8(%ebp)
 14e:	e8 dc 00 00 00       	call   22f <open>
  if(fd < 0)
 153:	83 c4 10             	add    $0x10,%esp
 156:	85 c0                	test   %eax,%eax
 158:	78 24                	js     17e <stat+0x41>
 15a:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 15c:	83 ec 08             	sub    $0x8,%esp
 15f:	ff 75 0c             	pushl  0xc(%ebp)
 162:	50                   	push   %eax
 163:	e8 df 00 00 00       	call   247 <fstat>
 168:	89 c6                	mov    %eax,%esi
  close(fd);
 16a:	89 1c 24             	mov    %ebx,(%esp)
 16d:	e8 a5 00 00 00       	call   217 <close>
  return r;
 172:	83 c4 10             	add    $0x10,%esp
}
 175:	89 f0                	mov    %esi,%eax
 177:	8d 65 f8             	lea    -0x8(%ebp),%esp
 17a:	5b                   	pop    %ebx
 17b:	5e                   	pop    %esi
 17c:	5d                   	pop    %ebp
 17d:	c3                   	ret    
    return -1;
 17e:	be ff ff ff ff       	mov    $0xffffffff,%esi
 183:	eb f0                	jmp    175 <stat+0x38>

00000185 <atoi>:

int
atoi(const char *s)
{
 185:	f3 0f 1e fb          	endbr32 
 189:	55                   	push   %ebp
 18a:	89 e5                	mov    %esp,%ebp
 18c:	53                   	push   %ebx
 18d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 190:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 195:	0f b6 01             	movzbl (%ecx),%eax
 198:	8d 58 d0             	lea    -0x30(%eax),%ebx
 19b:	80 fb 09             	cmp    $0x9,%bl
 19e:	77 12                	ja     1b2 <atoi+0x2d>
    n = n*10 + *s++ - '0';
 1a0:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 1a3:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 1a6:	83 c1 01             	add    $0x1,%ecx
 1a9:	0f be c0             	movsbl %al,%eax
 1ac:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
 1b0:	eb e3                	jmp    195 <atoi+0x10>
  return n;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5b                   	pop    %ebx
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    

000001b7 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1b7:	f3 0f 1e fb          	endbr32 
 1bb:	55                   	push   %ebp
 1bc:	89 e5                	mov    %esp,%ebp
 1be:	56                   	push   %esi
 1bf:	53                   	push   %ebx
 1c0:	8b 75 08             	mov    0x8(%ebp),%esi
 1c3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1c6:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 1c9:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 1cb:	8d 58 ff             	lea    -0x1(%eax),%ebx
 1ce:	85 c0                	test   %eax,%eax
 1d0:	7e 0f                	jle    1e1 <memmove+0x2a>
    *dst++ = *src++;
 1d2:	0f b6 01             	movzbl (%ecx),%eax
 1d5:	88 02                	mov    %al,(%edx)
 1d7:	8d 49 01             	lea    0x1(%ecx),%ecx
 1da:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 1dd:	89 d8                	mov    %ebx,%eax
 1df:	eb ea                	jmp    1cb <memmove+0x14>
  return vdst;
}
 1e1:	89 f0                	mov    %esi,%eax
 1e3:	5b                   	pop    %ebx
 1e4:	5e                   	pop    %esi
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    

000001e7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1e7:	b8 01 00 00 00       	mov    $0x1,%eax
 1ec:	cd 40                	int    $0x40
 1ee:	c3                   	ret    

000001ef <exit>:
SYSCALL(exit)
 1ef:	b8 02 00 00 00       	mov    $0x2,%eax
 1f4:	cd 40                	int    $0x40
 1f6:	c3                   	ret    

000001f7 <wait>:
SYSCALL(wait)
 1f7:	b8 03 00 00 00       	mov    $0x3,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret    

000001ff <pipe>:
SYSCALL(pipe)
 1ff:	b8 04 00 00 00       	mov    $0x4,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret    

00000207 <read>:
SYSCALL(read)
 207:	b8 05 00 00 00       	mov    $0x5,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret    

0000020f <write>:
SYSCALL(write)
 20f:	b8 10 00 00 00       	mov    $0x10,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret    

00000217 <close>:
SYSCALL(close)
 217:	b8 15 00 00 00       	mov    $0x15,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret    

0000021f <kill>:
SYSCALL(kill)
 21f:	b8 06 00 00 00       	mov    $0x6,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret    

00000227 <exec>:
SYSCALL(exec)
 227:	b8 07 00 00 00       	mov    $0x7,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret    

0000022f <open>:
SYSCALL(open)
 22f:	b8 0f 00 00 00       	mov    $0xf,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret    

00000237 <mknod>:
SYSCALL(mknod)
 237:	b8 11 00 00 00       	mov    $0x11,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret    

0000023f <unlink>:
SYSCALL(unlink)
 23f:	b8 12 00 00 00       	mov    $0x12,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret    

00000247 <fstat>:
SYSCALL(fstat)
 247:	b8 08 00 00 00       	mov    $0x8,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret    

0000024f <link>:
SYSCALL(link)
 24f:	b8 13 00 00 00       	mov    $0x13,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret    

00000257 <mkdir>:
SYSCALL(mkdir)
 257:	b8 14 00 00 00       	mov    $0x14,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret    

0000025f <chdir>:
SYSCALL(chdir)
 25f:	b8 09 00 00 00       	mov    $0x9,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret    

00000267 <dup>:
SYSCALL(dup)
 267:	b8 0a 00 00 00       	mov    $0xa,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret    

0000026f <getpid>:
SYSCALL(getpid)
 26f:	b8 0b 00 00 00       	mov    $0xb,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret    

00000277 <sbrk>:
SYSCALL(sbrk)
 277:	b8 0c 00 00 00       	mov    $0xc,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <sleep>:
SYSCALL(sleep)
 27f:	b8 0d 00 00 00       	mov    $0xd,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <uptime>:
SYSCALL(uptime)
 287:	b8 0e 00 00 00       	mov    $0xe,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <setslice>:
SYSCALL(setslice)
 28f:	b8 16 00 00 00       	mov    $0x16,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <getslice>:
SYSCALL(getslice)
 297:	b8 17 00 00 00       	mov    $0x17,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <fork2>:
SYSCALL(fork2)
 29f:	b8 18 00 00 00       	mov    $0x18,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <getpinfo>:
SYSCALL(getpinfo)
 2a7:	b8 19 00 00 00       	mov    $0x19,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2af:	55                   	push   %ebp
 2b0:	89 e5                	mov    %esp,%ebp
 2b2:	83 ec 1c             	sub    $0x1c,%esp
 2b5:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2b8:	6a 01                	push   $0x1
 2ba:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2bd:	52                   	push   %edx
 2be:	50                   	push   %eax
 2bf:	e8 4b ff ff ff       	call   20f <write>
}
 2c4:	83 c4 10             	add    $0x10,%esp
 2c7:	c9                   	leave  
 2c8:	c3                   	ret    

000002c9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2c9:	55                   	push   %ebp
 2ca:	89 e5                	mov    %esp,%ebp
 2cc:	57                   	push   %edi
 2cd:	56                   	push   %esi
 2ce:	53                   	push   %ebx
 2cf:	83 ec 2c             	sub    $0x2c,%esp
 2d2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 2d5:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2db:	0f 95 c2             	setne  %dl
 2de:	89 f0                	mov    %esi,%eax
 2e0:	c1 e8 1f             	shr    $0x1f,%eax
 2e3:	84 c2                	test   %al,%dl
 2e5:	74 42                	je     329 <printint+0x60>
    neg = 1;
    x = -xx;
 2e7:	f7 de                	neg    %esi
    neg = 1;
 2e9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2f0:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 2f5:	89 f0                	mov    %esi,%eax
 2f7:	ba 00 00 00 00       	mov    $0x0,%edx
 2fc:	f7 f1                	div    %ecx
 2fe:	89 df                	mov    %ebx,%edi
 300:	83 c3 01             	add    $0x1,%ebx
 303:	0f b6 92 18 06 00 00 	movzbl 0x618(%edx),%edx
 30a:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 30e:	89 f2                	mov    %esi,%edx
 310:	89 c6                	mov    %eax,%esi
 312:	39 d1                	cmp    %edx,%ecx
 314:	76 df                	jbe    2f5 <printint+0x2c>
  if(neg)
 316:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 31a:	74 2f                	je     34b <printint+0x82>
    buf[i++] = '-';
 31c:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 321:	8d 5f 02             	lea    0x2(%edi),%ebx
 324:	8b 75 d0             	mov    -0x30(%ebp),%esi
 327:	eb 15                	jmp    33e <printint+0x75>
  neg = 0;
 329:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 330:	eb be                	jmp    2f0 <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 332:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 337:	89 f0                	mov    %esi,%eax
 339:	e8 71 ff ff ff       	call   2af <putc>
  while(--i >= 0)
 33e:	83 eb 01             	sub    $0x1,%ebx
 341:	79 ef                	jns    332 <printint+0x69>
}
 343:	83 c4 2c             	add    $0x2c,%esp
 346:	5b                   	pop    %ebx
 347:	5e                   	pop    %esi
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    
 34b:	8b 75 d0             	mov    -0x30(%ebp),%esi
 34e:	eb ee                	jmp    33e <printint+0x75>

00000350 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 350:	f3 0f 1e fb          	endbr32 
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	57                   	push   %edi
 358:	56                   	push   %esi
 359:	53                   	push   %ebx
 35a:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 35d:	8d 45 10             	lea    0x10(%ebp),%eax
 360:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 363:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 368:	bb 00 00 00 00       	mov    $0x0,%ebx
 36d:	eb 14                	jmp    383 <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 36f:	89 fa                	mov    %edi,%edx
 371:	8b 45 08             	mov    0x8(%ebp),%eax
 374:	e8 36 ff ff ff       	call   2af <putc>
 379:	eb 05                	jmp    380 <printf+0x30>
      }
    } else if(state == '%'){
 37b:	83 fe 25             	cmp    $0x25,%esi
 37e:	74 25                	je     3a5 <printf+0x55>
  for(i = 0; fmt[i]; i++){
 380:	83 c3 01             	add    $0x1,%ebx
 383:	8b 45 0c             	mov    0xc(%ebp),%eax
 386:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 38a:	84 c0                	test   %al,%al
 38c:	0f 84 23 01 00 00    	je     4b5 <printf+0x165>
    c = fmt[i] & 0xff;
 392:	0f be f8             	movsbl %al,%edi
 395:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 398:	85 f6                	test   %esi,%esi
 39a:	75 df                	jne    37b <printf+0x2b>
      if(c == '%'){
 39c:	83 f8 25             	cmp    $0x25,%eax
 39f:	75 ce                	jne    36f <printf+0x1f>
        state = '%';
 3a1:	89 c6                	mov    %eax,%esi
 3a3:	eb db                	jmp    380 <printf+0x30>
      if(c == 'd'){
 3a5:	83 f8 64             	cmp    $0x64,%eax
 3a8:	74 49                	je     3f3 <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3aa:	83 f8 78             	cmp    $0x78,%eax
 3ad:	0f 94 c1             	sete   %cl
 3b0:	83 f8 70             	cmp    $0x70,%eax
 3b3:	0f 94 c2             	sete   %dl
 3b6:	08 d1                	or     %dl,%cl
 3b8:	75 63                	jne    41d <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3ba:	83 f8 73             	cmp    $0x73,%eax
 3bd:	0f 84 84 00 00 00    	je     447 <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3c3:	83 f8 63             	cmp    $0x63,%eax
 3c6:	0f 84 b7 00 00 00    	je     483 <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3cc:	83 f8 25             	cmp    $0x25,%eax
 3cf:	0f 84 cc 00 00 00    	je     4a1 <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 3d5:	ba 25 00 00 00       	mov    $0x25,%edx
 3da:	8b 45 08             	mov    0x8(%ebp),%eax
 3dd:	e8 cd fe ff ff       	call   2af <putc>
        putc(fd, c);
 3e2:	89 fa                	mov    %edi,%edx
 3e4:	8b 45 08             	mov    0x8(%ebp),%eax
 3e7:	e8 c3 fe ff ff       	call   2af <putc>
      }
      state = 0;
 3ec:	be 00 00 00 00       	mov    $0x0,%esi
 3f1:	eb 8d                	jmp    380 <printf+0x30>
        printint(fd, *ap, 10, 1);
 3f3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3f6:	8b 17                	mov    (%edi),%edx
 3f8:	83 ec 0c             	sub    $0xc,%esp
 3fb:	6a 01                	push   $0x1
 3fd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 402:	8b 45 08             	mov    0x8(%ebp),%eax
 405:	e8 bf fe ff ff       	call   2c9 <printint>
        ap++;
 40a:	83 c7 04             	add    $0x4,%edi
 40d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 410:	83 c4 10             	add    $0x10,%esp
      state = 0;
 413:	be 00 00 00 00       	mov    $0x0,%esi
 418:	e9 63 ff ff ff       	jmp    380 <printf+0x30>
        printint(fd, *ap, 16, 0);
 41d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 420:	8b 17                	mov    (%edi),%edx
 422:	83 ec 0c             	sub    $0xc,%esp
 425:	6a 00                	push   $0x0
 427:	b9 10 00 00 00       	mov    $0x10,%ecx
 42c:	8b 45 08             	mov    0x8(%ebp),%eax
 42f:	e8 95 fe ff ff       	call   2c9 <printint>
        ap++;
 434:	83 c7 04             	add    $0x4,%edi
 437:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 43a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 43d:	be 00 00 00 00       	mov    $0x0,%esi
 442:	e9 39 ff ff ff       	jmp    380 <printf+0x30>
        s = (char*)*ap;
 447:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 44a:	8b 30                	mov    (%eax),%esi
        ap++;
 44c:	83 c0 04             	add    $0x4,%eax
 44f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 452:	85 f6                	test   %esi,%esi
 454:	75 28                	jne    47e <printf+0x12e>
          s = "(null)";
 456:	be 10 06 00 00       	mov    $0x610,%esi
 45b:	8b 7d 08             	mov    0x8(%ebp),%edi
 45e:	eb 0d                	jmp    46d <printf+0x11d>
          putc(fd, *s);
 460:	0f be d2             	movsbl %dl,%edx
 463:	89 f8                	mov    %edi,%eax
 465:	e8 45 fe ff ff       	call   2af <putc>
          s++;
 46a:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 46d:	0f b6 16             	movzbl (%esi),%edx
 470:	84 d2                	test   %dl,%dl
 472:	75 ec                	jne    460 <printf+0x110>
      state = 0;
 474:	be 00 00 00 00       	mov    $0x0,%esi
 479:	e9 02 ff ff ff       	jmp    380 <printf+0x30>
 47e:	8b 7d 08             	mov    0x8(%ebp),%edi
 481:	eb ea                	jmp    46d <printf+0x11d>
        putc(fd, *ap);
 483:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 486:	0f be 17             	movsbl (%edi),%edx
 489:	8b 45 08             	mov    0x8(%ebp),%eax
 48c:	e8 1e fe ff ff       	call   2af <putc>
        ap++;
 491:	83 c7 04             	add    $0x4,%edi
 494:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 497:	be 00 00 00 00       	mov    $0x0,%esi
 49c:	e9 df fe ff ff       	jmp    380 <printf+0x30>
        putc(fd, c);
 4a1:	89 fa                	mov    %edi,%edx
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	e8 04 fe ff ff       	call   2af <putc>
      state = 0;
 4ab:	be 00 00 00 00       	mov    $0x0,%esi
 4b0:	e9 cb fe ff ff       	jmp    380 <printf+0x30>
    }
  }
}
 4b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b8:	5b                   	pop    %ebx
 4b9:	5e                   	pop    %esi
 4ba:	5f                   	pop    %edi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret    

000004bd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4bd:	f3 0f 1e fb          	endbr32 
 4c1:	55                   	push   %ebp
 4c2:	89 e5                	mov    %esp,%ebp
 4c4:	57                   	push   %edi
 4c5:	56                   	push   %esi
 4c6:	53                   	push   %ebx
 4c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4ca:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4cd:	a1 b8 08 00 00       	mov    0x8b8,%eax
 4d2:	eb 02                	jmp    4d6 <free+0x19>
 4d4:	89 d0                	mov    %edx,%eax
 4d6:	39 c8                	cmp    %ecx,%eax
 4d8:	73 04                	jae    4de <free+0x21>
 4da:	39 08                	cmp    %ecx,(%eax)
 4dc:	77 12                	ja     4f0 <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4de:	8b 10                	mov    (%eax),%edx
 4e0:	39 c2                	cmp    %eax,%edx
 4e2:	77 f0                	ja     4d4 <free+0x17>
 4e4:	39 c8                	cmp    %ecx,%eax
 4e6:	72 08                	jb     4f0 <free+0x33>
 4e8:	39 ca                	cmp    %ecx,%edx
 4ea:	77 04                	ja     4f0 <free+0x33>
 4ec:	89 d0                	mov    %edx,%eax
 4ee:	eb e6                	jmp    4d6 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4f6:	8b 10                	mov    (%eax),%edx
 4f8:	39 d7                	cmp    %edx,%edi
 4fa:	74 19                	je     515 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4fc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4ff:	8b 50 04             	mov    0x4(%eax),%edx
 502:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 505:	39 ce                	cmp    %ecx,%esi
 507:	74 1b                	je     524 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 509:	89 08                	mov    %ecx,(%eax)
  freep = p;
 50b:	a3 b8 08 00 00       	mov    %eax,0x8b8
}
 510:	5b                   	pop    %ebx
 511:	5e                   	pop    %esi
 512:	5f                   	pop    %edi
 513:	5d                   	pop    %ebp
 514:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 515:	03 72 04             	add    0x4(%edx),%esi
 518:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 51b:	8b 10                	mov    (%eax),%edx
 51d:	8b 12                	mov    (%edx),%edx
 51f:	89 53 f8             	mov    %edx,-0x8(%ebx)
 522:	eb db                	jmp    4ff <free+0x42>
    p->s.size += bp->s.size;
 524:	03 53 fc             	add    -0x4(%ebx),%edx
 527:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 52a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 52d:	89 10                	mov    %edx,(%eax)
 52f:	eb da                	jmp    50b <free+0x4e>

00000531 <morecore>:

static Header*
morecore(uint nu)
{
 531:	55                   	push   %ebp
 532:	89 e5                	mov    %esp,%ebp
 534:	53                   	push   %ebx
 535:	83 ec 04             	sub    $0x4,%esp
 538:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 53a:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 53f:	77 05                	ja     546 <morecore+0x15>
    nu = 4096;
 541:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 546:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 54d:	83 ec 0c             	sub    $0xc,%esp
 550:	50                   	push   %eax
 551:	e8 21 fd ff ff       	call   277 <sbrk>
  if(p == (char*)-1)
 556:	83 c4 10             	add    $0x10,%esp
 559:	83 f8 ff             	cmp    $0xffffffff,%eax
 55c:	74 1c                	je     57a <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 55e:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 561:	83 c0 08             	add    $0x8,%eax
 564:	83 ec 0c             	sub    $0xc,%esp
 567:	50                   	push   %eax
 568:	e8 50 ff ff ff       	call   4bd <free>
  return freep;
 56d:	a1 b8 08 00 00       	mov    0x8b8,%eax
 572:	83 c4 10             	add    $0x10,%esp
}
 575:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 578:	c9                   	leave  
 579:	c3                   	ret    
    return 0;
 57a:	b8 00 00 00 00       	mov    $0x0,%eax
 57f:	eb f4                	jmp    575 <morecore+0x44>

00000581 <malloc>:

void*
malloc(uint nbytes)
{
 581:	f3 0f 1e fb          	endbr32 
 585:	55                   	push   %ebp
 586:	89 e5                	mov    %esp,%ebp
 588:	53                   	push   %ebx
 589:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 58c:	8b 45 08             	mov    0x8(%ebp),%eax
 58f:	8d 58 07             	lea    0x7(%eax),%ebx
 592:	c1 eb 03             	shr    $0x3,%ebx
 595:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 598:	8b 0d b8 08 00 00    	mov    0x8b8,%ecx
 59e:	85 c9                	test   %ecx,%ecx
 5a0:	74 04                	je     5a6 <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5a2:	8b 01                	mov    (%ecx),%eax
 5a4:	eb 4b                	jmp    5f1 <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 5a6:	c7 05 b8 08 00 00 bc 	movl   $0x8bc,0x8b8
 5ad:	08 00 00 
 5b0:	c7 05 bc 08 00 00 bc 	movl   $0x8bc,0x8bc
 5b7:	08 00 00 
    base.s.size = 0;
 5ba:	c7 05 c0 08 00 00 00 	movl   $0x0,0x8c0
 5c1:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5c4:	b9 bc 08 00 00       	mov    $0x8bc,%ecx
 5c9:	eb d7                	jmp    5a2 <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5cb:	74 1a                	je     5e7 <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5cd:	29 da                	sub    %ebx,%edx
 5cf:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 5d2:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 5d5:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5d8:	89 0d b8 08 00 00    	mov    %ecx,0x8b8
      return (void*)(p + 1);
 5de:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5e1:	83 c4 04             	add    $0x4,%esp
 5e4:	5b                   	pop    %ebx
 5e5:	5d                   	pop    %ebp
 5e6:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 5e7:	8b 10                	mov    (%eax),%edx
 5e9:	89 11                	mov    %edx,(%ecx)
 5eb:	eb eb                	jmp    5d8 <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5ed:	89 c1                	mov    %eax,%ecx
 5ef:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 5f1:	8b 50 04             	mov    0x4(%eax),%edx
 5f4:	39 da                	cmp    %ebx,%edx
 5f6:	73 d3                	jae    5cb <malloc+0x4a>
    if(p == freep)
 5f8:	39 05 b8 08 00 00    	cmp    %eax,0x8b8
 5fe:	75 ed                	jne    5ed <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 600:	89 d8                	mov    %ebx,%eax
 602:	e8 2a ff ff ff       	call   531 <morecore>
 607:	85 c0                	test   %eax,%eax
 609:	75 e2                	jne    5ed <malloc+0x6c>
 60b:	eb d4                	jmp    5e1 <malloc+0x60>
