/*-*- mode:unix-assembly; indent-tabs-mode:t; tab-width:8; coding:utf-8     -*-│
│vi: set et ft=asm ts=8 tw=8 fenc=utf-8                                     :vi│
╞══════════════════════════════════════════════════════════════════════════════╡
│ Copyright 2020 Justine Alexandra Roberts Tunney                              │
│                                                                              │
│ Permission to use, copy, modify, and/or distribute this software for         │
│ any purpose with or without fee is hereby granted, provided that the         │
│ above copyright notice and this permission notice appear in all copies.      │
│                                                                              │
│ THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL                │
│ WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED                │
│ WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE             │
│ AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL         │
│ DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR        │
│ PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER               │
│ TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR             │
│ PERFORMANCE OF THIS SOFTWARE.                                                │
╚─────────────────────────────────────────────────────────────────────────────*/
#include "libc/macros.h"
.source	__FILE__

	.rodata.cst4
__asan_option_detect_stack_use_after_return:
	.long	0
	.endobj	__asan_option_detect_stack_use_after_return,globl
	.previous

	.bss
__asan_noreentry:
	.byte	0
	.endobj	__asan_noreentry
	.previous

__asan_report_load1:
	push	$1
	jmp	OnReportLoad
	.endfn	__asan_report_load1,globl
__asan_report_load2:
	push	$2
	jmp	OnReportLoad
	.endfn	__asan_report_load2,globl
__asan_report_load4:
	push	$4
	jmp	OnReportLoad
	.endfn	__asan_report_load4,globl
__asan_report_load8:
	push	$8
	jmp	OnReportLoad
	.endfn	__asan_report_load8,globl
__asan_report_load16:
	push	$16
	jmp	OnReportLoad
	.endfn	__asan_report_load16,globl
__asan_report_load32:
	push	$32
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	__asan_report_load32,globl
OnReportLoad:
	pop	%rsi
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	OnReportLoad
__asan_report_load_n:
	lea	__asan_report_load(%rip),%r11
	jmp	__asan_report_noreentry
	.endfn	__asan_report_load_n,globl

__asan_report_store1:
	push	$1
	jmp	ReportStore
	.endfn	__asan_report_store1,globl
__asan_report_store2:
	push	$2
	jmp	ReportStore
	.endfn	__asan_report_store2,globl
__asan_report_store4:
	push	$4
	jmp	ReportStore
	.endfn	__asan_report_store4,globl
__asan_report_store8:
	push	$8
	jmp	ReportStore
	.endfn	__asan_report_store8,globl
__asan_report_store16:
	push	$16
	jmp	ReportStore
	.endfn	__asan_report_store16,globl
__asan_report_store32:
	push	$32
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	__asan_report_store32,globl
ReportStore:
	pop	%rsi
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	ReportStore
__asan_report_store_n:
	lea	__asan_report_store(%rip),%r11
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	__asan_report_store_n,globl

__asan_report_noreentry:
	push	%rbp
	mov	%rsp,%rbp
	xor	%eax,%eax
	mov	$1,%r10b
	cmpxchg	%r10b,__asan_noreentry(%rip)
	jnz	2f
	call	*%r11
	decb	__asan_noreentry(%rip)
2:	pop	%rbp
	ret
	.endfn	__asan_report_noreentry

__asan_stack_free_0:
	push	$0
	jmp	OnStackFree
	.endfn	__asan_stack_free_0,globl
__asan_stack_free_1:
	push	$1
	jmp	OnStackFree
	.endfn	__asan_stack_free_1,globl
__asan_stack_free_2:
	push	$2
	jmp	OnStackFree
	.endfn	__asan_stack_free_2,globl
__asan_stack_free_3:
	push	$3
	jmp	OnStackFree
	.endfn	__asan_stack_free_3,globl
__asan_stack_free_4:
	push	$4
	jmp	OnStackFree
	.endfn	__asan_stack_free_4,globl
__asan_stack_free_5:
	push	$5
	jmp	OnStackFree
	.endfn	__asan_stack_free_5,globl
__asan_stack_free_6:
	push	$6
	jmp	OnStackFree
	.endfn	__asan_stack_free_6,globl
__asan_stack_free_7:
	push	$7
	jmp	OnStackFree
	.endfn	__asan_stack_free_7,globl
__asan_stack_free_8:
	push	$8
	jmp	OnStackFree
	.endfn	__asan_stack_free_8,globl
__asan_stack_free_9:
	push	$9
	jmp	OnStackFree
	.endfn	__asan_stack_free_9,globl
__asan_stack_free_10:
	push	$10
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	__asan_stack_free_10,globl
OnStackFree:
	pop	%rdx
	jmp	__asan_stack_free
	.endfn	OnStackFree

__asan_stack_malloc_0:
	push	$0
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_0,globl
__asan_stack_malloc_1:
	push	$1
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_1,globl
__asan_stack_malloc_2:
	push	$2
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_2,globl
__asan_stack_malloc_3:
	push	$3
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_3,globl
__asan_stack_malloc_4:
	push	$4
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_4,globl
__asan_stack_malloc_5:
	push	$5
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_5,globl
__asan_stack_malloc_6:
	push	$6
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_6,globl
__asan_stack_malloc_7:
	push	$7
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_7,globl
__asan_stack_malloc_8:
	push	$8
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_8,globl
__asan_stack_malloc_9:
	push	$9
	jmp	OnStackMalloc
	.endfn	__asan_stack_malloc_9,globl
__asan_stack_malloc_10:
	push	$10
//	𝑠𝑙𝑖𝑑𝑒
	.endfn	__asan_stack_malloc_10,globl
OnStackMalloc:
	pop	%rsi
	jmp	__asan_stack_malloc
	.endfn	OnStackMalloc

__asan_version_mismatch_check_v8:
	ret
	.endfn	__asan_version_mismatch_check_v8,globl

//	Initializes Address Sanitizer runtime earlier if linked.
	.init.start 301,_init_asan
	push	%rdi
	push	%rsi
	mov	%r12,%rdi
	mov	%r13,%rsi
	mov	%r14,%rdx
	mov	%r15,%rcx
	call	__asan_init
	pop	%rsi
	pop	%rdi
	.init.end 301,_init_asan

__asan_before_dynamic_init:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_before_dynamic_init,globl

__asan_after_dynamic_init:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_after_dynamic_init,globl

__asan_load1:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_load1,globl
__asan_load2:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_load2,globl
__asan_load4:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_load4,globl
__asan_load8:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_load8,globl
__asan_load16:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_load16,globl
__asan_load32:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_load32,globl

__asan_store1:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_store1,globl
__asan_store2:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_store2,globl
__asan_store4:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_store4,globl
__asan_store8:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_store8,globl
__asan_store16:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_store16,globl
__asan_store32:
	push	%rbp
	mov	%rsp,%rbp
	ud2
	.endfn	__asan_store32,globl
