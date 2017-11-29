## This is the solution to CPSC 213 Assignment 3
## Do not distribute this to anyone in any way.
## Do not remove this comment.

## Code - TODO: Comment and translated to C in q1()
.pos 0x1000

## C statement 1
S1:
ld    $i, r0            # r0 = address of i (&i)
ld    (r0), r0          # r0 = value of i
ld    $a, r1            # r1 = address of pointer a
ld    (r1), r1          # r1 = value of a[0] (pointer to d1)
ld    (r1), r1          # r1 = value of d1
ld    (r1, r0, 4), r2   # r2 = d1 + r0 = d1[i]
ld    $v0, r3           # r3 = address of v0
st    r2, (r3)          # v0 = d0[i]

## C statement 2
S2:
ld    $i, r0            # r0 = address of i
ld    (r0), r0          # r0 = value of i
ld    $a, r1            # r1 = address of pointer a
ld    (r1), r1          # r1 = value of a
inca  r1                # r1 = a + 4 = address of a->b
ld    (r1, r0, 4), r2   # r2 = r1 + r0*4
ld    $v1, r3           # r3 = address of v1
st    r2, (r3)          # v1 = r1 + r0*4

## C statement 3
S3:
ld    $i, r0            # r0 = address of i
ld    (r0), r0          # r0 = value of i
ld    $a, r1            # r1 = address of pointer a
ld    (r1), r1          # r1 = value of a
ld    20(r1), r1        # r1 = d0[5] (and goes to d2[0])
ld    (r1), r1          # r1 = d2[0] (and goes to d3[0])
ld    (r1, r0, 4), r2   # r2 = r1 + r0*4
ld    $v2, r3           # r3 = address of v2
st    r2, (r3)          # v2 = r1 + r0*4

## C statement 4
S4:
ld    $a, r1            # r1 = address of pointer a
ld    (r1), r1          # r1 = value of a
st    r1, 20(r1)        # d0[5] = a

## C statement 5
S5:
ld    $i, r0            # r0 = address of i
ld    (r0), r0          # r0 = value of i
ld    $a, r1            # r1 = address of pointer a
ld    (r1), r1          # r1 = value of a
ld    20(r1), r1        # r1 = d0[5] = address of d2  d2
inca  r1                # r1 = d
ld    (r1, r0, 4), r2   #
ld    $v3, r3           #
st    r2, (r3)          #


halt


## Globals
.pos 0x2000
i:  .long 0
v0: .long 0
v1: .long 0
v2: .long 0
v3: .long 0
a:  .long d0


## Heap (these labels represent dynamic values and are thus not available to code)
.pos 0x3000
d0: .long d1
    .long 20
    .long 21
    .long 22
    .long 23
    .long d2
d2: .long d3
    .long 0
    .long 40
    .long 41
    .long 42
    .long 43
d1: .long 10
    .long 11
    .long 12
    .long 13
d3: .long 30
    .long 31
    .long 32
    .long 33
