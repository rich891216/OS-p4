
_schedtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"
#include "syscall.h"
#include <stddef.h>

int main(int argc, char *argv[]) {
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 28             	sub    $0x28,%esp
  18:	8b 59 04             	mov    0x4(%ecx),%ebx
    if (argc != 6) {
  1b:	83 39 06             	cmpl   $0x6,(%ecx)
  1e:	75 77                	jne    97 <main+0x97>
        // incorrect number of arguments
        exit();
    }
    int sliceA = atoi(argv[1]);
  20:	83 ec 0c             	sub    $0xc,%esp
  23:	ff 73 04             	pushl  0x4(%ebx)
  26:	e8 1a 02 00 00       	call   245 <atoi>
  2b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    char *sleepA = argv[2];
  2e:	8b 73 08             	mov    0x8(%ebx),%esi
    int sliceB = atoi(argv[3]);
  31:	83 c4 04             	add    $0x4,%esp
  34:	ff 73 0c             	pushl  0xc(%ebx)
  37:	e8 09 02 00 00       	call   245 <atoi>
  3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
    char *sleepB = argv[4];
  3f:	8b 7b 10             	mov    0x10(%ebx),%edi
    int sleepParent = atoi(argv[5]);
  42:	83 c4 04             	add    $0x4,%esp
  45:	ff 73 14             	pushl  0x14(%ebx)
  48:	e8 f8 01 00 00       	call   245 <atoi>
  4d:	89 c3                	mov    %eax,%ebx


    int childA = fork2(sliceA);
  4f:	83 c4 04             	add    $0x4,%esp
  52:	ff 75 d4             	pushl  -0x2c(%ebp)
  55:	e8 05 03 00 00       	call   35f <fork2>
    if(childA == 0) {
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	85 c0                	test   %eax,%eax
  5f:	75 3b                	jne    9c <main+0x9c>
        char *args[] = {"./loop", sleepA, NULL};
  61:	c7 45 dc d0 06 00 00 	movl   $0x6d0,-0x24(%ebp)
  68:	89 75 e0             	mov    %esi,-0x20(%ebp)
  6b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
        // exec
        exec("./loop", args);
  72:	83 ec 08             	sub    $0x8,%esp
  75:	8d 45 dc             	lea    -0x24(%ebp),%eax
  78:	50                   	push   %eax
  79:	68 d0 06 00 00       	push   $0x6d0
  7e:	e8 64 02 00 00       	call   2e7 <exec>
  83:	83 c4 10             	add    $0x10,%esp
            printf(1, "parent slept");
            // getpinfo
        }
    }
    return 0;
}
  86:	b8 00 00 00 00       	mov    $0x0,%eax
  8b:	8d 65 f0             	lea    -0x10(%ebp),%esp
  8e:	59                   	pop    %ecx
  8f:	5b                   	pop    %ebx
  90:	5e                   	pop    %esi
  91:	5f                   	pop    %edi
  92:	5d                   	pop    %ebp
  93:	8d 61 fc             	lea    -0x4(%ecx),%esp
  96:	c3                   	ret    
        exit();
  97:	e8 13 02 00 00       	call   2af <exit>
        int childB = fork2(sliceB);
  9c:	83 ec 0c             	sub    $0xc,%esp
  9f:	ff 75 d0             	pushl  -0x30(%ebp)
  a2:	e8 b8 02 00 00       	call   35f <fork2>
        if(childB == 0) {
  a7:	83 c4 10             	add    $0x10,%esp
  aa:	85 c0                	test   %eax,%eax
  ac:	75 27                	jne    d5 <main+0xd5>
            char *args[] = {"./loop", sleepB, NULL};
  ae:	c7 45 dc d0 06 00 00 	movl   $0x6d0,-0x24(%ebp)
  b5:	89 7d e0             	mov    %edi,-0x20(%ebp)
  b8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
            exec("./loop", args);
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	8d 45 dc             	lea    -0x24(%ebp),%eax
  c5:	50                   	push   %eax
  c6:	68 d0 06 00 00       	push   $0x6d0
  cb:	e8 17 02 00 00       	call   2e7 <exec>
  d0:	83 c4 10             	add    $0x10,%esp
  d3:	eb b1                	jmp    86 <main+0x86>
            sleep(sleepParent);
  d5:	83 ec 0c             	sub    $0xc,%esp
  d8:	53                   	push   %ebx
  d9:	e8 61 02 00 00       	call   33f <sleep>
            printf(1, "parent slept");
  de:	83 c4 08             	add    $0x8,%esp
  e1:	68 d7 06 00 00       	push   $0x6d7
  e6:	6a 01                	push   $0x1
  e8:	e8 23 03 00 00       	call   410 <printf>
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	eb 94                	jmp    86 <main+0x86>

000000f2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f2:	f3 0f 1e fb          	endbr32 
  f6:	55                   	push   %ebp
  f7:	89 e5                	mov    %esp,%ebp
  f9:	56                   	push   %esi
  fa:	53                   	push   %ebx
  fb:	8b 75 08             	mov    0x8(%ebp),%esi
  fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 101:	89 f0                	mov    %esi,%eax
 103:	89 d1                	mov    %edx,%ecx
 105:	83 c2 01             	add    $0x1,%edx
 108:	89 c3                	mov    %eax,%ebx
 10a:	83 c0 01             	add    $0x1,%eax
 10d:	0f b6 09             	movzbl (%ecx),%ecx
 110:	88 0b                	mov    %cl,(%ebx)
 112:	84 c9                	test   %cl,%cl
 114:	75 ed                	jne    103 <strcpy+0x11>
    ;
  return os;
}
 116:	89 f0                	mov    %esi,%eax
 118:	5b                   	pop    %ebx
 119:	5e                   	pop    %esi
 11a:	5d                   	pop    %ebp
 11b:	c3                   	ret    

