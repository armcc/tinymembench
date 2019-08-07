/*
 * Copyright © 2011 Siarhei Siamashka <siarhei.siamashka@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#ifdef __arm__

.text
.fpu neon
.arch armv7a
.object_arch armv4
.arm
.p2align 2

.macro asm_function function_name
    .global \function_name
\function_name:
    DST         .req r0
    SRC         .req r1
    SIZE        .req r2
.endm

/* Actually this calculates a sum of 32-bit values */
asm_function aligned_block_read_neon
    vmov.u32    q3,  #0
    vmov.u32    q12, #0
    vmov.u32    q13, #0
    vmov.u32    q14, #0
    vmov.u32    q15, #0
    bic         SIZE, SIZE, #127
0:
.rept 2
    vld1.32     {q0, q1}, [SRC]!
    vadd.u32    q15, q15, q3
    vadd.u32    q12, q12, q0
    vld1.32     {q2, q3}, [SRC]!
    vadd.u32    q13, q13, q1
    vadd.u32    q14, q14, q2
.endr
    subs        SIZE, SIZE, #128
    bgt         0b
    vadd.u32    q15, q15, q3
    vadd.u32    q15, q15, q12
    vadd.u32    q15, q15, q13
    vadd.u32    q15, q15, q14
    vadd.u32    d31, d30, d31
    vpadd.u32   d31, d31, d31
    vmov.u32    r0, d31[0]
    bx          lr

/* Actually this calculates a sum of 32-bit values */
asm_function aligned_block_read_pf32_neon
    vmov.u32    q3,  #0
    vmov.u32    q12, #0
    vmov.u32    q13, #0
    vmov.u32    q14, #0
    vmov.u32    q15, #0
    bic         SIZE, SIZE, #127
