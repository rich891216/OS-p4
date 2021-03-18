
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  16:	83 39 03             	cmpl   $0x3,(%ecx)
  19:	74 14                	je     2f <main+0x2f>
    printf(2, "Usage: ln old new\n");
  1b:	83 ec 08             	sub    $0x8,%esp
  1e:	68 3c 06 00 00       	push   $0x63c
  23:	6a 02                	push   $0x2
  25:	e8 54 03 00 00       	call   37e <printf>
    exit();
  2a:	e8 ee 01 00 00       	call   21d <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	ff 73 08             	pushl  0x8(%ebx)
  35:	ff 73 04             	pushl  0x4(%ebx)
  38:	e8 40 02 00 00       	call   27d <link>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	85 c0                	test   %eax,%eax
  42:	78 05                	js     49 <main+0x49>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  44:	e8 d4 01 00 00       	call   21d <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  49:	ff 73 08             	pushl  0x8(%ebx)
  4c:	ff 73 04             	pushl  0x4(%ebx)
  4f:	68 4f 06 00 00       	push   $0x64f
  54:	6a 02                	push   $0x2
  56:	e8 23 03 00 00       	call   37e <printf>
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	eb e4                	jmp    44 <main+0x44>

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	f3 0f 1e fb          	endbr32 
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	56                   	push   %esi
  68:	53                   	push   %ebx
  69:	8b 75 08             	mov    0x8(%ebp),%esi
  6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6f:	89 f0                	mov    %esi,%eax
  71:	89 d1                	mov    %edx,%ecx
  73:	83 c2 01             	add    $0x1,%edx
  76:	89 c3                	mov    %eax,%ebx
  78:	83 c0 01             	add    $0x1,%eax
  7b:	0f b6 09             	movzbl (%ecx),%ecx
  7e:	88 0b                	mov    %cl,(%ebx)
  80:	84 c9                	test   %cl,%cl
  82:	75 ed                	jne    71 <strcpy+0x11>
    ;
  return os;
}
  84:	89 f0                	mov    %esi,%eax
  86:	5b                   	pop    %ebx
  87:	5e                   	pop    %esi
  88:	5d                   	pop    %ebp
  89:	c3                   	ret    

0000008a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8a:	f3 0f 1e fb          	endbr32 
  8e:	55                   	push   %ebp
  8f:	89 e5                	mov    %esp,%ebp
  91:	8b 4d 08             	mov    0x8(%ebp),%ecx
  94:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  97:	0f b6 01             	movzbl (%ecx),%eax
  9a:	84 c0                	test   %al,%al
  9c:	74 0c                	je     aa <strcmp+0x20>
  9e:	3a 02                	cmp    (%edx),%al
  a0:	75 08                	jne    aa <strcmp+0x20>
    p++, q++;
  a2:	83 c1 01             	add    $0x1,%ecx
  a5:	83 c2 01             	add    $0x1,%edx
  a8:	eb ed                	jmp    97 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
  aa:	0f b6 c0             	movzbl %al,%eax
  ad:	0f b6 12             	movzbl (%edx),%edx
  b0:	29 d0                	sub    %edx,%eax
}
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    

000000b4 <strlen>:

uint
strlen(const char *s)
{
  b4:	f3 0f 1e fb          	endbr32 
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  be:	b8 00 00 00 00       	mov    $0x0,%eax
  c3:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  c7:	74 05                	je     ce <strlen+0x1a>
  c9:	83 c0 01             	add    $0x1,%eax
  cc:	eb f5                	jmp    c3 <strlen+0xf>
    ;
  return n;
}
  ce:	5d                   	pop    %ebp
  cf:	c3                   	ret    

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	f3 0f 1e fb          	endbr32 
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  db:	89 d7                	mov    %edx,%edi
  dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	fc                   	cld    
  e4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e6:	89 d0                	mov    %edx,%eax
  e8:	5f                   	pop    %edi
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    

000000eb <strchr>:

char*
strchr(const char *s, char c)
{
  eb:	f3 0f 1e fb          	endbr32 
  ef:	55                   	push   %ebp
  f0:	89 e5                	mov    %esp,%ebp
  f2:	8b 45 08             	mov    0x8(%ebp),%eax
  f5:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  f9:	0f b6 10             	movzbl (%eax),%edx
  fc:	84 d2                	test   %dl,%dl
  fe:	74 09                	je     109 <strchr+0x1e>
    if(*s == c)
 100:	38 ca                	cmp    %cl,%dl
 102:	74 0a                	je     10e <strchr+0x23>
  for(; *s; s++)
 104:	83 c0 01             	add    $0x1,%eax
 107:	eb f0                	jmp    f9 <strchr+0xe>
      return (char*)s;
  return 0;
 109:	b8 00 00 00 00       	mov    $0x0,%eax
}
 10e:	5d                   	pop    %ebp
 10f:	c3                   	ret    

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	f3 0f 1e fb          	endbr32 
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	83 ec 1c             	sub    $0x1c,%esp
 11d:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 120:	bb 00 00 00 00       	mov    $0x0,%ebx
 125:	89 de                	mov    %ebx,%esi
 127:	83 c3 01             	add    $0x1,%ebx
 12a:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 12d:	7d 2e                	jge    15d <gets+0x4d>
    cc = read(0, &c, 1);
 12f:	83 ec 04             	sub    $0x4,%esp
 132:	6a 01                	push   $0x1
 134:	8d 45 e7             	lea    -0x19(%ebp),%eax
 137:	50                   	push   %eax
 138:	6a 00                	push   $0x0
 13a:	e8 f6 00 00 00       	call   235 <read>
    if(cc < 1)
 13f:	83 c4 10             	add    $0x10,%esp
 142:	85 c0                	test   %eax,%eax
 144:	7e 17                	jle    15d <gets+0x4d>
      break;
    buf[i++] = c;
 146:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 14a:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 14d:	3c 0a                	cmp    $0xa,%al
 14f:	0f 94 c2             	sete   %dl
 152:	3c 0d                	cmp    $0xd,%al
 154:	0f 94 c0             	sete   %al
 157:	08 c2                	or     %al,%dl
 159:	74 ca                	je     125 <gets+0x15>
    buf[i++] = c;
 15b:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 15d:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 161:	89 f8                	mov    %edi,%eax
 163:	8d 65 f4             	lea    -0xc(%ebp),%esp
 166:	5b                   	pop    %ebx
 167:	5e                   	pop    %esi
 168:	5f                   	pop    %edi
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    

0000016b <stat>:

int
stat(const char *n, struct stat *st)
{
 16b:	f3 0f 1e fb          	endbr32 
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	56                   	push   %esi
 173:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 174:	83 ec 08             	sub    $0x8,%esp
 177:	6a 00                	push   $0x0
 179:	ff 75 08             	pushl  0x8(%ebp)
 17c:	e8 dc 00 00 00       	call   25d <open>
  if(fd < 0)
 181:	83 c4 10             	add    $0x10,%esp
 184:	85 c0                	test   %eax,%eax
 186:	78 24                	js     1ac <stat+0x41>
 188:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 18a:	83 ec 08             	sub    $0x8,%esp
 18d:	ff 75 0c             	pushl  0xc(%ebp)
 190:	50                   	push   %eax
 191:	e8 df 00 00 00       	call   275 <fstat>
 196:	89 c6                	mov    %eax,%esi
  close(fd);
 198:	89 1c 24             	mov    %ebx,(%esp)
 19b:	e8 a5 00 00 00       	call   245 <close>
  return r;
 1a0:	83 c4 10             	add    $0x10,%esp
}
 1a3:	89 f0                	mov    %esi,%eax
 1a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a8:	5b                   	pop    %ebx
 1a9:	5e                   	pop    %esi
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret    
    return -1;
 1ac:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1b1:	eb f0                	jmp    1a3 <stat+0x38>

