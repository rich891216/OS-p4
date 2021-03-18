
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	83 ec 0c             	sub    $0xc,%esp
   f:	53                   	push   %ebx
  10:	e8 2f 03 00 00       	call   344 <strlen>
  15:	01 d8                	add    %ebx,%eax
  17:	83 c4 10             	add    $0x10,%esp
  1a:	39 d8                	cmp    %ebx,%eax
  1c:	72 0a                	jb     28 <fmtname+0x28>
  1e:	80 38 2f             	cmpb   $0x2f,(%eax)
  21:	74 05                	je     28 <fmtname+0x28>
  23:	83 e8 01             	sub    $0x1,%eax
  26:	eb f2                	jmp    1a <fmtname+0x1a>
    ;
  p++;
  28:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  2b:	83 ec 0c             	sub    $0xc,%esp
  2e:	53                   	push   %ebx
  2f:	e8 10 03 00 00       	call   344 <strlen>
  34:	83 c4 10             	add    $0x10,%esp
  37:	83 f8 0d             	cmp    $0xd,%eax
  3a:	76 09                	jbe    45 <fmtname+0x45>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  3c:	89 d8                	mov    %ebx,%eax
  3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  41:	5b                   	pop    %ebx
  42:	5e                   	pop    %esi
  43:	5d                   	pop    %ebp
  44:	c3                   	ret    
  memmove(buf, p, strlen(p));
  45:	83 ec 0c             	sub    $0xc,%esp
  48:	53                   	push   %ebx
  49:	e8 f6 02 00 00       	call   344 <strlen>
  4e:	83 c4 0c             	add    $0xc,%esp
  51:	50                   	push   %eax
  52:	53                   	push   %ebx
  53:	68 28 0c 00 00       	push   $0xc28
  58:	e8 18 04 00 00       	call   475 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  5d:	89 1c 24             	mov    %ebx,(%esp)
  60:	e8 df 02 00 00       	call   344 <strlen>
  65:	89 c6                	mov    %eax,%esi
  67:	89 1c 24             	mov    %ebx,(%esp)
  6a:	e8 d5 02 00 00       	call   344 <strlen>
  6f:	83 c4 0c             	add    $0xc,%esp
  72:	ba 0e 00 00 00       	mov    $0xe,%edx
  77:	29 f2                	sub    %esi,%edx
  79:	52                   	push   %edx
  7a:	6a 20                	push   $0x20
  7c:	05 28 0c 00 00       	add    $0xc28,%eax
  81:	50                   	push   %eax
  82:	e8 d9 02 00 00       	call   360 <memset>
  return buf;
  87:	83 c4 10             	add    $0x10,%esp
  8a:	bb 28 0c 00 00       	mov    $0xc28,%ebx
  8f:	eb ab                	jmp    3c <fmtname+0x3c>

00000091 <ls>:

void
ls(char *path)
{
  91:	f3 0f 1e fb          	endbr32 
  95:	55                   	push   %ebp
  96:	89 e5                	mov    %esp,%ebp
  98:	57                   	push   %edi
  99:	56                   	push   %esi
  9a:	53                   	push   %ebx
  9b:	81 ec 54 02 00 00    	sub    $0x254,%esp
  a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  a4:	6a 00                	push   $0x0
  a6:	53                   	push   %ebx
  a7:	e8 41 04 00 00       	call   4ed <open>
  ac:	83 c4 10             	add    $0x10,%esp
  af:	85 c0                	test   %eax,%eax
  b1:	0f 88 8c 00 00 00    	js     143 <ls+0xb2>
  b7:	89 c7                	mov    %eax,%edi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
  c2:	50                   	push   %eax
  c3:	57                   	push   %edi
  c4:	e8 3c 04 00 00       	call   505 <fstat>
  c9:	83 c4 10             	add    $0x10,%esp
  cc:	85 c0                	test   %eax,%eax
  ce:	0f 88 84 00 00 00    	js     158 <ls+0xc7>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  d4:	0f b7 85 c4 fd ff ff 	movzwl -0x23c(%ebp),%eax
  db:	0f bf f0             	movswl %ax,%esi
  de:	66 83 f8 01          	cmp    $0x1,%ax
  e2:	0f 84 8d 00 00 00    	je     175 <ls+0xe4>
  e8:	66 83 f8 02          	cmp    $0x2,%ax
  ec:	75 41                	jne    12f <ls+0x9e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
  ee:	8b 85 d4 fd ff ff    	mov    -0x22c(%ebp),%eax
  f4:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
  fa:	8b 95 cc fd ff ff    	mov    -0x234(%ebp),%edx
 100:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 106:	83 ec 0c             	sub    $0xc,%esp
 109:	53                   	push   %ebx
 10a:	e8 f1 fe ff ff       	call   0 <fmtname>
 10f:	83 c4 08             	add    $0x8,%esp
 112:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 118:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 11e:	56                   	push   %esi
 11f:	50                   	push   %eax
 120:	68 f4 08 00 00       	push   $0x8f4
 125:	6a 01                	push   $0x1
 127:	e8 e2 04 00 00       	call   60e <printf>
    break;
 12c:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 12f:	83 ec 0c             	sub    $0xc,%esp
 132:	57                   	push   %edi
 133:	e8 9d 03 00 00       	call   4d5 <close>
 138:	83 c4 10             	add    $0x10,%esp
}
 13b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13e:	5b                   	pop    %ebx
 13f:	5e                   	pop    %esi
 140:	5f                   	pop    %edi
 141:	5d                   	pop    %ebp
 142:	c3                   	ret    
    printf(2, "ls: cannot open %s\n", path);
 143:	83 ec 04             	sub    $0x4,%esp
 146:	53                   	push   %ebx
 147:	68 cc 08 00 00       	push   $0x8cc
 14c:	6a 02                	push   $0x2
 14e:	e8 bb 04 00 00       	call   60e <printf>
    return;
 153:	83 c4 10             	add    $0x10,%esp
 156:	eb e3                	jmp    13b <ls+0xaa>
    printf(2, "ls: cannot stat %s\n", path);
 158:	83 ec 04             	sub    $0x4,%esp
 15b:	53                   	push   %ebx
 15c:	68 e0 08 00 00       	push   $0x8e0
 161:	6a 02                	push   $0x2
 163:	e8 a6 04 00 00       	call   60e <printf>
    close(fd);
 168:	89 3c 24             	mov    %edi,(%esp)
 16b:	e8 65 03 00 00       	call   4d5 <close>
    return;
 170:	83 c4 10             	add    $0x10,%esp
 173:	eb c6                	jmp    13b <ls+0xaa>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 175:	83 ec 0c             	sub    $0xc,%esp
 178:	53                   	push   %ebx
 179:	e8 c6 01 00 00       	call   344 <strlen>
 17e:	83 c0 10             	add    $0x10,%eax
 181:	83 c4 10             	add    $0x10,%esp
 184:	3d 00 02 00 00       	cmp    $0x200,%eax
 189:	76 14                	jbe    19f <ls+0x10e>
      printf(1, "ls: path too long\n");
 18b:	83 ec 08             	sub    $0x8,%esp
 18e:	68 01 09 00 00       	push   $0x901
 193:	6a 01                	push   $0x1
 195:	e8 74 04 00 00       	call   60e <printf>
      break;
 19a:	83 c4 10             	add    $0x10,%esp
 19d:	eb 90                	jmp    12f <ls+0x9e>
    strcpy(buf, path);
 19f:	83 ec 08             	sub    $0x8,%esp
 1a2:	53                   	push   %ebx
 1a3:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
 1a9:	56                   	push   %esi
 1aa:	e8 41 01 00 00       	call   2f0 <strcpy>
    p = buf+strlen(buf);
 1af:	89 34 24             	mov    %esi,(%esp)
 1b2:	e8 8d 01 00 00       	call   344 <strlen>
 1b7:	01 c6                	add    %eax,%esi
    *p++ = '/';
 1b9:	8d 46 01             	lea    0x1(%esi),%eax
 1bc:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 1c2:	c6 06 2f             	movb   $0x2f,(%esi)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1c5:	83 c4 10             	add    $0x10,%esp
 1c8:	eb 19                	jmp    1e3 <ls+0x152>
        printf(1, "ls: cannot stat %s\n", buf);
 1ca:	83 ec 04             	sub    $0x4,%esp
 1cd:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1d3:	50                   	push   %eax
 1d4:	68 e0 08 00 00       	push   $0x8e0
 1d9:	6a 01                	push   $0x1
 1db:	e8 2e 04 00 00       	call   60e <printf>
        continue;
 1e0:	83 c4 10             	add    $0x10,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e3:	83 ec 04             	sub    $0x4,%esp
 1e6:	6a 10                	push   $0x10
 1e8:	8d 85 d8 fd ff ff    	lea    -0x228(%ebp),%eax
 1ee:	50                   	push   %eax
 1ef:	57                   	push   %edi
 1f0:	e8 d0 02 00 00       	call   4c5 <read>
 1f5:	83 c4 10             	add    $0x10,%esp
 1f8:	83 f8 10             	cmp    $0x10,%eax
 1fb:	0f 85 2e ff ff ff    	jne    12f <ls+0x9e>
      if(de.inum == 0)
 201:	66 83 bd d8 fd ff ff 	cmpw   $0x0,-0x228(%ebp)
 208:	00 
 209:	74 d8                	je     1e3 <ls+0x152>
      memmove(p, de.name, DIRSIZ);
 20b:	83 ec 04             	sub    $0x4,%esp
 20e:	6a 0e                	push   $0xe
 210:	8d 85 da fd ff ff    	lea    -0x226(%ebp),%eax
 216:	50                   	push   %eax
 217:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 21d:	e8 53 02 00 00       	call   475 <memmove>
      p[DIRSIZ] = 0;
 222:	c6 46 0f 00          	movb   $0x0,0xf(%esi)
      if(stat(buf, &st) < 0){
 226:	83 c4 08             	add    $0x8,%esp
 229:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 22f:	50                   	push   %eax
 230:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 236:	50                   	push   %eax
 237:	e8 bf 01 00 00       	call   3fb <stat>
 23c:	83 c4 10             	add    $0x10,%esp
 23f:	85 c0                	test   %eax,%eax
 241:	78 87                	js     1ca <ls+0x139>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 243:	8b 9d d4 fd ff ff    	mov    -0x22c(%ebp),%ebx
 249:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
 24f:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 255:	0f b7 8d c4 fd ff ff 	movzwl -0x23c(%ebp),%ecx
 25c:	66 89 8d b0 fd ff ff 	mov    %cx,-0x250(%ebp)
 263:	83 ec 0c             	sub    $0xc,%esp
 266:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 26c:	50                   	push   %eax
 26d:	e8 8e fd ff ff       	call   0 <fmtname>
 272:	89 c2                	mov    %eax,%edx
 274:	83 c4 08             	add    $0x8,%esp
 277:	53                   	push   %ebx
 278:	ff b5 b4 fd ff ff    	pushl  -0x24c(%ebp)
 27e:	0f bf 85 b0 fd ff ff 	movswl -0x250(%ebp),%eax
 285:	50                   	push   %eax
 286:	52                   	push   %edx
 287:	68 f4 08 00 00       	push   $0x8f4
 28c:	6a 01                	push   $0x1
 28e:	e8 7b 03 00 00       	call   60e <printf>
 293:	83 c4 20             	add    $0x20,%esp
 296:	e9 48 ff ff ff       	jmp    1e3 <ls+0x152>

0000029b <main>:

int
main(int argc, char *argv[])
{
 29b:	f3 0f 1e fb          	endbr32 
 29f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2a3:	83 e4 f0             	and    $0xfffffff0,%esp
 2a6:	ff 71 fc             	pushl  -0x4(%ecx)
 2a9:	55                   	push   %ebp
 2aa:	89 e5                	mov    %esp,%ebp
 2ac:	57                   	push   %edi
 2ad:	56                   	push   %esi
 2ae:	53                   	push   %ebx
 2af:	51                   	push   %ecx
 2b0:	83 ec 08             	sub    $0x8,%esp
 2b3:	8b 31                	mov    (%ecx),%esi
 2b5:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
 2b8:	83 fe 01             	cmp    $0x1,%esi
 2bb:	7e 07                	jle    2c4 <main+0x29>
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 2bd:	bb 01 00 00 00       	mov    $0x1,%ebx
 2c2:	eb 23                	jmp    2e7 <main+0x4c>
    ls(".");
 2c4:	83 ec 0c             	sub    $0xc,%esp
 2c7:	68 14 09 00 00       	push   $0x914
 2cc:	e8 c0 fd ff ff       	call   91 <ls>
    exit();
 2d1:	e8 d7 01 00 00       	call   4ad <exit>
    ls(argv[i]);
 2d6:	83 ec 0c             	sub    $0xc,%esp
 2d9:	ff 34 9f             	pushl  (%edi,%ebx,4)
 2dc:	e8 b0 fd ff ff       	call   91 <ls>
  for(i=1; i<argc; i++)
 2e1:	83 c3 01             	add    $0x1,%ebx
 2e4:	83 c4 10             	add    $0x10,%esp
 2e7:	39 f3                	cmp    %esi,%ebx
 2e9:	7c eb                	jl     2d6 <main+0x3b>
  exit();
 2eb:	e8 bd 01 00 00       	call   4ad <exit>

000002f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2f0:	f3 0f 1e fb          	endbr32 
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	56                   	push   %esi
 2f8:	53                   	push   %ebx
 2f9:	8b 75 08             	mov    0x8(%ebp),%esi
 2fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ff:	89 f0                	mov    %esi,%eax
 301:	89 d1                	mov    %edx,%ecx
 303:	83 c2 01             	add    $0x1,%edx
 306:	89 c3                	mov    %eax,%ebx
 308:	83 c0 01             	add    $0x1,%eax
 30b:	0f b6 09             	movzbl (%ecx),%ecx
 30e:	88 0b                	mov    %cl,(%ebx)
 310:	84 c9                	test   %cl,%cl
 312:	75 ed                	jne    301 <strcpy+0x11>
    ;
  return os;
}
 314:	89 f0                	mov    %esi,%eax
 316:	5b                   	pop    %ebx
 317:	5e                   	pop    %esi
 318:	5d                   	pop    %ebp
 319:	c3                   	ret    

0000031a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 31a:	f3 0f 1e fb          	endbr32 
 31e:	55                   	push   %ebp
 31f:	89 e5                	mov    %esp,%ebp
 321:	8b 4d 08             	mov    0x8(%ebp),%ecx
 324:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 327:	0f b6 01             	movzbl (%ecx),%eax
 32a:	84 c0                	test   %al,%al
 32c:	74 0c                	je     33a <strcmp+0x20>
 32e:	3a 02                	cmp    (%edx),%al
 330:	75 08                	jne    33a <strcmp+0x20>
    p++, q++;
 332:	83 c1 01             	add    $0x1,%ecx
 335:	83 c2 01             	add    $0x1,%edx
 338:	eb ed                	jmp    327 <strcmp+0xd>
  return (uchar)*p - (uchar)*q;
 33a:	0f b6 c0             	movzbl %al,%eax
 33d:	0f b6 12             	movzbl (%edx),%edx
 340:	29 d0                	sub    %edx,%eax
}
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    

