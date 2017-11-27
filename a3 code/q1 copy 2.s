.pos 0x100

    # STATEMENT i  = a[3]; i  = a[i];
    # Retrieve i
    ld $i, r0           # r0 = address of i

    # Compute i  = a[3];
    ld $a, r2           # r2 = address of a
    ld 0xc(r2), r3      # r3 = a[3]
    st r3, 0(r0)        # i = a[3]

    ld 0(r0), r1        # r1 = i
    # Compute i  = a[i];
    ld (r2,r1,4), r3    # r3 = a[i]
    st r3, 0(r0)        # i = a[i]

    # Compute p  = &j;
    ld $j, r0           # r0 = address of j
    ld $p, r4           # r4 = address of p
    st r0, 0(r4)        # p = &j


    # Compute *p = 4;
    ld $4, r6           # r6 = 4

    ld 0(r4), r7        # r7 = address of j

    st r6, 0(r7)        # *p = 4
                        # j = 4

    # STATEMENT p  = &a[a[2]];
    # Compute a[2];
    ld 0x8(r2), r3      # r3 = a[2]


    shl $2, r3          # r3 = r3*4 (representing length)

    ld $a, r7           # r7 = address of a
    add r3, r7          # r3 = address of a + r3
    st r7, 0(r4)        # p = r4


    # Compute *p = *p + a[4];
    ld $4, r1
    ld (r2, r1, 4), r6  # r6 = a[4]

    shr $2, r3          # r3 = how many elements from a[0]


    ld (r2,r3,4), r1    # r1 = value of a[a[2]]
    add r6, r1          # *p = *p + r3
                        # p = &a[a[2]] and r1 is actually a[a[2]]'s value now



    st r1, (r2,r3,4)    # a[a[2]] = a[a[2]] + a[4]


    halt

.pos 0x200
# Data area
#int  i,j;
#int* p;
#int  a[10];

a:  .long 1             # a[0]
    .long 2             # a[1]
    .long 3             # a[2]
    .long 4             # a[3]
    .long 5             # a[4]
    .long 6             # a[5]
    .long 7             # a[6]
    .long 8             # a[7]
    .long 9             # a[8]
    .long 10            # a[9]
i:  .long 0             # i
j:  .long 0             # j
p:  .long 0             # p