000001b3 <atoi>:

int
atoi(const char *s)
{
 1b3:	f3 0f 1e fb          	endbr32 
 1b7:	55                   	push   %ebp
 1b8:	89 e5                	mov    %esp,%ebp
 1ba:	53                   	push   %ebx
 1bb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 1be:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1c3:	0f b6 01             	movzbl (%ecx),%eax
 1c6:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1c9:	80 fb 09             	cmp    $0x9,%bl
 1cc:	77 12                	ja     1e0 <atoi+0x2d>
    n = n*10 + *s++ - '0';
 1ce:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 1d1:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 1d4:	83 c1 01             	add    $0x1,%ecx
 1d7:	0f be c0             	movsbl %al,%eax
 1da:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
 1de:	eb e3                	jmp    1c3 <atoi+0x10>
  return n;
}
 1e0:	89 d0                	mov    %edx,%eax
 1e2:	5b                   	pop    %ebx
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    

000001e5 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1e5:	f3 0f 1e fb          	endbr32 
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	56                   	push   %esi
 1ed:	53                   	push   %ebx
 1ee:	8b 75 08             	mov    0x8(%ebp),%esi
 1f1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1f4:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 1f7:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 1f9:	8d 58 ff             	lea    -0x1(%eax),%ebx
 1fc:	85 c0                	test   %eax,%eax
 1fe:	7e 0f                	jle    20f <memmove+0x2a>
    *dst++ = *src++;
 200:	0f b6 01             	movzbl (%ecx),%eax
 203:	88 02                	mov    %al,(%edx)
 205:	8d 49 01             	lea    0x1(%ecx),%ecx
 208:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 20b:	89 d8                	mov    %ebx,%eax
 20d:	eb ea                	jmp    1f9 <memmove+0x14>
  return vdst;
}
 20f:	89 f0                	mov    %esi,%eax
 211:	5b                   	pop    %ebx
 212:	5e                   	pop    %esi
 213:	5d                   	pop    %ebp
 214:	c3                   	ret    

00000215 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 215:	b8 01 00 00 00       	mov    $0x1,%eax
 21a:	cd 40                	int    $0x40
 21c:	c3                   	ret    

0000021d <exit>:
SYSCALL(exit)
 21d:	b8 02 00 00 00       	mov    $0x2,%eax
 222:	cd 40                	int    $0x40
 224:	c3                   	ret    

00000225 <wait>:
SYSCALL(wait)
 225:	b8 03 00 00 00       	mov    $0x3,%eax
 22a:	cd 40                	int    $0x40
 22c:	c3                   	ret    

0000022d <pipe>:
SYSCALL(pipe)
 22d:	b8 04 00 00 00       	mov    $0x4,%eax
 232:	cd 40                	int    $0x40
 234:	c3                   	ret    

00000235 <read>:
SYSCALL(read)
 235:	b8 05 00 00 00       	mov    $0x5,%eax
 23a:	cd 40                	int    $0x40
 23c:	c3                   	ret    

0000023d <write>:
SYSCALL(write)
 23d:	b8 10 00 00 00       	mov    $0x10,%eax
 242:	cd 40                	int    $0x40
 244:	c3                   	ret    

00000245 <close>:
SYSCALL(close)
 245:	b8 15 00 00 00       	mov    $0x15,%eax
 24a:	cd 40                	int    $0x40
 24c:	c3                   	ret    

0000024d <kill>:
SYSCALL(kill)
 24d:	b8 06 00 00 00       	mov    $0x6,%eax
 252:	cd 40                	int    $0x40
 254:	c3                   	ret    

00000255 <exec>:
SYSCALL(exec)
 255:	b8 07 00 00 00       	mov    $0x7,%eax
 25a:	cd 40                	int    $0x40
 25c:	c3                   	ret    