00000344 <strlen>:

uint
strlen(const char *s)
{
 344:	f3 0f 1e fb          	endbr32 
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 34e:	b8 00 00 00 00       	mov    $0x0,%eax
 353:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
 357:	74 05                	je     35e <strlen+0x1a>
 359:	83 c0 01             	add    $0x1,%eax
 35c:	eb f5                	jmp    353 <strlen+0xf>
    ;
  return n;
}
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    

00000360 <memset>:

void*
memset(void *dst, int c, uint n)
{
 360:	f3 0f 1e fb          	endbr32 
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	57                   	push   %edi
 368:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 36b:	89 d7                	mov    %edx,%edi
 36d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 370:	8b 45 0c             	mov    0xc(%ebp),%eax
 373:	fc                   	cld    
 374:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 376:	89 d0                	mov    %edx,%eax
 378:	5f                   	pop    %edi
 379:	5d                   	pop    %ebp
 37a:	c3                   	ret    

0000037b <strchr>:

char*
strchr(const char *s, char c)
{
 37b:	f3 0f 1e fb          	endbr32 
 37f:	55                   	push   %ebp
 380:	89 e5                	mov    %esp,%ebp
 382:	8b 45 08             	mov    0x8(%ebp),%eax
 385:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 389:	0f b6 10             	movzbl (%eax),%edx
 38c:	84 d2                	test   %dl,%dl
 38e:	74 09                	je     399 <strchr+0x1e>
    if(*s == c)
 390:	38 ca                	cmp    %cl,%dl
 392:	74 0a                	je     39e <strchr+0x23>
  for(; *s; s++)
 394:	83 c0 01             	add    $0x1,%eax
 397:	eb f0                	jmp    389 <strchr+0xe>
      return (char*)s;
  return 0;
 399:	b8 00 00 00 00       	mov    $0x0,%eax
}
 39e:	5d                   	pop    %ebp
 39f:	c3                   	ret    

000003a0 <gets>:

char*
gets(char *buf, int max)
{
 3a0:	f3 0f 1e fb          	endbr32 
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	57                   	push   %edi
 3a8:	56                   	push   %esi
 3a9:	53                   	push   %ebx
 3aa:	83 ec 1c             	sub    $0x1c,%esp
 3ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b0:	bb 00 00 00 00       	mov    $0x0,%ebx
 3b5:	89 de                	mov    %ebx,%esi
 3b7:	83 c3 01             	add    $0x1,%ebx
 3ba:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3bd:	7d 2e                	jge    3ed <gets+0x4d>
    cc = read(0, &c, 1);
 3bf:	83 ec 04             	sub    $0x4,%esp
 3c2:	6a 01                	push   $0x1
 3c4:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3c7:	50                   	push   %eax
 3c8:	6a 00                	push   $0x0
 3ca:	e8 f6 00 00 00       	call   4c5 <read>
    if(cc < 1)
 3cf:	83 c4 10             	add    $0x10,%esp
 3d2:	85 c0                	test   %eax,%eax
 3d4:	7e 17                	jle    3ed <gets+0x4d>
      break;
    buf[i++] = c;
 3d6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3da:	88 04 37             	mov    %al,(%edi,%esi,1)
    if(c == '\n' || c == '\r')
 3dd:	3c 0a                	cmp    $0xa,%al
 3df:	0f 94 c2             	sete   %dl
 3e2:	3c 0d                	cmp    $0xd,%al
 3e4:	0f 94 c0             	sete   %al
 3e7:	08 c2                	or     %al,%dl
 3e9:	74 ca                	je     3b5 <gets+0x15>
    buf[i++] = c;
 3eb:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 3ed:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 3f1:	89 f8                	mov    %edi,%eax
 3f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f6:	5b                   	pop    %ebx
 3f7:	5e                   	pop    %esi
 3f8:	5f                   	pop    %edi
 3f9:	5d                   	pop    %ebp
 3fa:	c3                   	ret    

000003fb <stat>:

int
stat(const char *n, struct stat *st)
{
 3fb:	f3 0f 1e fb          	endbr32 
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	56                   	push   %esi
 403:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 404:	83 ec 08             	sub    $0x8,%esp
 407:	6a 00                	push   $0x0
 409:	ff 75 08             	pushl  0x8(%ebp)
 40c:	e8 dc 00 00 00       	call   4ed <open>
  if(fd < 0)
 411:	83 c4 10             	add    $0x10,%esp
 414:	85 c0                	test   %eax,%eax
 416:	78 24                	js     43c <stat+0x41>
 418:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 41a:	83 ec 08             	sub    $0x8,%esp
 41d:	ff 75 0c             	pushl  0xc(%ebp)
 420:	50                   	push   %eax
 421:	e8 df 00 00 00       	call   505 <fstat>
 426:	89 c6                	mov    %eax,%esi
  close(fd);
 428:	89 1c 24             	mov    %ebx,(%esp)
 42b:	e8 a5 00 00 00       	call   4d5 <close>
  return r;
 430:	83 c4 10             	add    $0x10,%esp
}
 433:	89 f0                	mov    %esi,%eax
 435:	8d 65 f8             	lea    -0x8(%ebp),%esp
 438:	5b                   	pop    %ebx
 439:	5e                   	pop    %esi
 43a:	5d                   	pop    %ebp
 43b:	c3                   	ret    
    return -1;
 43c:	be ff ff ff ff       	mov    $0xffffffff,%esi
 441:	eb f0                	jmp    433 <stat+0x38>

00000443 <atoi>:

int
atoi(const char *s)
{
 443:	f3 0f 1e fb          	endbr32 
 447:	55                   	push   %ebp
 448:	89 e5                	mov    %esp,%ebp
 44a:	53                   	push   %ebx
 44b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 44e:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 453:	0f b6 01             	movzbl (%ecx),%eax
 456:	8d 58 d0             	lea    -0x30(%eax),%ebx
 459:	80 fb 09             	cmp    $0x9,%bl
 45c:	77 12                	ja     470 <atoi+0x2d>
    n = n*10 + *s++ - '0';
 45e:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
 461:	8d 14 1b             	lea    (%ebx,%ebx,1),%edx
 464:	83 c1 01             	add    $0x1,%ecx
 467:	0f be c0             	movsbl %al,%eax
 46a:	8d 54 10 d0          	lea    -0x30(%eax,%edx,1),%edx
 46e:	eb e3                	jmp    453 <atoi+0x10>
  return n;
}
 470:	89 d0                	mov    %edx,%eax
 472:	5b                   	pop    %ebx
 473:	5d                   	pop    %ebp
 474:	c3                   	ret    

00000475 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 475:	f3 0f 1e fb          	endbr32 
 479:	55                   	push   %ebp
 47a:	89 e5                	mov    %esp,%ebp
 47c:	56                   	push   %esi
 47d:	53                   	push   %ebx
 47e:	8b 75 08             	mov    0x8(%ebp),%esi
 481:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 484:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
 487:	89 f2                	mov    %esi,%edx
  src = vsrc;
  while(n-- > 0)
 489:	8d 58 ff             	lea    -0x1(%eax),%ebx
 48c:	85 c0                	test   %eax,%eax
 48e:	7e 0f                	jle    49f <memmove+0x2a>
    *dst++ = *src++;
 490:	0f b6 01             	movzbl (%ecx),%eax
 493:	88 02                	mov    %al,(%edx)
 495:	8d 49 01             	lea    0x1(%ecx),%ecx
 498:	8d 52 01             	lea    0x1(%edx),%edx
  while(n-- > 0)
 49b:	89 d8                	mov    %ebx,%eax
 49d:	eb ea                	jmp    489 <memmove+0x14>
  return vdst;
}
 49f:	89 f0                	mov    %esi,%eax
 4a1:	5b                   	pop    %ebx
 4a2:	5e                   	pop    %esi
 4a3:	5d                   	pop    %ebp
 4a4:	c3                   	ret    

000004a5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4a5:	b8 01 00 00 00       	mov    $0x1,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret    

000004ad <exit>:
SYSCALL(exit)
 4ad:	b8 02 00 00 00       	mov    $0x2,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret    

000004b5 <wait>:
SYSCALL(wait)
 4b5:	b8 03 00 00 00       	mov    $0x3,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret    

000004bd <pipe>:
SYSCALL(pipe)
 4bd:	b8 04 00 00 00       	mov    $0x4,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret    

000004c5 <read>:
SYSCALL(read)
 4c5:	b8 05 00 00 00       	mov    $0x5,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret    

000004cd <write>:
SYSCALL(write)
 4cd:	b8 10 00 00 00       	mov    $0x10,%eax
 4d2:	cd 40                	int    $0x40
 4d4:	c3                   	ret    

000004d5 <close>:
SYSCALL(close)
 4d5:	b8 15 00 00 00       	mov    $0x15,%eax
 4da:	cd 40                	int    $0x40
 4dc:	c3                   	ret    

000004dd <kill>:
SYSCALL(kill)
 4dd:	b8 06 00 00 00       	mov    $0x6,%eax
 4e2:	cd 40                	int    $0x40
 4e4:	c3                   	ret    

000004e5 <exec>:
SYSCALL(exec)
 4e5:	b8 07 00 00 00       	mov    $0x7,%eax
 4ea:	cd 40                	int    $0x40
 4ec:	c3                   	ret    

000004ed <open>:
SYSCALL(open)
 4ed:	b8 0f 00 00 00       	mov    $0xf,%eax
 4f2:	cd 40                	int    $0x40
 4f4:	c3                   	ret    

000004f5 <mknod>:
SYSCALL(mknod)
 4f5:	b8 11 00 00 00       	mov    $0x11,%eax
 4fa:	cd 40                	int    $0x40
 4fc:	c3                   	ret    

000004fd <unlink>:
SYSCALL(unlink)
 4fd:	b8 12 00 00 00       	mov    $0x12,%eax
 502:	cd 40                	int    $0x40
 504:	c3                   	ret    

00000505 <fstat>:
SYSCALL(fstat)
 505:	b8 08 00 00 00       	mov    $0x8,%eax
 50a:	cd 40                	int    $0x40
 50c:	c3                   	ret    

0000050d <link>:
SYSCALL(link)
 50d:	b8 13 00 00 00       	mov    $0x13,%eax
 512:	cd 40                	int    $0x40
 514:	c3                   	ret    

00000515 <mkdir>:
SYSCALL(mkdir)
 515:	b8 14 00 00 00       	mov    $0x14,%eax
 51a:	cd 40                	int    $0x40
 51c:	c3                   	ret    

0000051d <chdir>:
SYSCALL(chdir)
 51d:	b8 09 00 00 00       	mov    $0x9,%eax
 522:	cd 40                	int    $0x40
 524:	c3                   	ret    

00000525 <dup>:
SYSCALL(dup)
 525:	b8 0a 00 00 00       	mov    $0xa,%eax
 52a:	cd 40                	int    $0x40
 52c:	c3                   	ret    

0000052d <getpid>:
SYSCALL(getpid)
 52d:	b8 0b 00 00 00       	mov    $0xb,%eax
 532:	cd 40                	int    $0x40
 534:	c3                   	ret    

00000535 <sbrk>:
SYSCALL(sbrk)
 535:	b8 0c 00 00 00       	mov    $0xc,%eax
 53a:	cd 40                	int    $0x40
 53c:	c3                   	ret    

0000053d <sleep>:
SYSCALL(sleep)
 53d:	b8 0d 00 00 00       	mov    $0xd,%eax
 542:	cd 40                	int    $0x40
 544:	c3                   	ret    

00000545 <uptime>:
SYSCALL(uptime)
 545:	b8 0e 00 00 00       	mov    $0xe,%eax
 54a:	cd 40                	int    $0x40
 54c:	c3                   	ret    

0000054d <setslice>:
SYSCALL(setslice)
 54d:	b8 16 00 00 00       	mov    $0x16,%eax
 552:	cd 40                	int    $0x40
 554:	c3                   	ret    

00000555 <getslice>:
SYSCALL(getslice)
 555:	b8 17 00 00 00       	mov    $0x17,%eax
 55a:	cd 40                	int    $0x40
 55c:	c3                   	ret    

0000055d <fork2>:
SYSCALL(fork2)
 55d:	b8 18 00 00 00       	mov    $0x18,%eax
 562:	cd 40                	int    $0x40
 564:	c3                   	ret    

00000565 <getpinfo>:
SYSCALL(getpinfo)
 565:	b8 19 00 00 00       	mov    $0x19,%eax
 56a:	cd 40                	int    $0x40
 56c:	c3                   	ret    

0000056d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 56d:	55                   	push   %ebp
 56e:	89 e5                	mov    %esp,%ebp
 570:	83 ec 1c             	sub    $0x1c,%esp
 573:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 576:	6a 01                	push   $0x1
 578:	8d 55 f4             	lea    -0xc(%ebp),%edx
 57b:	52                   	push   %edx
 57c:	50                   	push   %eax
 57d:	e8 4b ff ff ff       	call   4cd <write>
}
 582:	83 c4 10             	add    $0x10,%esp
 585:	c9                   	leave  
 586:	c3                   	ret    

