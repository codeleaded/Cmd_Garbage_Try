	.file	"Main.c"
	.intel_syntax noprefix
	.text
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
	push	rbp
	.seh_pushreg	rbp
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 56
	.seh_stackalloc	56
	lea	rbp, 48[rsp]
	.seh_setframe	rbp, 48
	.seh_endprologue
	mov	QWORD PTR 32[rbp], rcx
	mov	QWORD PTR 40[rbp], rdx
	mov	QWORD PTR 48[rbp], r8
	mov	QWORD PTR 56[rbp], r9
	lea	rax, 40[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rbx, QWORD PTR -16[rbp]
	mov	ecx, 1
	mov	rax, QWORD PTR __imp___acrt_iob_func[rip]
	call	rax
	mov	rcx, rax
	mov	rax, QWORD PTR 32[rbp]
	mov	r8, rbx
	mov	rdx, rax
	call	__mingw_vfprintf
	mov	DWORD PTR -4[rbp], eax
	mov	eax, DWORD PTR -4[rbp]
	add	rsp, 56
	pop	rbx
	pop	rbp
	ret
	.seh_endproc
	.globl	Garbage_Collector
	.bss
	.align 32
Garbage_Collector:
	.space 32
	.text
	.globl	Collector_Init
	.def	Collector_Init;	.scl	2;	.type	32;	.endef
	.seh_proc	Collector_Init
Collector_Init:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	test	rax, rax
	je	.L4
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	mov	rcx, rax
	call	free
.L4:
	mov	rax, QWORD PTR Garbage_Collector[rip+16]
	mov	edx, 8
	mov	rcx, rax
	call	calloc
	mov	QWORD PTR Garbage_Collector[rip+24], rax
	mov	QWORD PTR Garbage_Collector[rip+8], 0
	nop
	add	rsp, 32
	pop	rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii "Free: %i\12\0"
	.text
	.globl	Collector_Flush
	.def	Collector_Flush;	.scl	2;	.type	32;	.endef
	.seh_proc	Collector_Flush
Collector_Flush:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 48
	.seh_stackalloc	48
	.seh_endprologue
	mov	DWORD PTR -4[rbp], 0
	jmp	.L6
.L8:
	mov	eax, DWORD PTR -4[rbp]
	mov	edx, eax
	lea	rax, .LC0[rip]
	mov	rcx, rax
	call	printf
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	sal	rdx, 3
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	test	rax, rax
	je	.L7
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	sal	rdx, 3
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	rcx, rax
	call	free
.L7:
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	sal	rdx, 3
	add	rax, rdx
	mov	QWORD PTR [rax], 0
	add	DWORD PTR -4[rbp], 1
.L6:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR Garbage_Collector[rip+8]
	cmp	rdx, rax
	jb	.L8
	call	Collector_Init
	nop
	add	rsp, 48
	pop	rbp
	ret
	.seh_endproc
	.globl	Collector_Exit
	.def	Collector_Exit;	.scl	2;	.type	32;	.endef
	.seh_proc	Collector_Exit
Collector_Exit:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	call	Collector_Flush
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	test	rax, rax
	je	.L11
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	mov	rcx, rax
	call	free
.L11:
	nop
	add	rsp, 32
	pop	rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "Couldn't allocate Memory...\12\0"
	.text
	.globl	Alloc
	.def	Alloc;	.scl	2;	.type	32;	.endef
	.seh_proc	Alloc
Alloc:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 48
	.seh_stackalloc	48
	.seh_endprologue
	mov	QWORD PTR 16[rbp], rcx
	mov	rdx, QWORD PTR Garbage_Collector[rip+8]
	mov	rax, QWORD PTR Garbage_Collector[rip+16]
	cmp	rdx, rax
	jnb	.L17
	mov	rax, QWORD PTR 16[rbp]
	mov	rcx, rax
	call	malloc
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	je	.L18
	mov	rax, QWORD PTR Garbage_Collector[rip+24]
	mov	rdx, QWORD PTR Garbage_Collector[rip+8]
	sal	rdx, 3
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR [rdx], rax
	mov	rax, QWORD PTR Garbage_Collector[rip+8]
	add	rax, 1
	mov	QWORD PTR Garbage_Collector[rip+8], rax
	mov	rax, QWORD PTR -8[rbp]
	jmp	.L16
.L17:
	nop
	jmp	.L14
.L18:
	nop
.L14:
	lea	rax, .LC1[rip]
	mov	rcx, rax
	call	printf
	mov	eax, 0
.L16:
	add	rsp, 48
	pop	rbp
	ret
	.seh_endproc
	.globl	Collector_Main
	.def	Collector_Main;	.scl	2;	.type	32;	.endef
	.seh_proc	Collector_Main
Collector_Main:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	QWORD PTR 16[rbp], rcx
	mov	QWORD PTR 24[rbp], rdx
	mov	rax, QWORD PTR 16[rbp]
	mov	QWORD PTR Garbage_Collector[rip], rax
	mov	rax, QWORD PTR 24[rbp]
	mov	QWORD PTR Garbage_Collector[rip+16], rax
	call	Collector_Init
	mov	rax, QWORD PTR Garbage_Collector[rip]
	call	rax
	call	Collector_Exit
	nop
	add	rsp, 32
	pop	rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "i: %i - \0"
.LC3:
	.ascii "s: %s | \0"
.LC4:
	.ascii "\12\0"
	.text
	.globl	Main
	.def	Main;	.scl	2;	.type	32;	.endef
	.seh_proc	Main
Main:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 48
	.seh_stackalloc	48
	.seh_endprologue
	mov	DWORD PTR -4[rbp], 0
	jmp	.L21
.L24:
	mov	DWORD PTR -8[rbp], 0
	jmp	.L22
.L23:
	mov	ecx, 16
	call	Alloc
	mov	QWORD PTR -16[rbp], rax
	mov	eax, DWORD PTR -8[rbp]
	mov	edx, eax
	lea	rax, .LC2[rip]
	mov	rcx, rax
	call	printf
	mov	rax, QWORD PTR -16[rbp]
	mov	rdx, rax
	lea	rax, .LC3[rip]
	mov	rcx, rax
	call	printf
	add	DWORD PTR -8[rbp], 1
.L22:
	cmp	DWORD PTR -8[rbp], 199
	jle	.L23
	lea	rax, .LC4[rip]
	mov	rcx, rax
	call	printf
	call	Collector_Flush
	add	DWORD PTR -4[rbp], 1
.L21:
	cmp	DWORD PTR -4[rbp], 9
	jle	.L24
	nop
	nop
	add	rsp, 48
	pop	rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbp
	.seh_pushreg	rbp
	mov	rbp, rsp
	.seh_setframe	rbp, 0
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	mov	edx, 200
	lea	rax, Main[rip]
	mov	rcx, rax
	call	Collector_Main
	mov	eax, 0
	add	rsp, 32
	pop	rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev10, Built by MSYS2 project) 12.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	free;	.scl	2;	.type	32;	.endef
	.def	calloc;	.scl	2;	.type	32;	.endef
	.def	malloc;	.scl	2;	.type	32;	.endef