0000025d <open>:
SYSCALL(open)
 25d:	b8 0f 00 00 00       	mov    $0xf,%eax
 262:	cd 40                	int    $0x40
 264:	c3                   	ret    

00000265 <mknod>:
SYSCALL(mknod)
 265:	b8 11 00 00 00       	mov    $0x11,%eax
 26a:	cd 40                	int    $0x40
 26c:	c3                   	ret    

0000026d <unlink>:
SYSCALL(unlink)
 26d:	b8 12 00 00 00       	mov    $0x12,%eax
 272:	cd 40                	int    $0x40
 274:	c3                   	ret    

00000275 <fstat>:
SYSCALL(fstat)
 275:	b8 08 00 00 00       	mov    $0x8,%eax
 27a:	cd 40                	int    $0x40
 27c:	c3                   	ret    

0000027d <link>:
SYSCALL(link)
 27d:	b8 13 00 00 00       	mov    $0x13,%eax
 282:	cd 40                	int    $0x40
 284:	c3                   	ret    

00000285 <mkdir>:
SYSCALL(mkdir)
 285:	b8 14 00 00 00       	mov    $0x14,%eax
 28a:	cd 40                	int    $0x40
 28c:	c3                   	ret    

0000028d <chdir>:
SYSCALL(chdir)
 28d:	b8 09 00 00 00       	mov    $0x9,%eax
 292:	cd 40                	int    $0x40
 294:	c3                   	ret    

00000295 <dup>:
SYSCALL(dup)
 295:	b8 0a 00 00 00       	mov    $0xa,%eax
 29a:	cd 40                	int    $0x40
 29c:	c3                   	ret    

0000029d <getpid>:
SYSCALL(getpid)
 29d:	b8 0b 00 00 00       	mov    $0xb,%eax
 2a2:	cd 40                	int    $0x40
 2a4:	c3                   	ret    

000002a5 <sbrk>:
SYSCALL(sbrk)
 2a5:	b8 0c 00 00 00       	mov    $0xc,%eax
 2aa:	cd 40                	int    $0x40
 2ac:	c3                   	ret    

000002ad <sleep>:
SYSCALL(sleep)
 2ad:	b8 0d 00 00 00       	mov    $0xd,%eax
 2b2:	cd 40                	int    $0x40
 2b4:	c3                   	ret    

000002b5 <uptime>:
SYSCALL(uptime)
 2b5:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ba:	cd 40                	int    $0x40
 2bc:	c3                   	ret    

000002bd <setslice>:
SYSCALL(setslice)
 2bd:	b8 16 00 00 00       	mov    $0x16,%eax
 2c2:	cd 40                	int    $0x40
 2c4:	c3                   	ret    

000002c5 <getslice>:
SYSCALL(getslice)
 2c5:	b8 17 00 00 00       	mov    $0x17,%eax
 2ca:	cd 40                	int    $0x40
 2cc:	c3                   	ret    

000002cd <fork2>:
SYSCALL(fork2)
 2cd:	b8 18 00 00 00       	mov    $0x18,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <getpinfo>:
SYSCALL(getpinfo)
 2d5:	b8 19 00 00 00       	mov    $0x19,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2dd:	55                   	push   %ebp
 2de:	89 e5                	mov    %esp,%ebp
 2e0:	83 ec 1c             	sub    $0x1c,%esp
 2e3:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2e6:	6a 01                	push   $0x1
 2e8:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2eb:	52                   	push   %edx
 2ec:	50                   	push   %eax
 2ed:	e8 4b ff ff ff       	call   23d <write>
}
 2f2:	83 c4 10             	add    $0x10,%esp
 2f5:	c9                   	leave  
 2f6:	c3                   	ret    

