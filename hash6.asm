section .text

	global Super_Hash:function
Super_Hash:
	push	rbp
	mov	rbp, rsp
	xor	r8, r8
  	xor	rbx, rbx

.loop:
	mov	rax, [rdi+r8]
	test	al, al
	je	.break
	cmp	al, 10
	je	.break
	cmp	al, 32
	je	.break
	cmp 	al, 'A'
	jb	.break
	cmp	al, 'z'
	ja	.break
	cmp	al, 'Z'
	jb	.lbl
	cmp al, 'a'
	jb	.break
.lbl:
	ror	rbx, 1
	xor	rbx, rax
	inc	r8
	jmp	.loop
.break:
	mov	rax, rbx
	mov	rsp, rbp
	pop	rbp
	ret