00000587 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 587:	55                   	push   %ebp
 588:	89 e5                	mov    %esp,%ebp
 58a:	57                   	push   %edi
 58b:	56                   	push   %esi
 58c:	53                   	push   %ebx
 58d:	83 ec 2c             	sub    $0x2c,%esp
 590:	89 45 d0             	mov    %eax,-0x30(%ebp)
 593:	89 d6                	mov    %edx,%esi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 595:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 599:	0f 95 c2             	setne  %dl
 59c:	89 f0                	mov    %esi,%eax
 59e:	c1 e8 1f             	shr    $0x1f,%eax
 5a1:	84 c2                	test   %al,%dl
 5a3:	74 42                	je     5e7 <printint+0x60>
    neg = 1;
    x = -xx;
 5a5:	f7 de                	neg    %esi
    neg = 1;
 5a7:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5ae:	bb 00 00 00 00       	mov    $0x0,%ebx
  do{
    buf[i++] = digits[x % base];
 5b3:	89 f0                	mov    %esi,%eax
 5b5:	ba 00 00 00 00       	mov    $0x0,%edx
 5ba:	f7 f1                	div    %ecx
 5bc:	89 df                	mov    %ebx,%edi
 5be:	83 c3 01             	add    $0x1,%ebx
 5c1:	0f b6 92 20 09 00 00 	movzbl 0x920(%edx),%edx
 5c8:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
 5cc:	89 f2                	mov    %esi,%edx
 5ce:	89 c6                	mov    %eax,%esi
 5d0:	39 d1                	cmp    %edx,%ecx
 5d2:	76 df                	jbe    5b3 <printint+0x2c>
  if(neg)
 5d4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 5d8:	74 2f                	je     609 <printint+0x82>
    buf[i++] = '-';
 5da:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 5df:	8d 5f 02             	lea    0x2(%edi),%ebx
 5e2:	8b 75 d0             	mov    -0x30(%ebp),%esi
 5e5:	eb 15                	jmp    5fc <printint+0x75>
  neg = 0;
 5e7:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 5ee:	eb be                	jmp    5ae <printint+0x27>

  while(--i >= 0)
    putc(fd, buf[i]);
 5f0:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 5f5:	89 f0                	mov    %esi,%eax
 5f7:	e8 71 ff ff ff       	call   56d <putc>
  while(--i >= 0)
 5fc:	83 eb 01             	sub    $0x1,%ebx
 5ff:	79 ef                	jns    5f0 <printint+0x69>
}
 601:	83 c4 2c             	add    $0x2c,%esp
 604:	5b                   	pop    %ebx
 605:	5e                   	pop    %esi
 606:	5f                   	pop    %edi
 607:	5d                   	pop    %ebp
 608:	c3                   	ret    
 609:	8b 75 d0             	mov    -0x30(%ebp),%esi
 60c:	eb ee                	jmp    5fc <printint+0x75>

