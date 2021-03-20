
_schedtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// 		printf(2, "fork failed\n");
// 	}
// 	return child;
// }

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
  15:	81 ec 28 07 00 00    	sub    $0x728,%esp
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
    if (argc != 6) {
  1e:	83 39 06             	cmpl   $0x6,(%ecx)
  21:	74 14                	je     37 <main+0x37>
		printf(2, "Usage: schedtest sliceA sleepA sliceB sleepB sleepParent\n");
  23:	83 ec 08             	sub    $0x8,%esp
  26:	68 58 07 00 00       	push   $0x758
  2b:	6a 02                	push   $0x2
  2d:	e8 67 04 00 00       	call   499 <printf>
		exit();
  32:	e8 01 03 00 00       	call   338 <exit>
	}
    int sliceA = atoi(argv[1]);
  37:	83 ec 0c             	sub    $0xc,%esp
  3a:	ff 73 04             	pushl  0x4(%ebx)
  3d:	e8 8c 02 00 00       	call   2ce <atoi>
  42:	89 85 d4 f8 ff ff    	mov    %eax,-0x72c(%ebp)
    char *sleepA = argv[2];
  48:	8b 73 08             	mov    0x8(%ebx),%esi
    int sliceB = atoi(argv[3]);
  4b:	83 c4 04             	add    $0x4,%esp
  4e:	ff 73 0c             	pushl  0xc(%ebx)
  51:	e8 78 02 00 00       	call   2ce <atoi>
  56:	89 85 d0 f8 ff ff    	mov    %eax,-0x730(%ebp)
    char *sleepB = argv[4];
  5c:	8b 7b 10             	mov    0x10(%ebx),%edi
    int sleepParent = atoi(argv[5]);
  5f:	83 c4 04             	add    $0x4,%esp
  62:	ff 73 14             	pushl  0x14(%ebx)
  65:	e8 64 02 00 00       	call   2ce <atoi>
  6a:	89 85 cc f8 ff ff    	mov    %eax,-0x734(%ebp)
	struct pstat ps;

	// int childA = schedtestFork(sliceA, sleepA);
	// int childB = schedtestFork(sliceB, sleepB);

	int childA = fork2(sliceA);
  70:	83 c4 04             	add    $0x4,%esp
  73:	ff b5 d4 f8 ff ff    	pushl  -0x72c(%ebp)
  79:	e8 6a 03 00 00       	call   3e8 <fork2>
  7e:	89 c3                	mov    %eax,%ebx
	int childB = 0;
	if (childA == 0) {
  80:	83 c4 10             	add    $0x10,%esp
  83:	85 c0                	test   %eax,%eax
  85:	75 33                	jne    ba <main+0xba>
		char *args[] = {"loop", sleepA, 0};
  87:	c7 85 dc f8 ff ff 92 	movl   $0x792,-0x724(%ebp)
  8e:	07 00 00 
  91:	89 b5 e0 f8 ff ff    	mov    %esi,-0x720(%ebp)
  97:	c7 85 e4 f8 ff ff 00 	movl   $0x0,-0x71c(%ebp)
  9e:	00 00 00 
		exec(args[0], args);
  a1:	83 ec 08             	sub    $0x8,%esp
  a4:	8d 85 dc f8 ff ff    	lea    -0x724(%ebp),%eax
  aa:	50                   	push   %eax
  ab:	68 92 07 00 00       	push   $0x792
  b0:	e8 bb 02 00 00       	call   370 <exec>
		exit();
  b5:	e8 7e 02 00 00       	call   338 <exit>
	} else if ((childB = fork2(sliceB)) == 0) {
  ba:	83 ec 0c             	sub    $0xc,%esp
  bd:	ff b5 d0 f8 ff ff    	pushl  -0x730(%ebp)
  c3:	e8 20 03 00 00       	call   3e8 <fork2>
  c8:	89 c6                	mov    %eax,%esi
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	85 c0                	test   %eax,%eax
  cf:	75 33                	jne    104 <main+0x104>
		char *args[] = {"loop", sleepB, 0};
  d1:	c7 85 dc f8 ff ff 92 	movl   $0x792,-0x724(%ebp)
  d8:	07 00 00 
  db:	89 bd e0 f8 ff ff    	mov    %edi,-0x720(%ebp)
  e1:	c7 85 e4 f8 ff ff 00 	movl   $0x0,-0x71c(%ebp)
  e8:	00 00 00 
		exec(args[0], args);
  eb:	83 ec 08             	sub    $0x8,%esp
  ee:	8d 85 dc f8 ff ff    	lea    -0x724(%ebp),%eax
  f4:	50                   	push   %eax
  f5:	68 92 07 00 00       	push   $0x792
  fa:	e8 71 02 00 00       	call   370 <exec>
		exit();
  ff:	e8 34 02 00 00       	call   338 <exit>
	} else {
		wait();
 104:	e8 37 02 00 00       	call   340 <wait>
		sleep(sleepParent);
 109:	83 ec 0c             	sub    $0xc,%esp
 10c:	ff b5 cc f8 ff ff    	pushl  -0x734(%ebp)
 112:	e8 b1 02 00 00       	call   3c8 <sleep>
		int compticksA = 0;
		int compticksB = 0;
		if (getpinfo(&ps) == 0) {
 117:	8d 85 e8 f8 ff ff    	lea    -0x718(%ebp),%eax
 11d:	89 04 24             	mov    %eax,(%esp)
 120:	e8 cb 02 00 00       	call   3f0 <getpinfo>
 125:	83 c4 10             	add    $0x10,%esp
 128:	85 c0                	test   %eax,%eax
 12a:	75 4a                	jne    176 <main+0x176>
			for(int i = 0; i < NPROC; i++) {
 12c:	89 c2                	mov    %eax,%edx
		int compticksB = 0;
 12e:	89 c7                	mov    %eax,%edi
 130:	eb 0a                	jmp    13c <main+0x13c>
				if (childA == ps.pid[i]) {
						compticksA = ps.compticks[i];
 132:	8b 84 95 e8 fb ff ff 	mov    -0x418(%ebp,%edx,4),%eax
			for(int i = 0; i < NPROC; i++) {
 139:	83 c2 01             	add    $0x1,%edx
 13c:	83 fa 3f             	cmp    $0x3f,%edx
 13f:	7f 18                	jg     159 <main+0x159>
				if (childA == ps.pid[i]) {
 141:	8b 8c 95 e8 f9 ff ff 	mov    -0x618(%ebp,%edx,4),%ecx
 148:	39 d9                	cmp    %ebx,%ecx
 14a:	74 e6                	je     132 <main+0x132>
				} else if (childB == ps.pid[i]) {
 14c:	39 f1                	cmp    %esi,%ecx
 14e:	75 e9                	jne    139 <main+0x139>
					compticksB = ps.compticks[i];
 150:	8b bc 95 e8 fb ff ff 	mov    -0x418(%ebp,%edx,4),%edi
 157:	eb e0                	jmp    139 <main+0x139>
				}
			}
			printf(1, "%d %d\n", compticksA, compticksB);
 159:	57                   	push   %edi
 15a:	50                   	push   %eax
 15b:	68 97 07 00 00       	push   $0x797
 160:	6a 01                	push   $0x1
 162:	e8 32 03 00 00       	call   499 <printf>
			wait();
 167:	e8 d4 01 00 00       	call   340 <wait>
			wait();
 16c:	e8 cf 01 00 00       	call   340 <wait>
			exit();
 171:	e8 c2 01 00 00       	call   338 <exit>
	// 	}
	// 	printf(1, "%d %d\n", compticksA, compticksB);
	// } else {
	// 	printf(2, "Error: Could not access ptable correctly.\n");
	// }
	exit();
 176:	e8 bd 01 00 00       	call   338 <exit>

0000017b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 17b:	f3 0f 1e fb          	endbr32 
 17f:	55                   	push   %ebp
 180:	89 e5                	mov    %esp,%ebp
 182:	56                   	push   %esi
 183:	53                   	push   %ebx
 184:	8b 75 08             	mov    0x8(%ebp),%esi
 187:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 f0                	mov    %esi,%eax
 18c:	89 d1                	mov    %edx,%ecx
 18e:	83 c2 01             	add    $0x1,%edx
 191:	89 c3                	mov    %eax,%ebx
 193:	83 c0 01             	add    $0x1,%eax
 196:	0f b6 09             	movzbl (%ecx),%ecx
 199:	88 0b                	mov    %cl,(%ebx)
 19b:	84 c9                	test   %cl,%cl
 19d:	75 ed                	jne    18c <strcpy+0x11>
    ;
  return os;
}
 19f:	89 f0                	mov    %esi,%eax
 1a1:	5b                   	pop    %ebx
 1a2:	5e                   	pop    %esi
 1a3:	5d                   	pop    %ebp
 1a4:	c3                   	ret    

000001a5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a5:	f3 0f 1e fb          	endbr32 
 1a9:	55                   	push   %ebp
 1aa:	89 e5                	mov    %esp,%ebp
 1ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1af:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1b2:	0f b6 01             	movzbl (%ecx),%eax
 1b5:	84 c0                	test   %al,%al
 1b7:	74 0c                	je     1c5 <strcmp+0x20>
 1b9:	3a 02                	cmp    (%edx),%al
 1bb:	75 08                	jne    1c5 <strcmp+0x20>
    p++, q++;
 1bd:	83 c1 01             	add    $0x1,%ecx
 1c0:	83 c2 01             	add    $0x1,%edx
 1c3:	eb ed                	jmp    1b2 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 1c5:	0f b6 c0             	movzbl %al,%eax
 1c8:	0f b6 12             	movzbl (%edx),%edx
 1cb:	29 d0                	sub    %edx,%eax
}
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    

000001cf <strlen>:

uint
strlen(const char *s)
{
 1cf:	f3 0f 1e fb          	endbr32 
 1d3:	55                   	push   %ebp
 1d4:	89 e5                	mov    %esp,%ebp
 1d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1d9:	b8 00 00 00 00       	mov    $0x0,%eax
 1de:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 1e2:	74 05                	je     1e9 <strlen+0x1a>
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	eb f5                	jmp    1de <strlen+0xf>
    ;
  return n;
}
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    

000001eb <memset>:

void*
memset(void *dst, int c, uint n)
{
 1eb:	f3 0f 1e fb          	endbr32 
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	57                   	push   %edi
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f6:	89 d7                	mov    %edx,%edi
 1f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fe:	fc                   	cld    
 1ff:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 201:	89 d0                	mov    %edx,%eax
 203:	5f                   	pop    %edi
 204:	5d                   	pop    %ebp
 205:	c3                   	ret    

00000206 <strchr>:

char*
strchr(const char *s, char c)
{
 206:	f3 0f 1e fb          	endbr32 
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
 210:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 214:	0f b6 10             	movzbl (%eax),%edx
 217:	84 d2                	test   %dl,%dl
 219:	74 09                	je     224 <strchr+0x1e>
    if(*s == c)
 21b:	38 ca                	cmp    %cl,%dl
 21d:	74 0a                	je     229 <strchr+0x23>
  for(; *s; s++)
 21f:	83 c0 01             	add    $0x1,%eax
 222:	eb f0                	jmp    214 <strchr+0xe>
      return (char*)s;
  return 0;
 224:	b8 00 00 00 00       	mov    $0x0,%eax
}
 229:	5d                   	pop    %ebp
 22a:	c3                   	ret    

0000022b <gets>:

char*
gets(char *buf, int max)
{
 22b:	f3 0f 1e fb          	endbr32 
 22f:	55                   	push   %ebp
 230:	89 e5                	mov    %esp,%ebp
 232:	57                   	push   %edi
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
 235:	83 ec 1c             	sub    $0x1c,%esp
 238:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23b:	bb 00 00 00 00       	mov    $0x0,%ebx
 240:	89 de                	mov    %ebx,%esi
 242:	83 c3 01             	add    $0x1,%ebx
 245:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 248:	7d 2e                	jge    278 <gets+0x4d>
    cc = read(0, &c, 1);
 24a:	83 ec 04             	sub    $0x4,%esp
 24d:	6a 01                	push   $0x1
 24f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 252:	50                   	push   %eax
 253:	6a 00                	push   $0x0
 255:	e8 f6 00 00 00       	call   350 <read>
    if(cc < 1)
 25a:	83 c4 10             	add    $0x10,%esp
 25d:	85 c0                	test   %eax,%eax
 25f:	7e 17                	jle    278 <gets+0x4d>
      break;
    buf[i++] = c;
 261:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 265:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 268:	3c 0a                	cmp    $0xa,%al
 26a:	0f 94 c2             	sete   %dl
 26d:	3c 0d                	cmp    $0xd,%al
 26f:	0f 94 c0             	sete   %al
 272:	08 c2                	or     %al,%dl
 274:	74 ca                	je     240 <gets+0x15>
    buf[i++] = c;
 276:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 278:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 27c:	89 f8                	mov    %edi,%eax
 27e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 281:	5b                   	pop    %ebx
 282:	5e                   	pop    %esi
 283:	5f                   	pop    %edi
 284:	5d                   	pop    %ebp
 285:	c3                   	ret    

00000286 <stat>:

int
stat(const char *n, struct stat *st)
{
 286:	f3 0f 1e fb          	endbr32 
 28a:	55                   	push   %ebp
 28b:	89 e5                	mov    %esp,%ebp
 28d:	56                   	push   %esi
 28e:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28f:	83 ec 08             	sub    $0x8,%esp
 292:	6a 00                	push   $0x0
 294:	ff 75 08             	pushl  0x8(%ebp)
 297:	e8 dc 00 00 00       	call   378 <open>
  if(fd < 0)
 29c:	83 c4 10             	add    $0x10,%esp
 29f:	85 c0                	test   %eax,%eax
 2a1:	78 24                	js     2c7 <stat+0x41>
 2a3:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	ff 75 0c             	pushl  0xc(%ebp)
 2ab:	50                   	push   %eax
 2ac:	e8 df 00 00 00       	call   390 <fstat>
 2b1:	89 c6                	mov    %eax,%esi
  close(fd);
 2b3:	89 1c 24             	mov    %ebx,(%esp)
 2b6:	e8 a5 00 00 00       	call   360 <close>
  return r;
 2bb:	83 c4 10             	add    $0x10,%esp
}
 2be:	89 f0                	mov    %esi,%eax
 2c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c3:	5b                   	pop    %ebx
 2c4:	5e                   	pop    %esi
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
    return -1;
 2c7:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2cc:	eb f0                	jmp    2be <stat+0x38>

000002ce <atoi>:

int
atoi(const char *s)
{
 2ce:	f3 0f 1e fb          	endbr32 
 2d2:	55                   	push   %ebp
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	53                   	push   %ebx
 2d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 2d9:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 2de:	0f b6 01             	movzbl (%ecx),%eax
 2e1:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2e4:	80 fb 09             	cmp    $0x9,%bl
 2e7:	77 12                	ja     2fb <atoi+0x2d>
    n = n*10 + *s++ - '0';
 2e9:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 2ec:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 2ef:	83 c1 01             	add    $0x1,%ecx
 2f2:	0f be c0             	movsbl %al,%eax
 2f5:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
 2f9:	eb e3                	jmp    2de <atoi+0x10>
  return n;
}
 2fb:	89 d0                	mov    %edx,%eax
 2fd:	5b                   	pop    %ebx
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    

00000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	f3 0f 1e fb          	endbr32 
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	56                   	push   %esi
 308:	53                   	push   %ebx
 309:	8b 75 08             	mov    0x8(%ebp),%esi
 30c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 30f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 312:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 314:	8d 58 ff             	lea    -0x1(%eax),%ebx
 317:	85 c0                	test   %eax,%eax
 319:	7e 0f                	jle    32a <memmove+0x2a>
    *dst++ = *src++;
 31b:	0f b6 01             	movzbl (%ecx),%eax
 31e:	88 02                	mov    %al,(%edx)
 320:	8d 49 01             	lea    0x1(%ecx),%ecx
 323:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 326:	89 d8                	mov    %ebx,%eax
 328:	eb ea                	jmp    314 <memmove+0x14>
  return vdst;
}
 32a:	89 f0                	mov    %esi,%eax
 32c:	5b                   	pop    %ebx
 32d:	5e                   	pop    %esi
 32e:	5d                   	pop    %ebp
 32f:	c3                   	ret    

00000330 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 330:	b8 01 00 00 00       	mov    $0x1,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <exit>:
SYSCALL(exit)
 338:	b8 02 00 00 00       	mov    $0x2,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <wait>:
SYSCALL(wait)
 340:	b8 03 00 00 00       	mov    $0x3,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <pipe>:
SYSCALL(pipe)
 348:	b8 04 00 00 00       	mov    $0x4,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <read>:
SYSCALL(read)
 350:	b8 05 00 00 00       	mov    $0x5,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <write>:
SYSCALL(write)
 358:	b8 10 00 00 00       	mov    $0x10,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <close>:
SYSCALL(close)
 360:	b8 15 00 00 00       	mov    $0x15,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <kill>:
SYSCALL(kill)
 368:	b8 06 00 00 00       	mov    $0x6,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <exec>:
SYSCALL(exec)
 370:	b8 07 00 00 00       	mov    $0x7,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <open>:
SYSCALL(open)
 378:	b8 0f 00 00 00       	mov    $0xf,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <mknod>:
SYSCALL(mknod)
 380:	b8 11 00 00 00       	mov    $0x11,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <unlink>:
SYSCALL(unlink)
 388:	b8 12 00 00 00       	mov    $0x12,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <fstat>:
SYSCALL(fstat)
 390:	b8 08 00 00 00       	mov    $0x8,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <link>:
SYSCALL(link)
 398:	b8 13 00 00 00       	mov    $0x13,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <mkdir>:
SYSCALL(mkdir)
 3a0:	b8 14 00 00 00       	mov    $0x14,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <chdir>:
SYSCALL(chdir)
 3a8:	b8 09 00 00 00       	mov    $0x9,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <dup>:
SYSCALL(dup)
 3b0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <getpid>:
SYSCALL(getpid)
 3b8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <sbrk>:
SYSCALL(sbrk)
 3c0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <sleep>:
SYSCALL(sleep)
 3c8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <uptime>:
SYSCALL(uptime)
 3d0:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <setslice>:
SYSCALL(setslice);
 3d8:	b8 16 00 00 00       	mov    $0x16,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <getslice>:
SYSCALL(getslice);
 3e0:	b8 17 00 00 00       	mov    $0x17,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <fork2>:
SYSCALL(fork2);
 3e8:	b8 18 00 00 00       	mov    $0x18,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <getpinfo>:
SYSCALL(getpinfo);
 3f0:	b8 19 00 00 00       	mov    $0x19,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f8:	55                   	push   %ebp
 3f9:	89 e5                	mov    %esp,%ebp
 3fb:	83 ec 1c             	sub    $0x1c,%esp
 3fe:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 401:	6a 01                	push   $0x1
 403:	8d 55 f4             	lea    -0xc(%ebp),%edx
 406:	52                   	push   %edx
 407:	50                   	push   %eax
 408:	e8 4b ff ff ff       	call   358 <write>
}
 40d:	83 c4 10             	add    $0x10,%esp
 410:	c9                   	leave  
 411:	c3                   	ret    

00000412 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 412:	55                   	push   %ebp
 413:	89 e5                	mov    %esp,%ebp
 415:	57                   	push   %edi
 416:	56                   	push   %esi
 417:	53                   	push   %ebx
 418:	83 ec 2c             	sub    $0x2c,%esp
 41b:	89 45 d0             	mov    %eax,-0x30(%ebp)
 41e:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 420:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 424:	0f 95 c2             	setne  %dl
 427:	89 f0                	mov    %esi,%eax
 429:	c1 e8 1f             	shr    $0x1f,%eax
 42c:	84 c2                	test   %al,%dl
 42e:	74 42                	je     472 <printint+0x60>
    neg = 1;
    x = -xx;
 430:	f7 de                	neg    %esi
    neg = 1;
 432:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 439:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 43e:	89 f0                	mov    %esi,%eax
 440:	ba 00 00 00 00       	mov    $0x0,%edx
 445:	f7 f1                	div    %ecx
 447:	89 df                	mov    %ebx,%edi
 449:	83 c3 01             	add    $0x1,%ebx
 44c:	0f b6 92 a8 07 00 00 	movzbl 0x7a8(%edx),%edx
 453:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 457:	89 f2                	mov    %esi,%edx
 459:	89 c6                	mov    %eax,%esi
 45b:	39 d1                	cmp    %edx,%ecx
 45d:	76 df                	jbe    43e <printint+0x2c>
  if(neg)
 45f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 463:	74 2f                	je     494 <printint+0x82>
    buf[i++] = '-';
 465:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 46a:	8d 5f 02             	lea    0x2(%edi),%ebx
 46d:	8b 75 d0             	mov    -0x30(%ebp),%esi
 470:	eb 15                	jmp    487 <printint+0x75>
  neg = 0;
 472:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 479:	eb be                	jmp    439 <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 47b:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 480:	89 f0                	mov    %esi,%eax
 482:	e8 71 ff ff ff       	call   3f8 <putc>
  while(--i >= 0)
 487:	83 eb 01             	sub    $0x1,%ebx
 48a:	79 ef                	jns    47b <printint+0x69>
}
 48c:	83 c4 2c             	add    $0x2c,%esp
 48f:	5b                   	pop    %ebx
 490:	5e                   	pop    %esi
 491:	5f                   	pop    %edi
 492:	5d                   	pop    %ebp
 493:	c3                   	ret    
 494:	8b 75 d0             	mov    -0x30(%ebp),%esi
 497:	eb ee                	jmp    487 <printint+0x75>

00000499 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 499:	f3 0f 1e fb          	endbr32 
 49d:	55                   	push   %ebp
 49e:	89 e5                	mov    %esp,%ebp
 4a0:	57                   	push   %edi
 4a1:	56                   	push   %esi
 4a2:	53                   	push   %ebx
 4a3:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4a6:	8d 45 10             	lea    0x10(%ebp),%eax
 4a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 4ac:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 4b1:	bb 00 00 00 00       	mov    $0x0,%ebx
 4b6:	eb 14                	jmp    4cc <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4b8:	89 fa                	mov    %edi,%edx
 4ba:	8b 45 08             	mov    0x8(%ebp),%eax
 4bd:	e8 36 ff ff ff       	call   3f8 <putc>
 4c2:	eb 05                	jmp    4c9 <printf+0x30>
      }
    } else if(state == '%'){
 4c4:	83 fe 25             	cmp    $0x25,%esi
 4c7:	74 25                	je     4ee <printf+0x55>
  for(i = 0; fmt[i]; i++){
 4c9:	83 c3 01             	add    $0x1,%ebx
 4cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cf:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 4d3:	84 c0                	test   %al,%al
 4d5:	0f 84 23 01 00 00    	je     5fe <printf+0x165>
    c = fmt[i] & 0xff;
 4db:	0f be f8             	movsbl %al,%edi
 4de:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 4e1:	85 f6                	test   %esi,%esi
 4e3:	75 df                	jne    4c4 <printf+0x2b>
      if(c == '%'){
 4e5:	83 f8 25             	cmp    $0x25,%eax
 4e8:	75 ce                	jne    4b8 <printf+0x1f>
        state = '%';
 4ea:	89 c6                	mov    %eax,%esi
 4ec:	eb db                	jmp    4c9 <printf+0x30>
      if(c == 'd'){
 4ee:	83 f8 64             	cmp    $0x64,%eax
 4f1:	74 49                	je     53c <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4f3:	83 f8 78             	cmp    $0x78,%eax
 4f6:	0f 94 c1             	sete   %cl
 4f9:	83 f8 70             	cmp    $0x70,%eax
 4fc:	0f 94 c2             	sete   %dl
 4ff:	08 d1                	or     %dl,%cl
 501:	75 63                	jne    566 <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 503:	83 f8 73             	cmp    $0x73,%eax
 506:	0f 84 84 00 00 00    	je     590 <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 50c:	83 f8 63             	cmp    $0x63,%eax
 50f:	0f 84 b7 00 00 00    	je     5cc <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 515:	83 f8 25             	cmp    $0x25,%eax
 518:	0f 84 cc 00 00 00    	je     5ea <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 51e:	ba 25 00 00 00       	mov    $0x25,%edx
 523:	8b 45 08             	mov    0x8(%ebp),%eax
 526:	e8 cd fe ff ff       	call   3f8 <putc>
        putc(fd, c);
 52b:	89 fa                	mov    %edi,%edx
 52d:	8b 45 08             	mov    0x8(%ebp),%eax
 530:	e8 c3 fe ff ff       	call   3f8 <putc>
      }
      state = 0;
 535:	be 00 00 00 00       	mov    $0x0,%esi
 53a:	eb 8d                	jmp    4c9 <printf+0x30>
        printint(fd, *ap, 10, 1);
 53c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 53f:	8b 17                	mov    (%edi),%edx
 541:	83 ec 0c             	sub    $0xc,%esp
 544:	6a 01                	push   $0x1
 546:	b9 0a 00 00 00       	mov    $0xa,%ecx
 54b:	8b 45 08             	mov    0x8(%ebp),%eax
 54e:	e8 bf fe ff ff       	call   412 <printint>
        ap++;
 553:	83 c7 04             	add    $0x4,%edi
 556:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 559:	83 c4 10             	add    $0x10,%esp
      state = 0;
 55c:	be 00 00 00 00       	mov    $0x0,%esi
 561:	e9 63 ff ff ff       	jmp    4c9 <printf+0x30>
        printint(fd, *ap, 16, 0);
 566:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 569:	8b 17                	mov    (%edi),%edx
 56b:	83 ec 0c             	sub    $0xc,%esp
 56e:	6a 00                	push   $0x0
 570:	b9 10 00 00 00       	mov    $0x10,%ecx
 575:	8b 45 08             	mov    0x8(%ebp),%eax
 578:	e8 95 fe ff ff       	call   412 <printint>
        ap++;
 57d:	83 c7 04             	add    $0x4,%edi
 580:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 583:	83 c4 10             	add    $0x10,%esp
      state = 0;
 586:	be 00 00 00 00       	mov    $0x0,%esi
 58b:	e9 39 ff ff ff       	jmp    4c9 <printf+0x30>
        s = (char*)*ap;
 590:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 593:	8b 30                	mov    (%eax),%esi
        ap++;
 595:	83 c0 04             	add    $0x4,%eax
 598:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 59b:	85 f6                	test   %esi,%esi
 59d:	75 28                	jne    5c7 <printf+0x12e>
          s = "(null)";
 59f:	be 9e 07 00 00       	mov    $0x79e,%esi
 5a4:	8b 7d 08             	mov    0x8(%ebp),%edi
 5a7:	eb 0d                	jmp    5b6 <printf+0x11d>
          putc(fd, *s);
 5a9:	0f be d2             	movsbl %dl,%edx
 5ac:	89 f8                	mov    %edi,%eax
 5ae:	e8 45 fe ff ff       	call   3f8 <putc>
          s++;
 5b3:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 5b6:	0f b6 16             	movzbl (%esi),%edx
 5b9:	84 d2                	test   %dl,%dl
 5bb:	75 ec                	jne    5a9 <printf+0x110>
      state = 0;
 5bd:	be 00 00 00 00       	mov    $0x0,%esi
 5c2:	e9 02 ff ff ff       	jmp    4c9 <printf+0x30>
 5c7:	8b 7d 08             	mov    0x8(%ebp),%edi
 5ca:	eb ea                	jmp    5b6 <printf+0x11d>
        putc(fd, *ap);
 5cc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5cf:	0f be 17             	movsbl (%edi),%edx
 5d2:	8b 45 08             	mov    0x8(%ebp),%eax
 5d5:	e8 1e fe ff ff       	call   3f8 <putc>
        ap++;
 5da:	83 c7 04             	add    $0x4,%edi
 5dd:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 5e0:	be 00 00 00 00       	mov    $0x0,%esi
 5e5:	e9 df fe ff ff       	jmp    4c9 <printf+0x30>
        putc(fd, c);
 5ea:	89 fa                	mov    %edi,%edx
 5ec:	8b 45 08             	mov    0x8(%ebp),%eax
 5ef:	e8 04 fe ff ff       	call   3f8 <putc>
      state = 0;
 5f4:	be 00 00 00 00       	mov    $0x0,%esi
 5f9:	e9 cb fe ff ff       	jmp    4c9 <printf+0x30>
    }
  }
}
 5fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
 601:	5b                   	pop    %ebx
 602:	5e                   	pop    %esi
 603:	5f                   	pop    %edi
 604:	5d                   	pop    %ebp
 605:	c3                   	ret    