0000011c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11c:	f3 0f 1e fb          	endbr32 
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
 126:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 129:	0f b6 01             	movzbl (%ecx),%eax
 12c:	84 c0                	test   %al,%al
 12e:	74 0c                	je     13c <strcmp+0x20>
 130:	3a 02                	cmp    (%edx),%al
 132:	75 08                	jne    13c <strcmp+0x20>
    p++, q++;
 134:	83 c1 01             	add    $0x1,%ecx
 137:	83 c2 01             	add    $0x1,%edx
 13a:	eb ed                	jmp    129 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 13c:	0f b6 c0             	movzbl %al,%eax
 13f:	0f b6 12             	movzbl (%edx),%edx
 142:	29 d0                	sub    %edx,%eax
}
 144:	5d                   	pop    %ebp
 145:	c3                   	ret    

00000146 <strlen>:

uint
strlen(const char *s)
{
 146:	f3 0f 1e fb          	endbr32 
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 150:	b8 00 00 00 00       	mov    $0x0,%eax
 155:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 159:	74 05                	je     160 <strlen+0x1a>
 15b:	83 c0 01             	add    $0x1,%eax
 15e:	eb f5                	jmp    155 <strlen+0xf>
    ;
  return n;
}
 160:	5d                   	pop    %ebp
 161:	c3                   	ret    

00000162 <memset>:

void*
memset(void *dst, int c, uint n)
{
 162:	f3 0f 1e fb          	endbr32 
 166:	55                   	push   %ebp
 167:	89 e5                	mov    %esp,%ebp
 169:	57                   	push   %edi
 16a:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 16d:	89 d7                	mov    %edx,%edi
 16f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 172:	8b 45 0c             	mov    0xc(%ebp),%eax
 175:	fc                   	cld    
 176:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 178:	89 d0                	mov    %edx,%eax
 17a:	5f                   	pop    %edi
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret    

0000017d <strchr>:

char*
strchr(const char *s, char c)
{
 17d:	f3 0f 1e fb          	endbr32 
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 18b:	0f b6 10             	movzbl (%eax),%edx
 18e:	84 d2                	test   %dl,%dl
 190:	74 09                	je     19b <strchr+0x1e>
    if(*s == c)
 192:	38 ca                	cmp    %cl,%dl
 194:	74 0a                	je     1a0 <strchr+0x23>
  for(; *s; s++)
 196:	83 c0 01             	add    $0x1,%eax
 199:	eb f0                	jmp    18b <strchr+0xe>
      return (char*)s;
  return 0;
 19b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1a0:	5d                   	pop    %ebp
 1a1:	c3                   	ret    

000001a2 <gets>:

char*
gets(char *buf, int max)
{
 1a2:	f3 0f 1e fb          	endbr32 
 1a6:	55                   	push   %ebp
 1a7:	89 e5                	mov    %esp,%ebp
 1a9:	57                   	push   %edi
 1aa:	56                   	push   %esi
 1ab:	53                   	push   %ebx
 1ac:	83 ec 1c             	sub    $0x1c,%esp
 1af:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b2:	bb 00 00 00 00       	mov    $0x0,%ebx
 1b7:	89 de                	mov    %ebx,%esi
 1b9:	83 c3 01             	add    $0x1,%ebx
 1bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1bf:	7d 2e                	jge    1ef <gets+0x4d>
    cc = read(0, &c, 1);
 1c1:	83 ec 04             	sub    $0x4,%esp
 1c4:	6a 01                	push   $0x1
 1c6:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1c9:	50                   	push   %eax
 1ca:	6a 00                	push   $0x0
 1cc:	e8 f6 00 00 00       	call   2c7 <read>
    if(cc < 1)
 1d1:	83 c4 10             	add    $0x10,%esp
 1d4:	85 c0                	test   %eax,%eax
 1d6:	7e 17                	jle    1ef <gets+0x4d>
      break;
    buf[i++] = c;
 1d8:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1dc:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 1df:	3c 0a                	cmp    $0xa,%al
 1e1:	0f 94 c2             	sete   %dl
 1e4:	3c 0d                	cmp    $0xd,%al
 1e6:	0f 94 c0             	sete   %al
 1e9:	08 c2                	or     %al,%dl
 1eb:	74 ca                	je     1b7 <gets+0x15>
    buf[i++] = c;
 1ed:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 1ef:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 1f3:	89 f8                	mov    %edi,%eax
 1f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f8:	5b                   	pop    %ebx
 1f9:	5e                   	pop    %esi
 1fa:	5f                   	pop    %edi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    

000001fd <stat>:

int
stat(const char *n, struct stat *st)
{
 1fd:	f3 0f 1e fb          	endbr32 
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 206:	83 ec 08             	sub    $0x8,%esp
 209:	6a 00                	push   $0x0
 20b:	ff 75 08             	pushl  0x8(%ebp)
 20e:	e8 dc 00 00 00       	call   2ef <open>
  if(fd < 0)
 213:	83 c4 10             	add    $0x10,%esp
 216:	85 c0                	test   %eax,%eax
 218:	78 24                	js     23e <stat+0x41>
 21a:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 21c:	83 ec 08             	sub    $0x8,%esp
 21f:	ff 75 0c             	pushl  0xc(%ebp)
 222:	50                   	push   %eax
 223:	e8 df 00 00 00       	call   307 <fstat>
 228:	89 c6                	mov    %eax,%esi
  close(fd);
 22a:	89 1c 24             	mov    %ebx,(%esp)
 22d:	e8 a5 00 00 00       	call   2d7 <close>
  return r;
 232:	83 c4 10             	add    $0x10,%esp
}
 235:	89 f0                	mov    %esi,%eax
 237:	8d 65 f8             	lea    -0x8(%ebp),%esp
 23a:	5b                   	pop    %ebx
 23b:	5e                   	pop    %esi
 23c:	5d                   	pop    %ebp
 23d:	c3                   	ret    
    return -1;
 23e:	be ff ff ff ff       	mov    $0xffffffff,%esi
 243:	eb f0                	jmp    235 <stat+0x38>

00000245 <atoi>:

int
atoi(const char *s)
{
 245:	f3 0f 1e fb          	endbr32 
 249:	55                   	push   %ebp
 24a:	89 e5                	mov    %esp,%ebp
 24c:	53                   	push   %ebx
 24d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 250:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 255:	0f b6 01             	movzbl (%ecx),%eax
 258:	8d 58 d0             	lea    -0x30(%eax),%ebx
 25b:	80 fb 09             	cmp    $0x9,%bl
 25e:	77 12                	ja     272 <atoi+0x2d>
    n = n*10 + *s++ - '0';
 260:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 263:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 266:	83 c1 01             	add    $0x1,%ecx
 269:	0f be c0             	movsbl %al,%eax
 26c:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
 270:	eb e3                	jmp    255 <atoi+0x10>
  return n;
}
 272:	89 d0                	mov    %edx,%eax
 274:	5b                   	pop    %ebx
 275:	5d                   	pop    %ebp
 276:	c3                   	ret    

00000277 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 277:	f3 0f 1e fb          	endbr32 
 27b:	55                   	push   %ebp
 27c:	89 e5                	mov    %esp,%ebp
 27e:	56                   	push   %esi
 27f:	53                   	push   %ebx
 280:	8b 75 08             	mov    0x8(%ebp),%esi
 283:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 286:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 289:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 28b:	8d 58 ff             	lea    -0x1(%eax),%ebx
 28e:	85 c0                	test   %eax,%eax
 290:	7e 0f                	jle    2a1 <memmove+0x2a>
    *dst++ = *src++;
 292:	0f b6 01             	movzbl (%ecx),%eax
 295:	88 02                	mov    %al,(%edx)
 297:	8d 49 01             	lea    0x1(%ecx),%ecx
 29a:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 29d:	89 d8                	mov    %ebx,%eax
 29f:	eb ea                	jmp    28b <memmove+0x14>
  return vdst;
}
 2a1:	89 f0                	mov    %esi,%eax
 2a3:	5b                   	pop    %ebx
 2a4:	5e                   	pop    %esi
 2a5:	5d                   	pop    %ebp
 2a6:	c3                   	ret    

000002a7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a7:	b8 01 00 00 00       	mov    $0x1,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <exit>:
SYSCALL(exit)
 2af:	b8 02 00 00 00       	mov    $0x2,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <wait>:
SYSCALL(wait)
 2b7:	b8 03 00 00 00       	mov    $0x3,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <pipe>:
SYSCALL(pipe)
 2bf:	b8 04 00 00 00       	mov    $0x4,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <read>:
SYSCALL(read)
 2c7:	b8 05 00 00 00       	mov    $0x5,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <write>:
SYSCALL(write)
 2cf:	b8 10 00 00 00       	mov    $0x10,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <close>:
SYSCALL(close)
 2d7:	b8 15 00 00 00       	mov    $0x15,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <kill>:
SYSCALL(kill)
 2df:	b8 06 00 00 00       	mov    $0x6,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <exec>:
SYSCALL(exec)
 2e7:	b8 07 00 00 00       	mov    $0x7,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <open>:
SYSCALL(open)
 2ef:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <mknod>:
SYSCALL(mknod)
 2f7:	b8 11 00 00 00       	mov    $0x11,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <unlink>:
SYSCALL(unlink)
 2ff:	b8 12 00 00 00       	mov    $0x12,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <fstat>:
SYSCALL(fstat)
 307:	b8 08 00 00 00       	mov    $0x8,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <link>:
SYSCALL(link)
 30f:	b8 13 00 00 00       	mov    $0x13,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <mkdir>:
SYSCALL(mkdir)
 317:	b8 14 00 00 00       	mov    $0x14,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <chdir>:
SYSCALL(chdir)
 31f:	b8 09 00 00 00       	mov    $0x9,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <dup>:
SYSCALL(dup)
 327:	b8 0a 00 00 00       	mov    $0xa,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <getpid>:
SYSCALL(getpid)
 32f:	b8 0b 00 00 00       	mov    $0xb,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <sbrk>:
SYSCALL(sbrk)
 337:	b8 0c 00 00 00       	mov    $0xc,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <sleep>:
SYSCALL(sleep)
 33f:	b8 0d 00 00 00       	mov    $0xd,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <uptime>:
SYSCALL(uptime)
 347:	b8 0e 00 00 00       	mov    $0xe,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <setslice>:
SYSCALL(setslice)
 34f:	b8 16 00 00 00       	mov    $0x16,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <getslice>:
SYSCALL(getslice)
 357:	b8 17 00 00 00       	mov    $0x17,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <fork2>:
SYSCALL(fork2)
 35f:	b8 18 00 00 00       	mov    $0x18,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <getpinfo>:
SYSCALL(getpinfo)
 367:	b8 19 00 00 00       	mov    $0x19,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 36f:	55                   	push   %ebp
 370:	89 e5                	mov    %esp,%ebp
 372:	83 ec 1c             	sub    $0x1c,%esp
 375:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 378:	6a 01                	push   $0x1
 37a:	8d 55 f4             	lea    -0xc(%ebp),%edx
 37d:	52                   	push   %edx
 37e:	50                   	push   %eax
 37f:	e8 4b ff ff ff       	call   2cf <write>
}
 384:	83 c4 10             	add    $0x10,%esp
 387:	c9                   	leave  
 388:	c3                   	ret    

00000389 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 389:	55                   	push   %ebp
 38a:	89 e5                	mov    %esp,%ebp
 38c:	57                   	push   %edi
 38d:	56                   	push   %esi
 38e:	53                   	push   %ebx
 38f:	83 ec 2c             	sub    $0x2c,%esp
 392:	89 45 d0             	mov    %eax,-0x30(%ebp)
 395:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 397:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 39b:	0f 95 c2             	setne  %dl
 39e:	89 f0                	mov    %esi,%eax
 3a0:	c1 e8 1f             	shr    $0x1f,%eax
 3a3:	84 c2                	test   %al,%dl
 3a5:	74 42                	je     3e9 <printint+0x60>
    neg = 1;
    x = -xx;
 3a7:	f7 de                	neg    %esi
    neg = 1;
 3a9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3b0:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 3b5:	89 f0                	mov    %esi,%eax
 3b7:	ba 00 00 00 00       	mov    $0x0,%edx
 3bc:	f7 f1                	div    %ecx
 3be:	89 df                	mov    %ebx,%edi
 3c0:	83 c3 01             	add    $0x1,%ebx
 3c3:	0f b6 92 ec 06 00 00 	movzbl 0x6ec(%edx),%edx
 3ca:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 3ce:	89 f2                	mov    %esi,%edx
 3d0:	89 c6                	mov    %eax,%esi
 3d2:	39 d1                	cmp    %edx,%ecx
 3d4:	76 df                	jbe    3b5 <printint+0x2c>
  if(neg)
 3d6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 3da:	74 2f                	je     40b <printint+0x82>
    buf[i++] = '-';
 3dc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3e1:	8d 5f 02             	lea    0x2(%edi),%ebx
 3e4:	8b 75 d0             	mov    -0x30(%ebp),%esi
 3e7:	eb 15                	jmp    3fe <printint+0x75>
  neg = 0;
 3e9:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 3f0:	eb be                	jmp    3b0 <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 3f2:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 3f7:	89 f0                	mov    %esi,%eax
 3f9:	e8 71 ff ff ff       	call   36f <putc>
  while(--i >= 0)
 3fe:	83 eb 01             	sub    $0x1,%ebx
 401:	79 ef                	jns    3f2 <printint+0x69>
}
 403:	83 c4 2c             	add    $0x2c,%esp
 406:	5b                   	pop    %ebx
 407:	5e                   	pop    %esi
 408:	5f                   	pop    %edi
 409:	5d                   	pop    %ebp
 40a:	c3                   	ret    
 40b:	8b 75 d0             	mov    -0x30(%ebp),%esi
 40e:	eb ee                	jmp    3fe <printint+0x75>

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	f3 0f 1e fb          	endbr32 
 414:	55                   	push   %ebp
 415:	89 e5                	mov    %esp,%ebp
 417:	57                   	push   %edi
 418:	56                   	push   %esi
 419:	53                   	push   %ebx
 41a:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 41d:	8d 45 10             	lea    0x10(%ebp),%eax
 420:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 423:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 428:	bb 00 00 00 00       	mov    $0x0,%ebx
 42d:	eb 14                	jmp    443 <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 42f:	89 fa                	mov    %edi,%edx
 431:	8b 45 08             	mov    0x8(%ebp),%eax
 434:	e8 36 ff ff ff       	call   36f <putc>
 439:	eb 05                	jmp    440 <printf+0x30>
      }
    } else if(state == '%'){
 43b:	83 fe 25             	cmp    $0x25,%esi
 43e:	74 25                	je     465 <printf+0x55>
  for(i = 0; fmt[i]; i++){
 440:	83 c3 01             	add    $0x1,%ebx
 443:	8b 45 0c             	mov    0xc(%ebp),%eax
 446:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 44a:	84 c0                	test   %al,%al
 44c:	0f 84 23 01 00 00    	je     575 <printf+0x165>
    c = fmt[i] & 0xff;
 452:	0f be f8             	movsbl %al,%edi
 455:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 458:	85 f6                	test   %esi,%esi
 45a:	75 df                	jne    43b <printf+0x2b>
      if(c == '%'){
 45c:	83 f8 25             	cmp    $0x25,%eax
 45f:	75 ce                	jne    42f <printf+0x1f>
        state = '%';
 461:	89 c6                	mov    %eax,%esi
 463:	eb db                	jmp    440 <printf+0x30>
      if(c == 'd'){
 465:	83 f8 64             	cmp    $0x64,%eax
 468:	74 49                	je     4b3 <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 46a:	83 f8 78             	cmp    $0x78,%eax
 46d:	0f 94 c1             	sete   %cl
 470:	83 f8 70             	cmp    $0x70,%eax
 473:	0f 94 c2             	sete   %dl
 476:	08 d1                	or     %dl,%cl
 478:	75 63                	jne    4dd <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 47a:	83 f8 73             	cmp    $0x73,%eax
 47d:	0f 84 84 00 00 00    	je     507 <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 483:	83 f8 63             	cmp    $0x63,%eax
 486:	0f 84 b7 00 00 00    	je     543 <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 48c:	83 f8 25             	cmp    $0x25,%eax
 48f:	0f 84 cc 00 00 00    	je     561 <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 495:	ba 25 00 00 00       	mov    $0x25,%edx
 49a:	8b 45 08             	mov    0x8(%ebp),%eax
 49d:	e8 cd fe ff ff       	call   36f <putc>
        putc(fd, c);
 4a2:	89 fa                	mov    %edi,%edx
 4a4:	8b 45 08             	mov    0x8(%ebp),%eax
 4a7:	e8 c3 fe ff ff       	call   36f <putc>
      }
      state = 0;
 4ac:	be 00 00 00 00       	mov    $0x0,%esi
 4b1:	eb 8d                	jmp    440 <printf+0x30>
        printint(fd, *ap, 10, 1);
 4b3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4b6:	8b 17                	mov    (%edi),%edx
 4b8:	83 ec 0c             	sub    $0xc,%esp
 4bb:	6a 01                	push   $0x1
 4bd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4c2:	8b 45 08             	mov    0x8(%ebp),%eax
 4c5:	e8 bf fe ff ff       	call   389 <printint>
        ap++;
 4ca:	83 c7 04             	add    $0x4,%edi
 4cd:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4d0:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4d3:	be 00 00 00 00       	mov    $0x0,%esi
 4d8:	e9 63 ff ff ff       	jmp    440 <printf+0x30>
        printint(fd, *ap, 16, 0);
 4dd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4e0:	8b 17                	mov    (%edi),%edx
 4e2:	83 ec 0c             	sub    $0xc,%esp
 4e5:	6a 00                	push   $0x0
 4e7:	b9 10 00 00 00       	mov    $0x10,%ecx
 4ec:	8b 45 08             	mov    0x8(%ebp),%eax
 4ef:	e8 95 fe ff ff       	call   389 <printint>
        ap++;
 4f4:	83 c7 04             	add    $0x4,%edi
 4f7:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4fa:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4fd:	be 00 00 00 00       	mov    $0x0,%esi
 502:	e9 39 ff ff ff       	jmp    440 <printf+0x30>
        s = (char*)*ap;
 507:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50a:	8b 30                	mov    (%eax),%esi
        ap++;
 50c:	83 c0 04             	add    $0x4,%eax
 50f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 512:	85 f6                	test   %esi,%esi
 514:	75 28                	jne    53e <printf+0x12e>
          s = "(null)";
 516:	be e4 06 00 00       	mov    $0x6e4,%esi
 51b:	8b 7d 08             	mov    0x8(%ebp),%edi
 51e:	eb 0d                	jmp    52d <printf+0x11d>
          putc(fd, *s);
 520:	0f be d2             	movsbl %dl,%edx
 523:	89 f8                	mov    %edi,%eax
 525:	e8 45 fe ff ff       	call   36f <putc>
          s++;
 52a:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 52d:	0f b6 16             	movzbl (%esi),%edx
 530:	84 d2                	test   %dl,%dl
 532:	75 ec                	jne    520 <printf+0x110>
      state = 0;
 534:	be 00 00 00 00       	mov    $0x0,%esi
 539:	e9 02 ff ff ff       	jmp    440 <printf+0x30>
 53e:	8b 7d 08             	mov    0x8(%ebp),%edi
 541:	eb ea                	jmp    52d <printf+0x11d>
        putc(fd, *ap);
 543:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 546:	0f be 17             	movsbl (%edi),%edx
 549:	8b 45 08             	mov    0x8(%ebp),%eax
 54c:	e8 1e fe ff ff       	call   36f <putc>
        ap++;
 551:	83 c7 04             	add    $0x4,%edi
 554:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 557:	be 00 00 00 00       	mov    $0x0,%esi
 55c:	e9 df fe ff ff       	jmp    440 <printf+0x30>
        putc(fd, c);
 561:	89 fa                	mov    %edi,%edx
 563:	8b 45 08             	mov    0x8(%ebp),%eax
 566:	e8 04 fe ff ff       	call   36f <putc>
      state = 0;
 56b:	be 00 00 00 00       	mov    $0x0,%esi
 570:	e9 cb fe ff ff       	jmp    440 <printf+0x30>
    }
  }
}
 575:	8d 65 f4             	lea    -0xc(%ebp),%esp
 578:	5b                   	pop    %ebx
 579:	5e                   	pop    %esi
 57a:	5f                   	pop    %edi
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret    