000002f7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2f7:	55                   	push   %ebp
 2f8:	89 e5                	mov    %esp,%ebp
 2fa:	57                   	push   %edi
 2fb:	56                   	push   %esi
 2fc:	53                   	push   %ebx
 2fd:	83 ec 2c             	sub    $0x2c,%esp
 300:	89 45 d0             	mov    %eax,-0x30(%ebp)
 303:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 305:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 309:	0f 95 c2             	setne  %dl
 30c:	89 f0                	mov    %esi,%eax
 30e:	c1 e8 1f             	shr    $0x1f,%eax
 311:	84 c2                	test   %al,%dl
 313:	74 42                	je     357 <printint+0x60>
    neg = 1;
    x = -xx;
 315:	f7 de                	neg    %esi
    neg = 1;
 317:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 31e:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 323:	89 f0                	mov    %esi,%eax
 325:	ba 00 00 00 00       	mov    $0x0,%edx
 32a:	f7 f1                	div    %ecx
 32c:	89 df                	mov    %ebx,%edi
 32e:	83 c3 01             	add    $0x1,%ebx
 331:	0f b6 92 6c 06 00 00 	movzbl 0x66c(%edx),%edx
 338:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 33c:	89 f2                	mov    %esi,%edx
 33e:	89 c6                	mov    %eax,%esi
 340:	39 d1                	cmp    %edx,%ecx
 342:	76 df                	jbe    323 <printint+0x2c>
  if(neg)
 344:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 348:	74 2f                	je     379 <printint+0x82>
    buf[i++] = '-';
 34a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 34f:	8d 5f 02             	lea    0x2(%edi),%ebx
 352:	8b 75 d0             	mov    -0x30(%ebp),%esi
 355:	eb 15                	jmp    36c <printint+0x75>
  neg = 0;
 357:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 35e:	eb be                	jmp    31e <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 360:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 365:	89 f0                	mov    %esi,%eax
 367:	e8 71 ff ff ff       	call   2dd <putc>
  while(--i >= 0)
 36c:	83 eb 01             	sub    $0x1,%ebx
 36f:	79 ef                	jns    360 <printint+0x69>
}
 371:	83 c4 2c             	add    $0x2c,%esp
 374:	5b                   	pop    %ebx
 375:	5e                   	pop    %esi
 376:	5f                   	pop    %edi
 377:	5d                   	pop    %ebp
 378:	c3                   	ret    
 379:	8b 75 d0             	mov    -0x30(%ebp),%esi
 37c:	eb ee                	jmp    36c <printint+0x75>