00000606 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 606:	f3 0f 1e fb          	endbr32 
 60a:	55                   	push   %ebp
 60b:	89 e5                	mov    %esp,%ebp
 60d:	57                   	push   %edi
 60e:	56                   	push   %esi
 60f:	53                   	push   %ebx
 610:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 613:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 616:	a1 54 0a 00 00       	mov    0xa54,%eax
 61b:	eb 02                	jmp    61f <free+0x19>
 61d:	89 d0                	mov    %edx,%eax
 61f:	39 c8                	cmp    %ecx,%eax
 621:	73 04                	jae    627 <free+0x21>
 623:	39 08                	cmp    %ecx,(%eax)
 625:	77 12                	ja     639 <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 627:	8b 10                	mov    (%eax),%edx
 629:	39 c2                	cmp    %eax,%edx
 62b:	77 f0                	ja     61d <free+0x17>
 62d:	39 c8                	cmp    %ecx,%eax
 62f:	72 08                	jb     639 <free+0x33>
 631:	39 ca                	cmp    %ecx,%edx
 633:	77 04                	ja     639 <free+0x33>
 635:	89 d0                	mov    %edx,%eax
 637:	eb e6                	jmp    61f <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 639:	8b 73 fc             	mov    -0x4(%ebx),%esi
 63c:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 63f:	8b 10                	mov    (%eax),%edx
 641:	39 d7                	cmp    %edx,%edi
 643:	74 19                	je     65e <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 645:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 648:	8b 50 04             	mov    0x4(%eax),%edx
 64b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 64e:	39 ce                	cmp    %ecx,%esi
 650:	74 1b                	je     66d <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 652:	89 08                	mov    %ecx,(%eax)
  freep = p;
 654:	a3 54 0a 00 00       	mov    %eax,0xa54
}
 659:	5b                   	pop    %ebx
 65a:	5e                   	pop    %esi
 65b:	5f                   	pop    %edi
 65c:	5d                   	pop    %ebp
 65d:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 65e:	03 72 04             	add    0x4(%edx),%esi
 661:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 664:	8b 10                	mov    (%eax),%edx
 666:	8b 12                	mov    (%edx),%edx
 668:	89 53 f8             	mov    %edx,-0x8(%ebx)
 66b:	eb db                	jmp    648 <free+0x42>
    p->s.size += bp->s.size;
 66d:	03 53 fc             	add    -0x4(%ebx),%edx
 670:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 673:	8b 53 f8             	mov    -0x8(%ebx),%edx
 676:	89 10                	mov    %edx,(%eax)
 678:	eb da                	jmp    654 <free+0x4e>

