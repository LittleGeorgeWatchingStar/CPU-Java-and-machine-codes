.pos 0x100

    ld $0, r0           # r0 = 0
    ld $tmp, r1         # r1 = address of tmp
    ld $tos, r2         # r2 = address of tos
    st r0, 0(r1)        # tmp = 0;
    st r0, 0(r2)        # tos = 0;

    ld $a, r6           # r6 = base address of a
    ld $s, r7           # r7 = base address of s
    ld (r6,r0,4), r4    # r4 = a[0]   / testing : a[0] = 3
    st r4,(r7,r0,4)     # s[tos] = a[0] 

    inc r0              # r0 = 1 
    st r0, 0(r2)        # tos++
    ld (r6,r0,4), r4    # r4 = a[1];   / testing : a[1] = 5
    st r4,(r7,r0,4)     # s[tos] = a[1];

    inc r0              # r0 = 2 
    st r0, 0(r2)        # tos++
    ld (r6,r0,4), r4    # r4 = a[2];   / testing : a[1] = 7
    st r4,(r7,r0,4)     # s[tos] = a[2];

    inc r0              # r0 = 3
    dec r0              # r0 = 2 
    st r0, 0(r2)        # tos-- = 2
    ld (r7,r0,4), r5    # r5 = s[tos] = s[2]=7
    st r5,0(r1)         # tmp = s[tos] = 7

    dec r0              # r0 = 1
    st r0, 0(r2)        # tos-- = 1
    ld (r7,r0,4), r5    # r5 = s[tos] = s[1]=5
    ld 0(r1), r3        # r3 = the value of tmp
    add r5,r3           # r3 = tmp + s[tos] = 7 + 5 = 12
    st r3, 0(r1)        # tmp = tmp + s[tos];

    dec r0              # r0 =  0
    st r0, 0(r2)        # tos-- = 0
    ld (r7,r0,4), r5    # r5 = s[tos] = s[0]=3
    add r5,r3           # r3 = tmp + s[tos] = 12 + 3= 15
    st r3, 0(r1)        # tmp = tmp + s[tos] = 15




    halt





.pos 0x2000
# Data area


tmp:  .long 0           # tos
tos:  .long 0           # tmp
a:  .long 0x3           # a[0]
    .long 0x5           # a[1]
    .long 0x7           # a[2]

s:  .long 0             # s[0]
    .long 0             # s[1]
    .long 0             # s[2]
    .long 0             # s[3]
    .long 0             # s[4]