0000060e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 60e:	f3 0f 1e fb          	endbr32 
 612:	55                   	push   %ebp
 613:	89 e5                	mov    %esp,%ebp
 615:	57                   	push   %edi
 616:	56                   	push   %esi
 617:	53                   	push   %ebx
 618:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 61b:	8d 45 10             	lea    0x10(%ebp),%eax
 61e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 621:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 626:	bb 00 00 00 00       	mov    $0x0,%ebx
 62b:	eb 14                	jmp    641 <printf+0x33>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 62d:	89 fa                	mov    %edi,%edx
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	e8 36 ff ff ff       	call   56d <putc>
 637:	eb 05                	jmp    63e <printf+0x30>
      }
    } else if(state == '%'){
 639:	83 fe 25             	cmp    $0x25,%esi
 63c:	74 25                	je     663 <printf+0x55>
  for(i = 0; fmt[i]; i++){
 63e:	83 c3 01             	add    $0x1,%ebx
 641:	8b 45 0c             	mov    0xc(%ebp),%eax
 644:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 648:	84 c0                	test   %al,%al
 64a:	0f 84 23 01 00 00    	je     773 <printf+0x165>
    c = fmt[i] & 0xff;
 650:	0f be f8             	movsbl %al,%edi
 653:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 656:	85 f6                	test   %esi,%esi
 658:	75 df                	jne    639 <printf+0x2b>
      if(c == '%'){
 65a:	83 f8 25             	cmp    $0x25,%eax
 65d:	75 ce                	jne    62d <printf+0x1f>
        state = '%';
 65f:	89 c6                	mov    %eax,%esi
 661:	eb db                	jmp    63e <printf+0x30>
      if(c == 'd'){
 663:	83 f8 64             	cmp    $0x64,%eax
 666:	74 49                	je     6b1 <printf+0xa3>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 668:	83 f8 78             	cmp    $0x78,%eax
 66b:	0f 94 c1             	sete   %cl
 66e:	83 f8 70             	cmp    $0x70,%eax
 671:	0f 94 c2             	sete   %dl
 674:	08 d1                	or     %dl,%cl
 676:	75 63                	jne    6db <printf+0xcd>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 678:	83 f8 73             	cmp    $0x73,%eax
 67b:	0f 84 84 00 00 00    	je     705 <printf+0xf7>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 681:	83 f8 63             	cmp    $0x63,%eax
 684:	0f 84 b7 00 00 00    	je     741 <printf+0x133>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 68a:	83 f8 25             	cmp    $0x25,%eax
 68d:	0f 84 cc 00 00 00    	je     75f <printf+0x151>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 693:	ba 25 00 00 00       	mov    $0x25,%edx
 698:	8b 45 08             	mov    0x8(%ebp),%eax
 69b:	e8 cd fe ff ff       	call   56d <putc>
        putc(fd, c);
 6a0:	89 fa                	mov    %edi,%edx
 6a2:	8b 45 08             	mov    0x8(%ebp),%eax
 6a5:	e8 c3 fe ff ff       	call   56d <putc>
      }
      state = 0;
 6aa:	be 00 00 00 00       	mov    $0x0,%esi
 6af:	eb 8d                	jmp    63e <printf+0x30>
        printint(fd, *ap, 10, 1);
 6b1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 6b4:	8b 17                	mov    (%edi),%edx
 6b6:	83 ec 0c             	sub    $0xc,%esp
 6b9:	6a 01                	push   $0x1
 6bb:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6c0:	8b 45 08             	mov    0x8(%ebp),%eax
 6c3:	e8 bf fe ff ff       	call   587 <printint>
        ap++;
 6c8:	83 c7 04             	add    $0x4,%edi
 6cb:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 6ce:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6d1:	be 00 00 00 00       	mov    $0x0,%esi
 6d6:	e9 63 ff ff ff       	jmp    63e <printf+0x30>
        printint(fd, *ap, 16, 0);
 6db:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 6de:	8b 17                	mov    (%edi),%edx
 6e0:	83 ec 0c             	sub    $0xc,%esp
 6e3:	6a 00                	push   $0x0
 6e5:	b9 10 00 00 00       	mov    $0x10,%ecx
 6ea:	8b 45 08             	mov    0x8(%ebp),%eax
 6ed:	e8 95 fe ff ff       	call   587 <printint>
        ap++;
 6f2:	83 c7 04             	add    $0x4,%edi
 6f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 6f8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6fb:	be 00 00 00 00       	mov    $0x0,%esi
 700:	e9 39 ff ff ff       	jmp    63e <printf+0x30>
        s = (char*)*ap;
 705:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 708:	8b 30                	mov    (%eax),%esi
        ap++;
 70a:	83 c0 04             	add    $0x4,%eax
 70d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 710:	85 f6                	test   %esi,%esi
 712:	75 28                	jne    73c <printf+0x12e>
          s = "(null)";
 714:	be 16 09 00 00       	mov    $0x916,%esi
 719:	8b 7d 08             	mov    0x8(%ebp),%edi
 71c:	eb 0d                	jmp    72b <printf+0x11d>
          putc(fd, *s);
 71e:	0f be d2             	movsbl %dl,%edx
 721:	89 f8                	mov    %edi,%eax
 723:	e8 45 fe ff ff       	call   56d <putc>
          s++;
 728:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 72b:	0f b6 16             	movzbl (%esi),%edx
 72e:	84 d2                	test   %dl,%dl
 730:	75 ec                	jne    71e <printf+0x110>
      state = 0;
 732:	be 00 00 00 00       	mov    $0x0,%esi
 737:	e9 02 ff ff ff       	jmp    63e <printf+0x30>
 73c:	8b 7d 08             	mov    0x8(%ebp),%edi
 73f:	eb ea                	jmp    72b <printf+0x11d>
        putc(fd, *ap);
 741:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 744:	0f be 17             	movsbl (%edi),%edx
 747:	8b 45 08             	mov    0x8(%ebp),%eax
 74a:	e8 1e fe ff ff       	call   56d <putc>
        ap++;
 74f:	83 c7 04             	add    $0x4,%edi
 752:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 755:	be 00 00 00 00       	mov    $0x0,%esi
 75a:	e9 df fe ff ff       	jmp    63e <printf+0x30>
        putc(fd, c);
 75f:	89 fa                	mov    %edi,%edx
 761:	8b 45 08             	mov    0x8(%ebp),%eax
 764:	e8 04 fe ff ff       	call   56d <putc>
      state = 0;
 769:	be 00 00 00 00       	mov    $0x0,%esi
 76e:	e9 cb fe ff ff       	jmp    63e <printf+0x30>
    }
  }
}
 773:	8d 65 f4             	lea    -0xc(%ebp),%esp
 776:	5b                   	pop    %ebx
 777:	5e                   	pop    %esi
 778:	5f                   	pop    %edi
 779:	5d                   	pop    %ebp
 77a:	c3                   	ret    