0000037e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 37e:	f3 0f 1e fb          	endbr32 
 382:	55                   	push   %ebp
 383:	89 e5                	mov    %esp,%ebp
 385:	57                   	push   %edi
 386:	56                   	push   %esi
 387:	53                   	push   %ebx
 388:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 38b:	8d 45 10             	lea    0x10(%ebp),%eax
 38e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 391:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 396:	bb 00 00 00 00       	mov    $0x0,%ebx
 39b:	eb 14                	jmp    3b1 <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 39d:	89 fa                	mov    %edi,%edx
 39f:	8b 45 08             	mov    0x8(%ebp),%eax
 3a2:	e8 36 ff ff ff       	call   2dd <putc>
 3a7:	eb 05                	jmp    3ae <printf+0x30>
      }
    } else if(state == '%'){
 3a9:	83 fe 25             	cmp    $0x25,%esi
 3ac:	74 25                	je     3d3 <printf+0x55>
  for(i = 0; fmt[i]; i++){
 3ae:	83 c3 01             	add    $0x1,%ebx
 3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b4:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 3b8:	84 c0                	test   %al,%al
 3ba:	0f 84 23 01 00 00    	je     4e3 <printf+0x165>
    c = fmt[i] & 0xff;
 3c0:	0f be f8             	movsbl %al,%edi
 3c3:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 3c6:	85 f6                	test   %esi,%esi
 3c8:	75 df                	jne    3a9 <printf+0x2b>
      if(c == '%'){
 3ca:	83 f8 25             	cmp    $0x25,%eax
 3cd:	75 ce                	jne    39d <printf+0x1f>
        state = '%';
 3cf:	89 c6                	mov    %eax,%esi
 3d1:	eb db                	jmp    3ae <printf+0x30>
      if(c == 'd'){
 3d3:	83 f8 64             	cmp    $0x64,%eax
 3d6:	74 49                	je     421 <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3d8:	83 f8 78             	cmp    $0x78,%eax
 3db:	0f 94 c1             	sete   %cl
 3de:	83 f8 70             	cmp    $0x70,%eax
 3e1:	0f 94 c2             	sete   %dl
 3e4:	08 d1                	or     %dl,%cl
 3e6:	75 63                	jne    44b <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3e8:	83 f8 73             	cmp    $0x73,%eax
 3eb:	0f 84 84 00 00 00    	je     475 <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3f1:	83 f8 63             	cmp    $0x63,%eax
 3f4:	0f 84 b7 00 00 00    	je     4b1 <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3fa:	83 f8 25             	cmp    $0x25,%eax
 3fd:	0f 84 cc 00 00 00    	je     4cf <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 403:	ba 25 00 00 00       	mov    $0x25,%edx
 408:	8b 45 08             	mov    0x8(%ebp),%eax
 40b:	e8 cd fe ff ff       	call   2dd <putc>
        putc(fd, c);
 410:	89 fa                	mov    %edi,%edx
 412:	8b 45 08             	mov    0x8(%ebp),%eax
 415:	e8 c3 fe ff ff       	call   2dd <putc>
      }
      state = 0;
 41a:	be 00 00 00 00       	mov    $0x0,%esi
 41f:	eb 8d                	jmp    3ae <printf+0x30>
        printint(fd, *ap, 10, 1);
 421:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 424:	8b 17                	mov    (%edi),%edx
 426:	83 ec 0c             	sub    $0xc,%esp
 429:	6a 01                	push   $0x1
 42b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 430:	8b 45 08             	mov    0x8(%ebp),%eax
 433:	e8 bf fe ff ff       	call   2f7 <printint>
        ap++;
 438:	83 c7 04             	add    $0x4,%edi
 43b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 43e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 441:	be 00 00 00 00       	mov    $0x0,%esi
 446:	e9 63 ff ff ff       	jmp    3ae <printf+0x30>
        printint(fd, *ap, 16, 0);
 44b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 44e:	8b 17                	mov    (%edi),%edx
 450:	83 ec 0c             	sub    $0xc,%esp
 453:	6a 00                	push   $0x0
 455:	b9 10 00 00 00       	mov    $0x10,%ecx
 45a:	8b 45 08             	mov    0x8(%ebp),%eax
 45d:	e8 95 fe ff ff       	call   2f7 <printint>
        ap++;
 462:	83 c7 04             	add    $0x4,%edi
 465:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 468:	83 c4 10             	add    $0x10,%esp
      state = 0;
 46b:	be 00 00 00 00       	mov    $0x0,%esi
 470:	e9 39 ff ff ff       	jmp    3ae <printf+0x30>
        s = (char*)*ap;
 475:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 478:	8b 30                	mov    (%eax),%esi
        ap++;
 47a:	83 c0 04             	add    $0x4,%eax
 47d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 480:	85 f6                	test   %esi,%esi
 482:	75 28                	jne    4ac <printf+0x12e>
          s = "(null)";
 484:	be 63 06 00 00       	mov    $0x663,%esi
 489:	8b 7d 08             	mov    0x8(%ebp),%edi
 48c:	eb 0d                	jmp    49b <printf+0x11d>
          putc(fd, *s);
 48e:	0f be d2             	movsbl %dl,%edx
 491:	89 f8                	mov    %edi,%eax
 493:	e8 45 fe ff ff       	call   2dd <putc>
          s++;
 498:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 49b:	0f b6 16             	movzbl (%esi),%edx
 49e:	84 d2                	test   %dl,%dl
 4a0:	75 ec                	jne    48e <printf+0x110>
      state = 0;
 4a2:	be 00 00 00 00       	mov    $0x0,%esi
 4a7:	e9 02 ff ff ff       	jmp    3ae <printf+0x30>
 4ac:	8b 7d 08             	mov    0x8(%ebp),%edi
 4af:	eb ea                	jmp    49b <printf+0x11d>
        putc(fd, *ap);
 4b1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4b4:	0f be 17             	movsbl (%edi),%edx
 4b7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ba:	e8 1e fe ff ff       	call   2dd <putc>
        ap++;
 4bf:	83 c7 04             	add    $0x4,%edi
 4c2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 4c5:	be 00 00 00 00       	mov    $0x0,%esi
 4ca:	e9 df fe ff ff       	jmp    3ae <printf+0x30>
        putc(fd, c);
 4cf:	89 fa                	mov    %edi,%edx
 4d1:	8b 45 08             	mov    0x8(%ebp),%eax
 4d4:	e8 04 fe ff ff       	call   2dd <putc>
      state = 0;
 4d9:	be 00 00 00 00       	mov    $0x0,%esi
 4de:	e9 cb fe ff ff       	jmp    3ae <printf+0x30>
    }
  }
}
 4e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e6:	5b                   	pop    %ebx
 4e7:	5e                   	pop    %esi
 4e8:	5f                   	pop    %edi
 4e9:	5d                   	pop    %ebp
 4ea:	c3                   	ret    