0000067a <morecore>:

static Header*
morecore(uint nu)
{
 67a:	55                   	push   %ebp
 67b:	89 e5                	mov    %esp,%ebp
 67d:	53                   	push   %ebx
 67e:	83 ec 04             	sub    $0x4,%esp
 681:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 683:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 688:	77 05                	ja     68f <morecore+0x15>
    nu = 4096;
 68a:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 68f:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 696:	83 ec 0c             	sub    $0xc,%esp
 699:	50                   	push   %eax
 69a:	e8 21 fd ff ff       	call   3c0 <sbrk>
  if(p == (char*)-1)
 69f:	83 c4 10             	add    $0x10,%esp
 6a2:	83 f8 ff             	cmp    $0xffffffff,%eax
 6a5:	74 1c                	je     6c3 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6a7:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6aa:	83 c0 08             	add    $0x8,%eax
 6ad:	83 ec 0c             	sub    $0xc,%esp
 6b0:	50                   	push   %eax
 6b1:	e8 50 ff ff ff       	call   606 <free>
  return freep;
 6b6:	a1 54 0a 00 00       	mov    0xa54,%eax
 6bb:	83 c4 10             	add    $0x10,%esp
}
 6be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6c1:	c9                   	leave  
 6c2:	c3                   	ret    
    return 0;
 6c3:	b8 00 00 00 00       	mov    $0x0,%eax
 6c8:	eb f4                	jmp    6be <morecore+0x44>