0000057d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 57d:	f3 0f 1e fb          	endbr32 
 581:	55                   	push   %ebp
 582:	89 e5                	mov    %esp,%ebp
 584:	57                   	push   %edi
 585:	56                   	push   %esi
 586:	53                   	push   %ebx
 587:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 58a:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 58d:	a1 b0 09 00 00       	mov    0x9b0,%eax
 592:	eb 02                	jmp    596 <free+0x19>
 594:	89 d0                	mov    %edx,%eax
 596:	39 c8                	cmp    %ecx,%eax
 598:	73 04                	jae    59e <free+0x21>
 59a:	39 08                	cmp    %ecx,(%eax)
 59c:	77 12                	ja     5b0 <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59e:	8b 10                	mov    (%eax),%edx
 5a0:	39 c2                	cmp    %eax,%edx
 5a2:	77 f0                	ja     594 <free+0x17>
 5a4:	39 c8                	cmp    %ecx,%eax
 5a6:	72 08                	jb     5b0 <free+0x33>
 5a8:	39 ca                	cmp    %ecx,%edx
 5aa:	77 04                	ja     5b0 <free+0x33>
 5ac:	89 d0                	mov    %edx,%eax
 5ae:	eb e6                	jmp    596 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5b6:	8b 10                	mov    (%eax),%edx
 5b8:	39 d7                	cmp    %edx,%edi
 5ba:	74 19                	je     5d5 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5bc:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5bf:	8b 50 04             	mov    0x4(%eax),%edx
 5c2:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5c5:	39 ce                	cmp    %ecx,%esi
 5c7:	74 1b                	je     5e4 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5c9:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5cb:	a3 b0 09 00 00       	mov    %eax,0x9b0
}
 5d0:	5b                   	pop    %ebx
 5d1:	5e                   	pop    %esi
 5d2:	5f                   	pop    %edi
 5d3:	5d                   	pop    %ebp
 5d4:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 5d5:	03 72 04             	add    0x4(%edx),%esi
 5d8:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5db:	8b 10                	mov    (%eax),%edx
 5dd:	8b 12                	mov    (%edx),%edx
 5df:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5e2:	eb db                	jmp    5bf <free+0x42>
    p->s.size += bp->s.size;
 5e4:	03 53 fc             	add    -0x4(%ebx),%edx
 5e7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5ea:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5ed:	89 10                	mov    %edx,(%eax)
 5ef:	eb da                	jmp    5cb <free+0x4e>