0000077b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 77b:	f3 0f 1e fb          	endbr32 
 77f:	55                   	push   %ebp
 780:	89 e5                	mov    %esp,%ebp
 782:	57                   	push   %edi
 783:	56                   	push   %esi
 784:	53                   	push   %ebx
 785:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 788:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78b:	a1 38 0c 00 00       	mov    0xc38,%eax
 790:	eb 02                	jmp    794 <free+0x19>
 792:	89 d0                	mov    %edx,%eax
 794:	39 c8                	cmp    %ecx,%eax
 796:	73 04                	jae    79c <free+0x21>
 798:	39 08                	cmp    %ecx,(%eax)
 79a:	77 12                	ja     7ae <free+0x33>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79c:	8b 10                	mov    (%eax),%edx
 79e:	39 c2                	cmp    %eax,%edx
 7a0:	77 f0                	ja     792 <free+0x17>
 7a2:	39 c8                	cmp    %ecx,%eax
 7a4:	72 08                	jb     7ae <free+0x33>
 7a6:	39 ca                	cmp    %ecx,%edx
 7a8:	77 04                	ja     7ae <free+0x33>
 7aa:	89 d0                	mov    %edx,%eax
 7ac:	eb e6                	jmp    794 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ae:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7b1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7b4:	8b 10                	mov    (%eax),%edx
 7b6:	39 d7                	cmp    %edx,%edi
 7b8:	74 19                	je     7d3 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bd:	8b 50 04             	mov    0x4(%eax),%edx
 7c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c3:	39 ce                	cmp    %ecx,%esi
 7c5:	74 1b                	je     7e2 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7c7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7c9:	a3 38 0c 00 00       	mov    %eax,0xc38
}
 7ce:	5b                   	pop    %ebx
 7cf:	5e                   	pop    %esi
 7d0:	5f                   	pop    %edi
 7d1:	5d                   	pop    %ebp
 7d2:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 7d3:	03 72 04             	add    0x4(%edx),%esi
 7d6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d9:	8b 10                	mov    (%eax),%edx
 7db:	8b 12                	mov    (%edx),%edx
 7dd:	89 53 f8             	mov    %edx,-0x8(%ebx)
 7e0:	eb db                	jmp    7bd <free+0x42>
    p->s.size += bp->s.size;
 7e2:	03 53 fc             	add    -0x4(%ebx),%edx
 7e5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7e8:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7eb:	89 10                	mov    %edx,(%eax)
 7ed:	eb da                	jmp    7c9 <free+0x4e>