000004eb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4eb:	f3 0f 1e fb          	endbr32 
 4ef:	55                   	push   %ebp
 4f0:	89 e5                	mov    %esp,%ebp
 4f2:	57                   	push   %edi
 4f3:	56                   	push   %esi
 4f4:	53                   	push   %ebx
 4f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4f8:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4fb:	a1 10 09 00 00       	mov    0x910,%eax
 500:	eb 02                	jmp    504 <free+0x19>
 502:	89 d0                	mov    %edx,%eax
 504:	39 c8                	cmp    %ecx,%eax
 506:	73 04                	jae    50c <free+0x21>
 508:	39 08                	cmp    %ecx,(%eax)
 50a:	77 12                	ja     51e <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 50c:	8b 10                	mov    (%eax),%edx
 50e:	39 c2                	cmp    %eax,%edx
 510:	77 f0                	ja     502 <free+0x17>
 512:	39 c8                	cmp    %ecx,%eax
 514:	72 08                	jb     51e <free+0x33>
 516:	39 ca                	cmp    %ecx,%edx
 518:	77 04                	ja     51e <free+0x33>
 51a:	89 d0                	mov    %edx,%eax
 51c:	eb e6                	jmp    504 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 51e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 521:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 524:	8b 10                	mov    (%eax),%edx
 526:	39 d7                	cmp    %edx,%edi
 528:	74 19                	je     543 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 52a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 52d:	8b 50 04             	mov    0x4(%eax),%edx
 530:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 533:	39 ce                	cmp    %ecx,%esi
 535:	74 1b                	je     552 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 537:	89 08                	mov    %ecx,(%eax)
  freep = p;
 539:	a3 10 09 00 00       	mov    %eax,0x910
}
 53e:	5b                   	pop    %ebx
 53f:	5e                   	pop    %esi
 540:	5f                   	pop    %edi
 541:	5d                   	pop    %ebp
 542:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 543:	03 72 04             	add    0x4(%edx),%esi
 546:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 549:	8b 10                	mov    (%eax),%edx
 54b:	8b 12                	mov    (%edx),%edx
 54d:	89 53 f8             	mov    %edx,-0x8(%ebx)
 550:	eb db                	jmp    52d <free+0x42>
    p->s.size += bp->s.size;
 552:	03 53 fc             	add    -0x4(%ebx),%edx
 555:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 558:	8b 53 f8             	mov    -0x8(%ebx),%edx
 55b:	89 10                	mov    %edx,(%eax)
 55d:	eb da                	jmp    539 <free+0x4e>

0000055f <morecore>:

static Header*
morecore(uint nu)
{
 55f:	55                   	push   %ebp
 560:	89 e5                	mov    %esp,%ebp
 562:	53                   	push   %ebx
 563:	83 ec 04             	sub    $0x4,%esp
 566:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 568:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 56d:	77 05                	ja     574 <morecore+0x15>
    nu = 4096;
 56f:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 574:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 57b:	83 ec 0c             	sub    $0xc,%esp
 57e:	50                   	push   %eax
 57f:	e8 21 fd ff ff       	call   2a5 <sbrk>
  if(p == (char*)-1)
 584:	83 c4 10             	add    $0x10,%esp
 587:	83 f8 ff             	cmp    $0xffffffff,%eax
 58a:	74 1c                	je     5a8 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 58c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 58f:	83 c0 08             	add    $0x8,%eax
 592:	83 ec 0c             	sub    $0xc,%esp
 595:	50                   	push   %eax
 596:	e8 50 ff ff ff       	call   4eb <free>
  return freep;
 59b:	a1 10 09 00 00       	mov    0x910,%eax
 5a0:	83 c4 10             	add    $0x10,%esp
}
 5a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5a6:	c9                   	leave  
 5a7:	c3                   	ret    
    return 0;
 5a8:	b8 00 00 00 00       	mov    $0x0,%eax
 5ad:	eb f4                	jmp    5a3 <morecore+0x44>

000005af <malloc>:

void*
malloc(uint nbytes)
{
 5af:	f3 0f 1e fb          	endbr32 
 5b3:	55                   	push   %ebp
 5b4:	89 e5                	mov    %esp,%ebp
 5b6:	53                   	push   %ebx
 5b7:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5ba:	8b 45 08             	mov    0x8(%ebp),%eax
 5bd:	8d 58 07             	lea    0x7(%eax),%ebx
 5c0:	c1 eb 03             	shr    $0x3,%ebx
 5c3:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5c6:	8b 0d 10 09 00 00    	mov    0x910,%ecx
 5cc:	85 c9                	test   %ecx,%ecx
 5ce:	74 04                	je     5d4 <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5d0:	8b 01                	mov    (%ecx),%eax
 5d2:	eb 4b                	jmp    61f <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 5d4:	c7 05 10 09 00 00 14 	movl   $0x914,0x910
 5db:	09 00 00 
 5de:	c7 05 14 09 00 00 14 	movl   $0x914,0x914
 5e5:	09 00 00 
    base.s.size = 0;
 5e8:	c7 05 18 09 00 00 00 	movl   $0x0,0x918
 5ef:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5f2:	b9 14 09 00 00       	mov    $0x914,%ecx
 5f7:	eb d7                	jmp    5d0 <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5f9:	74 1a                	je     615 <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5fb:	29 da                	sub    %ebx,%edx
 5fd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 600:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 603:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 606:	89 0d 10 09 00 00    	mov    %ecx,0x910
      return (void*)(p + 1);
 60c:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 60f:	83 c4 04             	add    $0x4,%esp
 612:	5b                   	pop    %ebx
 613:	5d                   	pop    %ebp
 614:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 615:	8b 10                	mov    (%eax),%edx
 617:	89 11                	mov    %edx,(%ecx)
 619:	eb eb                	jmp    606 <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 61b:	89 c1                	mov    %eax,%ecx
 61d:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 61f:	8b 50 04             	mov    0x4(%eax),%edx
 622:	39 da                	cmp    %ebx,%edx
 624:	73 d3                	jae    5f9 <malloc+0x4a>
    if(p == freep)
 626:	39 05 10 09 00 00    	cmp    %eax,0x910
 62c:	75 ed                	jne    61b <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 62e:	89 d8                	mov    %ebx,%eax
 630:	e8 2a ff ff ff       	call   55f <morecore>
 635:	85 c0                	test   %eax,%eax
 637:	75 e2                	jne    61b <malloc+0x6c>
 639:	eb d4                	jmp    60f <malloc+0x60>