0:
.rept 2
    vld1.32     {q0, q1}, [SRC]!
    vadd.u32    q15, q15, q3
    pld         [SRC, #512]
    vadd.u32    q12, q12, q0
    vld1.32     {q2, q3}, [SRC]!
    vadd.u32    q13, q13, q1
    pld         [SRC, #512]
    vadd.u32    q14, q14, q2
.endr
    subs        SIZE, SIZE, #128
    bgt         0b
    vadd.u32    q15, q15, q3
    vadd.u32    q15, q15, q12
    vadd.u32    q15, q15, q13
    vadd.u32    q15, q15, q14
    vadd.u32    d31, d30, d31
    vpadd.u32   d31, d31, d31
    vmov.u32    r0, d31[0]
    bx          lr

/* Actually this calculates a sum of 32-bit values */
asm_function aligned_block_read_pf64_neon
    vmov.u32    q3,  #0
    vmov.u32    q12, #0
    vmov.u32    q13, #0
    vmov.u32    q14, #0
    vmov.u32    q15, #0
    bic         SIZE, SIZE, #127
0:
.rept 2
    vld1.32     {q0, q1}, [SRC]!
    vadd.u32    q15, q15, q3
    vadd.u32    q12, q12, q0
    vld1.32     {q2, q3}, [SRC]!
    vadd.u32    q13, q13, q1
    pld         [SRC, #512]
    vadd.u32    q14, q14, q2
.endr
    subs        SIZE, SIZE, #128
    bgt         0b
    vadd.u32    q15, q15, q3
    vadd.u32    q15, q15, q12
    vadd.u32    q15, q15, q13
    vadd.u32    q15, q15, q14
    vadd.u32    d31, d30, d31
    vpadd.u32   d31, d31, d31
    vmov.u32    r0, d31[0]
    bx          lr

/* Actually this calculates a sum of 32-bit values */
asm_function aligned_block_read2_neon
    vmov.u32    q3,  #0
    vmov.u32    q12, #0
    vmov.u32    q13, #0
    vmov.u32    q14, #0
    vmov.u32    q15, #0
    bic         SIZE, SIZE, #127
0:
.rept 2
    vld1.32     {q0, q1}, [SRC]!
    vadd.u32    q15, q15, q3
    vadd.u32    q12, q12, q0
    vld1.32     {q2, q3}, [DST]!
    vadd.u32    q13, q13, q1
    vadd.u32    q14, q14, q2
.endr
    subs        SIZE, SIZE, #128
    bgt         0b
    vadd.u32    q15, q15, q3
    vadd.u32    q15, q15, q12
    vadd.u32    q15, q15, q13
    vadd.u32    q15, q15, q14
    vadd.u32    d31, d30, d31
    vpadd.u32   d31, d31, d31
    vmov.u32    r0, d31[0]
    bx          lr

/* Actually this calculates a sum of 32-bit values */
asm_function aligned_block_read2_pf32_neon
    vmov.u32    q3,  #0
    vmov.u32    q12, #0
    vmov.u32    q13, #0
    vmov.u32    q14, #0
    vmov.u32    q15, #0
    bic         SIZE, SIZE, #127
0:
.rept 2
    vld1.32     {q0, q1}, [SRC]!
    vadd.u32    q15, q15, q3
    pld         [SRC, #512]
    vadd.u32    q12, q12, q0
    vld1.32     {q2, q3}, [DST]!
    vadd.u32    q13, q13, q1
    pld         [DST, #512]
    vadd.u32    q14, q14, q2
.endr
    subs        SIZE, SIZE, #128
    bgt         0b
    vadd.u32    q15, q15, q3
    vadd.u32    q15, q15, q12
    vadd.u32    q15, q15, q13
    vadd.u32    q15, q15, q14
    vadd.u32    d31, d30, d31
    vpadd.u32   d31, d31, d31
    vmov.u32    r0, d31[0]
    bx          lr

/* Actually this calculates a sum of 32-bit values */
asm_function aligned_block_read2_pf64_neon
    vmov.u32    q3,  #0
    vmov.u32    q12, #0
    vmov.u32    q13, #0
    vmov.u32    q14, #0
    vmov.u32    q15, #0
    bic         SIZE, SIZE, #127
0:
.irp PTR, SRC, DST
    vld1.32     {q0, q1}, [\PTR]!
    vadd.u32    q15, q15, q3
    vadd.u32    q12, q12, q0
    vld1.32     {q2, q3}, [\PTR]!
    vadd.u32    q13, q13, q1
    pld         [\PTR, #512]
    vadd.u32    q14, q14, q2
.endr
    subs        SIZE, SIZE, #128
    bgt         0b
    vadd.u32    q15, q15, q3
    vadd.u32    q15, q15, q12
    vadd.u32    q15, q15, q13
    vadd.u32    q15, q15, q14
    vadd.u32    d31, d30, d31
    vpadd.u32   d31, d31, d31
    vmov.u32    r0, d31[0]
    bx          lr

asm_function aligned_block_copy_neon
0:
    vld1.8      {d0, d1, d2, d3}, [SRC]!
    vst1.8      {d0, d1, d2, d3}, [DST, :256]!
    subs        SIZE, SIZE, #32
    bgt         0b
    bx          lr

asm_function aligned_block_copy_unrolled_neon
    vpush       {d8-d15}
    bic         SIZE, SIZE, #127
0:
    vld1.64     {q0, q1}, [SRC]!
    vld1.64     {q2, q3}, [SRC]!
    vld1.64     {q4, q5}, [SRC]!
    vld1.64     {q6, q7}, [SRC]!
    vst1.64     {q0, q1}, [DST, :256]!
    vst1.64     {q2, q3}, [DST, :256]!
    vst1.64     {q4, q5}, [DST, :256]!
    vst1.64     {q6, q7}, [DST, :256]!
    subs        SIZE, SIZE, #128
    bgt         0b
    vpop        {d8-d15}
    bx          lr

asm_function aligned_block_copy_pf32_neon
0:
    pld         [SRC, #256]
    vld1.8      {d0, d1, d2, d3}, [SRC]!
    vst1.8      {d0, d1, d2, d3}, [DST, :256]!
    subs        SIZE, SIZE, #32
    bgt         0b
    bx          lr

asm_function aligned_block_copy_unrolled_pf32_neon
    vpush       {d8-d15}
    bic         SIZE, SIZE, #127
0:
    vld1.64     {q0, q1}, [SRC]!
    pld         [SRC, #256]
    pld         [SRC, #256 + 32]
    vld1.64     {q2, q3}, [SRC]!
    pld         [SRC, #512]
    pld         [SRC, #512 + 32]
    vld1.64     {q4, q5}, [SRC]!
    pld         [SRC, #256]
    pld         [SRC, #256 + 32]
    vld1.64     {q6, q7}, [SRC]!
    pld         [SRC, #512]
    pld         [SRC, #512 + 32]
    vst1.64     {q0, q1}, [DST, :256]!
    vst1.64     {q2, q3}, [DST, :256]!
    vst1.64     {q4, q5}, [DST, :256]!
    vst1.64     {q6, q7}, [DST, :256]!
    subs        SIZE, SIZE, #128
    bgt         0b
    vpop        {d8-d15}
    bx          lr

asm_function aligned_block_copy_pf64_neon
0:
    pld         [SRC, #256]
    vld1.8      {d0, d1, d2, d3}, [SRC]!
    vst1.8      {d0, d1, d2, d3}, [DST, :256]!
    vld1.8      {d0, d1, d2, d3}, [SRC]!
    vst1.8      {d0, d1, d2, d3}, [DST, :256]!
    subs        SIZE, SIZE, #64
    bgt         0b
    bx          lr

asm_function aligned_block_copy_unrolled_pf64_neon
    vpush       {d8-d15}
    bic         SIZE, SIZE, #127
0:
    vld1.64     {q0, q1}, [SRC]!
    pld         [SRC, #256]
    vld1.64     {q2, q3}, [SRC]!
    pld         [SRC, #512]
    vld1.64     {q4, q5}, [SRC]!
    pld         [SRC, #256]
    vld1.64     {q6, q7}, [SRC]!
    pld         [SRC, #512]
    vst1.64     {q0, q1}, [DST, :256]!
    vst1.64     {q2, q3}, [DST, :256]!
    vst1.64     {q4, q5}, [DST, :256]!
    vst1.64     {q6, q7}, [DST, :256]!
    subs        SIZE, SIZE, #128
    bgt         0b
    vpop        {d8-d15}
    bx          lr

asm_function aligned_block_copy_backwards_neon
    add         SRC, SRC, SIZE
    add         DST, DST, SIZE
    sub         SRC, SRC, #32
    sub         DST, DST, #32
    mov         r3, #-32
0:
    vld1.8      {d0, d1, d2, d3}, [SRC], r3
    vst1.8      {d0, d1, d2, d3}, [DST, :256], r3
    subs        SIZE, SIZE, #32
    bgt         0b
    bx          lr

asm_function aligned_block_copy_backwards_pf32_neon
    add         SRC, SRC, SIZE
    add         DST, DST, SIZE
    sub         SRC, SRC, #32
    sub         DST, DST, #32
    mov         r3, #-32
0:
    pld         [SRC, #-256]
    vld1.8      {d0, d1, d2, d3}, [SRC], r3
    vst1.8      {d0, d1, d2, d3}, [DST, :256], r3
    subs        SIZE, SIZE, #32
    bgt         0b
    bx          lr

asm_function aligned_block_copy_backwards_pf64_neon
    add         SRC, SRC, SIZE
    add         DST, DST, SIZE
    sub         SRC, SRC, #32
    sub         DST, DST, #32
    mov         r3, #-32
0:
    pld         [SRC, #-256]
    vld1.8      {d0, d1, d2, d3}, [SRC], r3
    vst1.8      {d0, d1, d2, d3}, [DST, :256], r3
    vld1.8      {d0, d1, d2, d3}, [SRC], r3
    vst1.8      {d0, d1, d2, d3}, [DST, :256], r3
    subs        SIZE, SIZE, #64
    bgt         0b
    bx          lr

asm_function aligned_block_fill_neon
    vld1.8      {d0, d1, d2, d3}, [SRC]!
0:
    vst1.8      {d0, d1, d2, d3}, [DST, :256]!
    vst1.8      {d0, d1, d2, d3}, [DST, :256]!
    subs        SIZE, SIZE, #64
    bgt         0b
    bx          lr

asm_function aligned_block_fill_backwards_neon
    add         SRC, SRC, SIZE
    add         DST, DST, SIZE
    sub         SRC, SRC, #32
    sub         DST, DST, #32
    mov         r3, #-32
0:
    vst1.8      {d0, d1, d2, d3}, [DST, :256], r3
    subs        SIZE, SIZE, #32
    bgt         0b
    bx          lr

/* some code for older ARM processors */

asm_function aligned_block_fill_stm2_armv4
    push        {r4-r12, lr}
    ldmia       SRC!, {r4-r11}
0:
    stmia       DST!, {r4-r5}
    stmia       DST!, {r4-r5}
    stmia       DST!, {r4-r5}
    stmia       DST!, {r4-r5}
    stmia       DST!, {r4-r5}
    stmia       DST!, {r4-r5}
    stmia       DST!, {r4-r5}
    stmia       DST!, {r4-r5}
    subs        SIZE, SIZE, #64
    bgt         0b
    pop         {r4-r12, pc}

asm_function aligned_block_fill_stm4_armv4
    push        {r4-r12, lr}
    ldmia       SRC!, {r4-r11}
0:
    stmia       DST!, {r4-r7}
    stmia       DST!, {r4-r7}
    stmia       DST!, {r4-r7}
    stmia       DST!, {r4-r7}
    subs        SIZE, SIZE, #64
    bgt         0b
    pop         {r4-r12, pc}

asm_function aligned_block_fill_stm8_armv4
    push        {r4-r12, lr}
    ldmia       SRC!, {r4-r11}
0:
    stmia       DST!, {r4-r11}
    stmia       DST!, {r4-r11}
    subs        SIZE, SIZE, #64
    bgt         0b
    pop         {r4-r12, pc}

asm_function aligned_block_fill_strd_armv5te
    push        {r4-r12, lr}
    ldmia       SRC!, {r4-r11}
0:
    strd        r4,  r5,  [DST], #8
    strd        r4,  r5,  [DST], #8
    strd        r4,  r5,  [DST], #8
    strd        r4,  r5,  [DST], #8
    strd        r4,  r5,  [DST], #8
    strd        r4,  r5,  [DST], #8
    strd        r4,  r5,  [DST], #8
    strd        r4,  r5,  [DST], #8
    subs        SIZE, SIZE, #64
    bgt         0b
    pop         {r4-r12, pc}

asm_function aligned_block_copy_incr_armv5te
    push        {r4-r12, lr}
0:
    subs        SIZE, SIZE, #64
    ldmia       SRC!, {r4-r11}
    pld         [SRC, #256]
    stmia       DST!, {r4-r7}
    stmia       DST!, {r8-r11}
    ldmia       SRC!, {r4-r11}
    pld         [SRC, #256]
    stmia       DST!, {r4-r7}
    stmia       DST!, {r8-r11}
    bgt         0b
    pop         {r4-r12, pc}

asm_function aligned_block_copy_wrap_armv5te
    push        {r4-r12, lr}
0:
    subs        SIZE, SIZE, #64
    ldmia       SRC!, {r4-r11}
    pld         [SRC, #(256 - 4)]
    stmia       DST!, {r4-r7}
    stmia       DST!, {r8-r11}
    ldmia       SRC!, {r4-r11}
    pld         [SRC, #(256 - 4)]
    stmia       DST!, {r4-r7}
    stmia       DST!, {r8-r11}
    bgt         0b
    pop         {r4-r12, pc}

asm_function aligned_block_copy_vfp
    push        {r4-r12, lr}
    vpush       {d8-d15}
0:
    subs        SIZE, SIZE, #128
    vldm        SRC!, {d0-d15}
    vstm        DST!, {d0-d15}
    bgt         0b
    vpop        {d8-d15}
    pop         {r4-r12, pc}

/****************************************************************************/
/****************************************************************************/

	.syntax unified

	.global memset_glibc_stm2
	.type memset_glibc_stm2,%function

memset_glibc_stm2:

        mov     r3, r0
        cmp     r2, #8
        bcc     2f	       @ less than 8 bytes to move

1:
        tst     r3, #3	       @ aligned yet?
        strbne  r1, [r3], #1
        subne   r2, r2, #1
        bne     1b

        and     r1, r1, #255    @ clear any sign bits
        orr     r1, r1, r1, lsl $8
        orr     r1, r1, r1, lsl $16
        mov     ip, r1

1:
        subs    r2, r2, #8
        stmiacs r3!, {r1, ip}   @ store up to 32 bytes per loop iteration
        subscs  r2, r2, #8
        stmiacs r3!, {r1, ip}
        subscs  r2, r2, #8
        stmiacs r3!, {r1, ip}
        subscs  r2, r2, #8
        stmiacs r3!, {r1, ip}
        bcs     1b

        and     r2, r2, #7
2:
        subs    r2, r2, #1      @ store up to 4 bytes per loop iteration
        strbcs  r1, [r3], #1
        subscs  r2, r2, #1
        strbcs  r1, [r3], #1
        subscs  r2, r2, #1
        strbcs  r1, [r3], #1
        subscs  r2, r2, #1
        strbcs  r1, [r3], #1
        bcs     2b

        bx      lr

/****************************************************************************/
/****************************************************************************/

	.global memset_glibc_stm3
	.type memset_glibc_stm3,%function

memset_glibc_stm3:

	cmp	r2, #12
	mov	r3, r0
	bcc	2f		@ less than 12 bytes to set
	push	{ r4 }
	and	r1, r1, #255	@ clear any sign bits

1:	tst	r3, #3		@ aligned yet?
	strbne	r1, [r3], #1
	subne	r2, r2, #1
	bne	1b
	orr	r1, r1, r1, lsl #8
	orr	r1, r1, r1, lsl #16
	mov	r4, r1
	mov	ip, r1

1:	subs	r2, r2, #12
	stmiacs	r3!, {r1, r4, ip}
	subscs	r2, r2, #12
	stmiacs	r3!, {r1, r4, ip}
	bcs	1b
	add	r2, r2, #12
	pop	{ r4 }

2:	subs	r2, r2, #1
	strbcs	r1, [r3], #1
	subscs	r2, r2, #1
	strbcs	r1, [r3], #1
	bcs	2b

	bx	lr

/****************************************************************************/
/****************************************************************************/

	.global memset_glibc_stm4
	.type memset_glibc_stm4,%function

memset_glibc_stm4:

	cmp	r2, #16
	mov	r3, r0
	bcc	2f		@ less than 16 bytes to set
	push	{ r4, r5 }
	and	r1, r1, #255	@ clear any sign bits

1:	tst	r3, #3		@ aligned yet?
	strbne	r1, [r3], #1
	subne	r2, r2, #1
	bne	1b
	orr	r1, r1, r1, lsl #8
	orr	r1, r1, r1, lsl #16
	mov	r4, r1
	mov	r5, r1
	mov	ip, r1

1:	subs	r2, r2, #16
	stmiacs	r3!, {r1, r4, r5, ip}
	subscs	r2, r2, #16
	stmiacs	r3!, {r1, r4, r5, ip}
	bcs	1b
	add	r2, r2, #16
	pop	{ r4, r5 }

2:	subs	r2, r2, #1
	strbcs	r1, [r3], #1
	subscs	r2, r2, #1
	strbcs	r1, [r3], #1
	bcs	2b

	bx	lr

/****************************************************************************/
/****************************************************************************/

	.global memset_uclibc_stm2
	.type memset_uclibc_stm2,%function

memset_uclibc_stm2:

	mov	r3, r0
	cmp	r2, #8		@ at least 8 bytes to do?
	bcc	2f

	and	r1, r1, #255	@ clear any sign bits
	orr	r1, r1, r1, lsl #8
	orr	r1, r1, r1, lsl #16

1:	tst	r3, #3		@ aligned yet?
	strbne	r1, [r3], $1
	subne	r2, r2, $1
	bne	1b

	mov	ip, r1

1:	cmp	r2, $8		@ 8 bytes still to do?
	bcc	2f
	stmia	r3!, {r1, ip}
	sub	r2, r2, $8
	cmp	r2, $8		@ 8 bytes still to do?
	bcc	2f
	stmia	r3!, {r1, ip}
	sub	r2, r2, $8
	cmp	r2, $8		@ 8 bytes still to do?
	bcc	2f
	stmia	r3!, {r1, ip}
	sub	r2, r2, $8
	cmp	r2, $8		@ 8 bytes still to do?

	stmiacs	r3!, {r1, ip}
	subcs	r2, r2, $8
	bcs	1b

2:	movs	r2, r2		@ anything left?

	bxeq	lr		@ nope

	rsb	r2, r2, $7
	add	pc, pc, r2, lsl $2
	nop
	strb	r1, [r3], $1
	strb	r1, [r3], $1
	strb	r1, [r3], $1
	strb	r1, [r3], $1
	strb	r1, [r3], $1
	strb	r1, [r3], $1
	strb	r1, [r3], $1

	bx	lr

/****************************************************************************/
/****************************************************************************/

	.global memset_bionic_stm8
	.type memset_bionic_stm8,%function

memset_bionic_stm8:

        /* compute the offset to align the destination
         * offset = (4-(src&3))&3 = -src & 3
         */

        stmfd       sp!, {r0, r4-r7, lr}
        rsb         r3, r0, #0
        ands        r3, r3, #3
        cmp         r3, r2
        movhi       r3, r2

        /* splat r1 */
        mov         r1, r1, lsl #24
        orr         r1, r1, r1, lsr #8
        orr         r1, r1, r1, lsr #16

        movs        r12, r3, lsl #31
        strbcs      r1, [r0], #1    /* can't use strh (alignment unknown) */
        strbcs      r1, [r0], #1
        strbmi      r1, [r0], #1
        subs        r2, r2, r3
        ldmfdls     sp!, {r0, r4-r7, pc}   /* return */

        /* align the destination to a cache-line */
        mov         r12, r1
        mov         lr, r1
        mov         r4, r1
        mov         r5, r1
        mov         r6, r1
        mov         r7, r1

        rsb         r3, r0, #0
        ands        r3, r3, #0x1C
        beq         3f
        cmp         r3, r2
        andhi       r3, r2, #0x1C
        sub         r2, r2, r3

        /* conditionally writes 0 to 7 words (length in r3) */
        movs        r3, r3, lsl #28
        stmiacs     r0!, {r1, lr}
        stmiacs     r0!, {r1, lr}
        stmiami     r0!, {r1, lr}
        movs        r3, r3, lsl #2
        strcs       r1, [r0], #4

3:
        subs        r2, r2, #32
        mov         r3, r1
        bmi         2f
1:      subs        r2, r2, #32
        stmia       r0!, {r1,r3,r4,r5,r6,r7,r12,lr}
        bhs         1b
2:      add         r2, r2, #32

        /* conditionally stores 0 to 31 bytes */
        movs        r2, r2, lsl #28
        stmiacs     r0!, {r1,r3,r12,lr}
        stmiami     r0!, {r1, lr}
        movs        r2, r2, lsl #2
        strcs       r1, [r0], #4
        strhmi      r1, [r0], #2
        movs        r2, r2, lsl #2
        strbcs      r1, [r0]
        ldmfd       sp!, {r0, r4-r7, pc}

/****************************************************************************/
/****************************************************************************/

	.global memset_lgi_stm4
	.type memset_lgi_stm4,%function

memset_lgi_stm4:

	push		{ r0, lr }

	and		r1, r1, #255
	orr		r1, r1, r1, lsl #8
	orr		r1, r1, r1, lsl #16
	mov		lr, r1

	cmp		r2, #15 		@ Can we safely write max possible alignment bytes?
	bcc		9f			@ if not, ie if (count < 15), then skip pre-alignment etc

	rsb		r3, r0, #0
	and		r3, r3, #15		@ r3 = alignment bytes

	lsls		r12, r3, #31
	strbmi		r1, [r0], #1
	strhcs		r1, [r0], #2
	lsls		r12, r3, #29
	strmi		r1, [r0], #4
	stmiacs 	r0!, { r1, lr }

	sub		r2, r2, r3		@ count -= alignment bytes

	mov		r3, r1
	mov		r12, r1

2:	subs		r2, r2, #16
	stmiacs 	r0!, { r1, r3, r12, lr }
	bcs		2b

	b		3f

6:	subs		r2, r2, #1
	bcc		5f
	strb		r1, [r0], #1
9:	tst		r0, #3
	bne		6b

3:	lsls		r2, r2, #29		@ upto 15 bytes remaining, dst is aligned
	stmiacs 	r0!, { r1, lr }
	strmi		r1, [r0], #4
	lsls		r2, r2, #2
	strhcs		r1, [r0], #2
	strbmi		r1, [r0]

5:	pop		{ r0, pc }

/****************************************************************************/
/****************************************************************************/

	.global memset_lgi_stm8
	.type memset_lgi_stm8,%function

memset_lgi_stm8:

	push		{ r0, lr }

	and		r1, r1, #255
	orr		r1, r1, r1, lsl #8
	orr		r1, r1, r1, lsl #16
	mov		lr, r1

	cmp		r2, #31 		@ Can we safely write max possible alignment bytes?
	bcc		9f			@ if not, ie if (count < 31), then skip prealignment etc

	rsb		r3, r0, #0
	and		r3, r3, #31		@ r3 = alignment bytes

	lsls		r12, r3, #31
	strbmi		r1, [r0], #1
	strhcs		r1, [r0], #2

	lsls		r12, r3, #29
	strmi		r1, [r0], #4
	stmiacs 	r0!, { r1, lr }

	push		{ r4, r5, r6, r7 }
	mov		r4, r1
	mov		r5, r1

	tst		r3, #16
	stmiane 	r0!, { r1, r4, r5, lr }

	sub		r2, r2, r3		@ count -= alignment bytes

	mov		r3, r1
	mov		r6, r1
	mov		r7, r1
	mov		r12, r1

2:	subs		r2, r2, #32
	stmiacs 	r0!, { r1, r3, r4, r5, r6, r7, r12, lr }
	bcs		2b

	pop		{ r4, r5, r6, r7 }

3:	tst		r2, #16 		@ upto 31 bytes remaining, dst is aligned
	stmiane 	r0!, { r1, r3, r12, lr }
	lsls		r2, r2, #29
	stmiacs 	r0!, { r1, r3 }
	strmi		r1, [r0], #4
	lsls		r2, r2, #2
	strhcs		r1, [r0], #2
	strbmi		r1, [r0]

5:	pop		{ r0, lr }
	bx		lr

6:	subs		r2, r2, #1
	bcc		5b
	strb		r1, [r0], #1
9:	tst		r0, #3
	bne		6b

4:	mov		r3, r1
	mov		r12, r1
	b		3b

/****************************************************************************/
/****************************************************************************/

	.global memset_raspbian_stm4
	.type memset_raspbian_stm4,%function

memset_raspbian_stm4:

	and     r1, r1, #255
	push    {r0, lr}
	orr     r1, r1, r1, lsl #8
	orr     r1, r1, r1, lsl #16
	mov     r3, r1

	cmp     r2, #31
	bcc     2f

	sub     r2, r2, #16
	tst     r0, #15
	beq     1f

	rsb     lr, r0, #0

	lsls    r12, lr, #31
	submi   r2, r2, #1
	strbmi  r1, [r0], #1
	subcs   r2, r2, #2
	strhcs  r1, [r0], #2

	lsls    r12, lr, #29
	submi   r2, r2, #4
	strmi   r1, [r0], #4
	subcs   r2, r2, #8
	stmiacs r0!, {r1, r3}

1:	mov	r12, r1
	mov	lr, r1

3:	stmia	r0!, {r1, r3, r12, lr}
	subs    r2, r2, #16
	bcs     3b

7:	lsls    r2, r2, #29
	stmiacs r0!, {r1, r3}
	strmi   r1, [r0], #4
	lsls    r2, r2, #2
	strhcs  r1, [r0], #2
	strbmi  r1, [r0]
5:	pop     {r0, pc}


6:	subs    r2, r2, #1
	bcc     5b
	strb    r1, [r0], #1
2:	tst     r0, #3
	bne     6b

4:	mov     r12, r1
	mov     lr, r1

	tst     r2, #16
	stmiane r0!, {r1, r3, r12, lr}
	b	   7b

/****************************************************************************/
/****************************************************************************/

/*
   The default version (ie when CALGN is not defined) uses stm with 4 registers
*/

	.global memset_linuxkernel_stm4
	.type memset_linuxkernel_stm4,%function

memset_linuxkernel_stm4:

	ands	r3, r0, #3		@ 1 unaligned?
	mov	ip, r0			@ preserve r0 as return value
	bne	6f			@ 1
/*
 * we know that the pointer in ip is aligned to a word boundary.
 */
1:	and	r1, r1, #255
	orr	r1, r1, r1, lsl #8
	orr	r1, r1, r1, lsl #16
	mov	r3, r1
7:	cmp	r2, #16
	blt	4f

/*
 * We need 2 extra registers for this loop - use r8 and the LR
 */
	stmfd	sp!, {r8, lr}
	mov	r8, r1
	mov	lr, r3

2:	subs	r2, r2, #64
	stmiage	ip!, {r1, r3, r8, lr}	@ 64 bytes at a time.
	stmiage	ip!, {r1, r3, r8, lr}
	stmiage	ip!, {r1, r3, r8, lr}
	stmiage	ip!, {r1, r3, r8, lr}
	bgt	2b
	ldmfdeq	sp!, {r8, pc}		@ Now <64 bytes to go.
/*
 * No need to correct the count; we're only testing bits from now on
 */
	tst	r2, #32
	stmiane	ip!, {r1, r3, r8, lr}
	stmiane	ip!, {r1, r3, r8, lr}
	tst	r2, #16
	stmiane	ip!, {r1, r3, r8, lr}
	ldmfd	sp!, {r8, lr}

4:	tst	r2, #8
	stmiane	ip!, {r1, r3}
	tst	r2, #4
	strne	r1, [ip], #4
/*
 * When we get here, we've got less than 4 bytes to set.  We
 * may have an unaligned pointer as well.
 */
5:	tst	r2, #2
	strbne	r1, [ip], #1
	strbne	r1, [ip], #1
	tst	r2, #1
	strbne	r1, [ip], #1
	bx	lr

6:	subs	r2, r2, #4		@ 1 do we have enough
	blt	5b			@ 1 bytes to align with?
	cmp	r3, #2			@ 1
	strblt	r1, [ip], #1		@ 1
	strble	r1, [ip], #1		@ 1
	strb	r1, [ip], #1		@ 1
	add	r2, r2, r3		@ 1 (r2 = r2 - (4 - r3))
	b	1b


/****************************************************************************/
/****************************************************************************/

/*
   If CALGN is defined (it usually isn't) memset uses stm with 8 registers
*/

	.global memset_linuxkernel_stm8
	.type memset_linuxkernel_stm8,%function

memset_linuxkernel_stm8:

	ands	r3, r0, #3		@ 1 unaligned?
	mov	ip, r0			@ preserve r0 as return value
	bne	6f			@ 1
/*
 * we know that the pointer in ip is aligned to a word boundary.
 */
1:	and	r1, r1, #255
	orr	r1, r1, r1, lsl #8
	orr	r1, r1, r1, lsl #16
	mov	r3, r1
7:	cmp	r2, #16
	blt	4f

/*
 * This version aligns the destination pointer in order to write
 * whole cache lines at once.
 */

	stmfd	sp!, {r4-r8, lr}
	mov	r4, r1
	mov	r5, r3
	mov	r6, r1
	mov	r7, r3
	mov	r8, r1
	mov	lr, r3

	cmp	r2, #96
	tstgt	ip, #31
	ble	3f

	and	r8, ip, #31
	rsb	r8, r8, #32
	sub	r2, r2, r8
	movs	r8, r8, lsl #(32 - 4)
	stmiacs	ip!, {r4, r5, r6, r7}
	stmiami	ip!, {r4, r5}
	tst	r8, #(1 << 30)
	mov	r8, r1
	strne	r1, [ip], #4

3:	subs	r2, r2, #64
	stmiage	ip!, {r1, r3-r8, lr}
	stmiage	ip!, {r1, r3-r8, lr}
	bgt	3b
	ldmfdeq	sp!, {r4-r8, pc}

	tst	r2, #32
	stmiane	ip!, {r1, r3-r8, lr}
	tst	r2, #16
	stmiane	ip!, {r4-r7}
	ldmfd	sp!, {r4-r8, lr}

4:	tst	r2, #8
	stmiane	ip!, {r1, r3}
	tst	r2, #4
	strne	r1, [ip], #4
/*
 * When we get here, we've got less than 4 bytes to set.  We
 * may have an unaligned pointer as well.
 */
5:	tst	r2, #2
	strbne	r1, [ip], #1
	strbne	r1, [ip], #1
	tst	r2, #1
	strbne	r1, [ip], #1
	bx	lr

6:	subs	r2, r2, #4		@ 1 do we have enough
	blt	5b			@ 1 bytes to align with?
	cmp	r3, #2			@ 1
	strblt	r1, [ip], #1		@ 1
	strble	r1, [ip], #1		@ 1
	strb	r1, [ip], #1		@ 1
	add	r2, r2, r3		@ 1 (r2 = r2 - (4 - r3))
	b	1b


/****************************************************************************/
/****************************************************************************/

#endif
