	.file	"main.c"
	.intel_syntax noprefix
	.section	.rodata
.LC0:
	.string	"onegin.txt"
	.section	.data.rel.local,"aw",@progbits
	.align 8
	.type	FILENAME, @object
	.size	FILENAME, 8
FILENAME:
	.quad	.LC0
	.section	.rodata
.LC1:
	.string	"Error while reading file!"
.LC3:
	.string	"Total run time: %lg\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 4161632
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	call	clock@PLT
	mov	QWORD PTR -4161584[rbp], rax
	lea	rax, -4096016[rbp]
	mov	edx, 4096000
	mov	esi, 0
	mov	rdi, rax
	call	memset@PLT
	lea	rax, -4161552[rbp]
	mov	edx, 65528
	mov	esi, 0
	mov	rdi, rax
	call	memset@PLT
	mov	QWORD PTR -4161600[rbp], 0
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	rax, QWORD PTR FILENAME[rip]
	lea	rdx, -4161600[rbp]
	lea	rcx, -4096016[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	load_wordbuf
	test	eax, eax
	je	.L2
	mov	rax, QWORD PTR stdout[rip]
	mov	rcx, rax
	mov	edx, 25
	mov	esi, 1
	lea	rdi, .LC1[rip]
	call	fwrite@PLT
.L2:
	mov	QWORD PTR -4161592[rbp], 0
	jmp	.L3
.L4:
	lea	rax, -4096016[rbp]
	mov	rdx, QWORD PTR -4161592[rbp]
	sal	rdx, 6
	add	rdx, rax
	lea	rax, -4161552[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	ht_insert@PLT
	add	QWORD PTR -4161592[rbp], 1
.L3:
	mov	rax, QWORD PTR -4161600[rbp]
	cmp	QWORD PTR -4161592[rbp], rax
	jb	.L4
	mov	DWORD PTR -4161604[rbp], 0
	jmp	.L5
.L6:
	call	rand@PLT
	mov	ecx, eax
	movsx	rax, ecx
	imul	rax, rax, -2147221471
	shr	rax, 32
	add	eax, ecx
	sar	eax, 12
	mov	edx, eax
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	mov	edx, eax
	sal	edx, 13
	sub	edx, eax
	mov	eax, ecx
	sub	eax, edx
	lea	rdx, -4096016[rbp]
	cdqe
	sal	rax, 6
	add	rax, rdx
	mov	QWORD PTR -4161576[rbp], rax
	mov	rdx, QWORD PTR -4161576[rbp]
	lea	rax, -4161552[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	ht_search@PLT
	add	DWORD PTR -4161604[rbp], 1
.L5:
	cmp	DWORD PTR -4161604[rbp], 999999
	jbe	.L6
	call	clock@PLT
	mov	QWORD PTR -4161568[rbp], rax
	mov	rax, QWORD PTR -4161568[rbp]
	sub	rax, QWORD PTR -4161584[rbp]
	pxor	xmm0, xmm0
	cvtsi2sdq	xmm0, rax
	movsd	xmm1, QWORD PTR .LC2[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -4161560[rbp], xmm0
	mov	rax, QWORD PTR -4161560[rbp]
	mov	QWORD PTR -4161624[rbp], rax
	movsd	xmm0, QWORD PTR -4161624[rbp]
	lea	rdi, .LC3[rip]
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	mov	rsi, QWORD PTR -8[rbp]
	xor	rsi, QWORD PTR fs:40
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
.LC4:
	.string	"main.c"
.LC5:
	.string	"filename"
.LC6:
	.string	"buf"
.LC7:
	.string	"r"
.LC8:
	.string	"%63s"
	.text
	.type	load_wordbuf, @function
load_wordbuf:
.LFB3:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -40[rbp], rdx
	cmp	QWORD PTR -24[rbp], 0
	jne	.L10
	lea	rcx, __PRETTY_FUNCTION__.2887[rip]
	mov	edx, 49
	lea	rsi, .LC4[rip]
	lea	rdi, .LC5[rip]
	call	__assert_fail@PLT
.L10:
	cmp	QWORD PTR -32[rbp], 0
	jne	.L11
	lea	rcx, __PRETTY_FUNCTION__.2887[rip]
	mov	edx, 50
	lea	rsi, .LC4[rip]
	lea	rdi, .LC6[rip]
	call	__assert_fail@PLT
.L11:
	mov	rax, QWORD PTR -24[rbp]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L12
	mov	eax, 1
	jmp	.L13
.L12:
	mov	QWORD PTR -16[rbp], 0
	jmp	.L14
.L16:
	add	QWORD PTR -16[rbp], 1
.L14:
	cmp	QWORD PTR -16[rbp], 63999
	ja	.L15
	mov	rax, QWORD PTR -16[rbp]
	sal	rax, 6
	mov	rdx, rax
	mov	rax, QWORD PTR -32[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	cmp	eax, 1
	je	.L16
.L15:
	mov	rax, QWORD PTR -40[rbp]
	mov	rdx, QWORD PTR -16[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	load_wordbuf, .-load_wordbuf
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.2887, @object
	.size	__PRETTY_FUNCTION__.2887, 13
__PRETTY_FUNCTION__.2887:
	.string	"load_wordbuf"
	.align 8
.LC2:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005"
	.section	.note.GNU-stack,"",@progbits