000007ef <morecore>:

static Header*
morecore(uint nu)
{
 7ef:	55                   	push   %ebp
 7f0:	89 e5                	mov    %esp,%ebp
 7f2:	53                   	push   %ebx
 7f3:	83 ec 04             	sub    $0x4,%esp
 7f6:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 7f8:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 7fd:	77 05                	ja     804 <morecore+0x15>
    nu = 4096;
 7ff:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 804:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 80b:	83 ec 0c             	sub    $0xc,%esp
 80e:	50                   	push   %eax
 80f:	e8 21 fd ff ff       	call   535 <sbrk>
  if(p == (char*)-1)
 814:	83 c4 10             	add    $0x10,%esp
 817:	83 f8 ff             	cmp    $0xffffffff,%eax
 81a:	74 1c                	je     838 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 81c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 81f:	83 c0 08             	add    $0x8,%eax
 822:	83 ec 0c             	sub    $0xc,%esp
 825:	50                   	push   %eax
 826:	e8 50 ff ff ff       	call   77b <free>
  return freep;
 82b:	a1 38 0c 00 00       	mov    0xc38,%eax
 830:	83 c4 10             	add    $0x10,%esp
}
 833:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 836:	c9                   	leave  
 837:	c3                   	ret    
    return 0;
 838:	b8 00 00 00 00       	mov    $0x0,%eax
 83d:	eb f4                	jmp    833 <morecore+0x44>

