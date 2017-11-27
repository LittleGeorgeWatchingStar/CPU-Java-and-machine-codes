.pos 0x1000
code:
    # STATEMENT v0 = s.x[i]
    ld $i, r0           # r0 = address of i
    ld 0(r0), r1        # r1 = i
    ld $s_x, r2         # r2 = address of s.x[0]
    ld (r2, r1, 4), r3  # r3 = s.x[i]
    ld $v0, r4          # r4 = address of v0
    st r3, 0(r4)        # v0 = s.x[i]

    # STATEMENT v1 = s.y[i]
    ld $s_ptry, r2      # r2 = address of s.ypointer
    ld 0(r2), r3        # r3 = value of s.ypointer, which is the address of an array it points to
    ld (r3, r1, 4), r4  # r4 = s.y[i]
    ld $v1, r5          # r4 = address of v0
    st r4, 0(r5)        # v0 = s.x[i]

    # STATEMENT v2 = s.z->x[i]


    halt

.pos 0x2000
static:
i:          .long 1             # i
v0:         .long 0             # v0
v1:         .long 0             # v1
v2:         .long 0             # v2
v3:         .long 0             # v3
s:          .long 0             # s
s_x:        .long 1             # s.x[0]
            .long 2             # s.x[1]
s_ptry:     .long 0             # s.ypointer
s_ptrz:     .long 0             # s.zpointer




.pos 0x3000
heap:
s_y:        .long 3             # s.y[0]
            .long 4             # s.y[1]
s_z:        .long 0             # s.z->x[0]
            .long 0             # s.z->x[1]
            .long 0             # s.z->y
            .long third_s       # s.z->z
#s_z_z:      .long 0             # value of s.z->z, which is the address of third struct


third_s:    .long 0             # s.z->z->x[0]
            .long 0             # s.z->z->x[1]
            .long s.z->z->y     # s.z->z.y
            .long 0             # s.z->z.z
s.z->z->y:  .long 0             # s.z->z->y[0]
            .long 0             # s.z->z->y[1]