000005f1 <morecore>:

static Header*
morecore(uint nu)
{
 5f1:	55                   	push   %ebp
 5f2:	89 e5                	mov    %esp,%ebp
 5f4:	53                   	push   %ebx
 5f5:	83 ec 04             	sub    $0x4,%esp
 5f8:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 5fa:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 5ff:	77 05                	ja     606 <morecore+0x15>
    nu = 4096;
 601:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 606:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 60d:	83 ec 0c             	sub    $0xc,%esp
 610:	50                   	push   %eax
 611:	e8 21 fd ff ff       	call   337 <sbrk>
  if(p == (char*)-1)
 616:	83 c4 10             	add    $0x10,%esp
 619:	83 f8 ff             	cmp    $0xffffffff,%eax
 61c:	74 1c                	je     63a <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 61e:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 621:	83 c0 08             	add    $0x8,%eax
 624:	83 ec 0c             	sub    $0xc,%esp
 627:	50                   	push   %eax
 628:	e8 50 ff ff ff       	call   57d <free>
  return freep;
 62d:	a1 b0 09 00 00       	mov    0x9b0,%eax
 632:	83 c4 10             	add    $0x10,%esp
}
 635:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 638:	c9                   	leave  
 639:	c3                   	ret    
    return 0;
 63a:	b8 00 00 00 00       	mov    $0x0,%eax
 63f:	eb f4                	jmp    635 <morecore+0x44>