0000083f <malloc>:

void*
malloc(uint nbytes)
{
 83f:	f3 0f 1e fb          	endbr32 
 843:	55                   	push   %ebp
 844:	89 e5                	mov    %esp,%ebp
 846:	53                   	push   %ebx
 847:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84a:	8b 45 08             	mov    0x8(%ebp),%eax
 84d:	8d 58 07             	lea    0x7(%eax),%ebx
 850:	c1 eb 03             	shr    $0x3,%ebx
 853:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 856:	8b 0d 38 0c 00 00    	mov    0xc38,%ecx
 85c:	85 c9                	test   %ecx,%ecx
 85e:	74 04                	je     864 <malloc+0x25>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	8b 01                	mov    (%ecx),%eax
 862:	eb 4b                	jmp    8af <malloc+0x70>
    base.s.ptr = freep = prevp = &base;
 864:	c7 05 38 0c 00 00 3c 	movl   $0xc3c,0xc38
 86b:	0c 00 00 
 86e:	c7 05 3c 0c 00 00 3c 	movl   $0xc3c,0xc3c
 875:	0c 00 00 
    base.s.size = 0;
 878:	c7 05 40 0c 00 00 00 	movl   $0x0,0xc40
 87f:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 882:	b9 3c 0c 00 00       	mov    $0xc3c,%ecx
 887:	eb d7                	jmp    860 <malloc+0x21>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 889:	74 1a                	je     8a5 <malloc+0x66>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 88b:	29 da                	sub    %ebx,%edx
 88d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 890:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 893:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 896:	89 0d 38 0c 00 00    	mov    %ecx,0xc38
      return (void*)(p + 1);
 89c:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 89f:	83 c4 04             	add    $0x4,%esp
 8a2:	5b                   	pop    %ebx
 8a3:	5d                   	pop    %ebp
 8a4:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 8a5:	8b 10                	mov    (%eax),%edx
 8a7:	89 11                	mov    %edx,(%ecx)
 8a9:	eb eb                	jmp    896 <malloc+0x57>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ab:	89 c1                	mov    %eax,%ecx
 8ad:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 8af:	8b 50 04             	mov    0x4(%eax),%edx
 8b2:	39 da                	cmp    %ebx,%edx
 8b4:	73 d3                	jae    889 <malloc+0x4a>
    if(p == freep)
 8b6:	39 05 38 0c 00 00    	cmp    %eax,0xc38
 8bc:	75 ed                	jne    8ab <malloc+0x6c>
      if((p = morecore(nunits)) == 0)
 8be:	89 d8                	mov    %ebx,%eax
 8c0:	e8 2a ff ff ff       	call   7ef <morecore>
 8c5:	85 c0                	test   %eax,%eax
 8c7:	75 e2                	jne    8ab <malloc+0x6c>
 8c9:	eb d4                	jmp    89f <malloc+0x60>