000006ca <malloc>:

void*
malloc(uint nbytes)
{
 6ca:	f3 0f 1e fb          	endbr32 
 6ce:	55                   	push   %ebp
 6cf:	89 e5                	mov    %esp,%ebp
 6d1:	53                   	push   %ebx
 6d2:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d5:	8b 45 08             	mov    0x8(%ebp),%eax
 6d8:	8d 58 07             	lea    0x7(%eax),%ebx
 6db:	c1 eb 03             	shr    $0x3,%ebx
 6de:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 6e1:	8b 0d 54 0a 00 00    	mov    0xa54,%ecx
 6e7:	85 c9                	test   %ecx,%ecx
 6e9:	74 04                	je     6ef <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6eb:	8b 01                	mov    (%ecx),%eax
 6ed:	eb 4b                	jmp    73a <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 6ef:	c7 05 54 0a 00 00 58 	movl   $0xa58,0xa54
 6f6:	0a 00 00 
 6f9:	c7 05 58 0a 00 00 58 	movl   $0xa58,0xa58
 700:	0a 00 00 
    base.s.size = 0;
 703:	c7 05 5c 0a 00 00 00 	movl   $0x0,0xa5c
 70a:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 70d:	b9 58 0a 00 00       	mov    $0xa58,%ecx
 712:	eb d7                	jmp    6eb <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 714:	74 1a                	je     730 <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 716:	29 da                	sub    %ebx,%edx
 718:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 71b:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 71e:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 721:	89 0d 54 0a 00 00    	mov    %ecx,0xa54
      return (void*)(p + 1);
 727:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 72a:	83 c4 04             	add    $0x4,%esp
 72d:	5b                   	pop    %ebx
 72e:	5d                   	pop    %ebp
 72f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 730:	8b 10                	mov    (%eax),%edx
 732:	89 11                	mov    %edx,(%ecx)
 734:	eb eb                	jmp    721 <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 736:	89 c1                	mov    %eax,%ecx
 738:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 73a:	8b 50 04             	mov    0x4(%eax),%edx
 73d:	39 da                	cmp    %ebx,%edx
 73f:	73 d3                	jae    714 <malloc+0x4a>
    if(p == freep)
 741:	39 05 54 0a 00 00    	cmp    %eax,0xa54
 747:	75 ed                	jne    736 <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 749:	89 d8                	mov    %ebx,%eax
 74b:	e8 2a ff ff ff       	call   67a <morecore>
 750:	85 c0                	test   %eax,%eax
 752:	75 e2                	jne    736 <malloc+0x6c>
 754:	eb d4                	jmp    72a <malloc+0x60>