00000641 <malloc>:

void*
malloc(uint nbytes)
{
 641:	f3 0f 1e fb          	endbr32 
 645:	55                   	push   %ebp
 646:	89 e5                	mov    %esp,%ebp
 648:	53                   	push   %ebx
 649:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 64c:	8b 45 08             	mov    0x8(%ebp),%eax
 64f:	8d 58 07             	lea    0x7(%eax),%ebx
 652:	c1 eb 03             	shr    $0x3,%ebx
 655:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 658:	8b 0d b0 09 00 00    	mov    0x9b0,%ecx
 65e:	85 c9                	test   %ecx,%ecx
 660:	74 04                	je     666 <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 662:	8b 01                	mov    (%ecx),%eax
 664:	eb 4b                	jmp    6b1 <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 666:	c7 05 b0 09 00 00 b4 	movl   $0x9b4,0x9b0
 66d:	09 00 00 
 670:	c7 05 b4 09 00 00 b4 	movl   $0x9b4,0x9b4
 677:	09 00 00 
    base.s.size = 0;
 67a:	c7 05 b8 09 00 00 00 	movl   $0x0,0x9b8
 681:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 684:	b9 b4 09 00 00       	mov    $0x9b4,%ecx
 689:	eb d7                	jmp    662 <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 68b:	74 1a                	je     6a7 <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 68d:	29 da                	sub    %ebx,%edx
 68f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 692:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 695:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 698:	89 0d b0 09 00 00    	mov    %ecx,0x9b0
      return (void*)(p + 1);
 69e:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6a1:	83 c4 04             	add    $0x4,%esp
 6a4:	5b                   	pop    %ebx
 6a5:	5d                   	pop    %ebp
 6a6:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6a7:	8b 10                	mov    (%eax),%edx
 6a9:	89 11                	mov    %edx,(%ecx)
 6ab:	eb eb                	jmp    698 <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6ad:	89 c1                	mov    %eax,%ecx
 6af:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 6b1:	8b 50 04             	mov    0x4(%eax),%edx
 6b4:	39 da                	cmp    %ebx,%edx
 6b6:	73 d3                	jae    68b <malloc+0x4a>
    if(p == freep)
 6b8:	39 05 b0 09 00 00    	cmp    %eax,0x9b0
 6be:	75 ed                	jne    6ad <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 6c0:	89 d8                	mov    %ebx,%eax
 6c2:	e8 2a ff ff ff       	call   5f1 <morecore>
 6c7:	85 c0                	test   %eax,%eax
 6c9:	75 e2                	jne    6ad <malloc+0x6c>
 6cb:	eb d4                	jmp    6a1 <malloc+0x60>
