	.file	"hashtable.c"
	.intel_syntax noprefix
	.text
	.type	superhash, @function
superhash:
.LFB2:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	.cfi_offset 3, -24
	mov	QWORD PTR -16[rbp], rdi
#APP
# 37 "hashtable.c" 1
	.intel_syntax noprefix
	xor	r8, r8
	xor	rbx, rbx
	.loop_first:
	mov	rax, [rdi+r8]
	test	al, al
	je	.break_first
	cmp	al, 10
	je	.break_first
	cmp	al, 32
	je	.break_first
	cmp 	al, 'A'
	jb	.break_first
	cmp	al, 'z'
	ja	.break_first
	cmp	al, 'Z'
	jb	.lbl_first
	cmp al, 'a'
	jb	.break_first
	.lbl_first:
	ror	rbx, 1
	xor	rbx, rax
	inc	r8
	jmp	.loop_first
	.break_first:
	mov	rax, rbx
	xor    rdx, rdx
	div    8191d
	mov    rax, rdx
	.att_syntax
	
# 0 "" 2
#NO_APP
	nop
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	superhash, .-superhash
	.type	hash, @function
hash:
.LFB3:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi
	mov	DWORD PTR -20[rbp], 0
	mov	DWORD PTR -16[rbp], 0
.L8:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	je	.L10
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 10
	je	.L11
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	al, 32
	je	.L12
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	ispunct@PLT
	test	eax, eax
	jne	.L13
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -16[rbp]
	add	eax, eax
	mov	DWORD PTR -8[rbp], eax
	mov	eax, DWORD PTR -16[rbp]
	sar	eax, 31
	mov	DWORD PTR -4[rbp], eax
	mov	eax, DWORD PTR -8[rbp]
	or	eax, DWORD PTR -4[rbp]
	mov	DWORD PTR -16[rbp], eax
	mov	eax, DWORD PTR -12[rbp]
	xor	DWORD PTR -16[rbp], eax
	add	DWORD PTR -20[rbp], 1
	jmp	.L8
.L10:
	nop
	jmp	.L4
.L11:
	nop
	jmp	.L4
.L12:
	nop
	jmp	.L4
.L13:
	nop
.L4:
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	imul	rdx, rdx, -2147221471
	shr	rdx, 32
	add	edx, eax
	mov	ecx, edx
	sar	ecx, 12
	cdq
	sub	ecx, edx
	mov	edx, ecx
	mov	ecx, edx
	sal	ecx, 13
	sub	ecx, edx
	sub	eax, ecx
	mov	edx, eax
	mov	eax, edx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	hash, .-hash





	.globl	ht_search
	.type	ht_search, @function
ht_search:
.LFB4:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32

	push rsi
	push rdi
	mov	rdi, rsi
	call	hash
	pop rdi
	pop rsi             ;rdi - ht, rsi - string, rax - hash

	mov rax, [rax*8+rdi]    ;there is first elem with an appropriate hash
.loop_search:
    test rax, rax
    je .loop_search_end
    mov rbx, [rax+8]        ;*(char*)



    xor r8, r8
.loop_strcmp:
    test [rax+r8], [rax+r8]
    je .value_end
    test [rsi+r8], [rsi+r8]
    je .not_equal
    inc r8
    jmp .loop_strcmp

.value_end:
    test [rsi+r8], [rsi+r8]
    je .loop_search_end

.not_equal:
    mov rax, [rax]
    jmp .loop_search

.loop_search_end:






	.globl	ht_insert
	.type	ht_insert, @function
ht_insert:
.LFB5:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	rdx, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	ht_search
	test	rax, rax
	jne	.L20
	mov	esi, 16
	mov	edi, 1
	call	calloc@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	hash
	mov	DWORD PTR -12[rbp], eax
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR -12[rbp]
	mov	rdx, QWORD PTR [rax+rdx*8]
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR [rax], rdx
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, QWORD PTR -32[rbp]
	mov	QWORD PTR 8[rax], rdx
	mov	rax, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR -12[rbp]
	mov	rcx, QWORD PTR -8[rbp]
	mov	QWORD PTR [rax+rdx*8], rcx
.L20:
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	ht_insert, .-ht_insert
	.ident	"GCC: (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005"
	.section	.note.GNU-stack,"",@progbits
