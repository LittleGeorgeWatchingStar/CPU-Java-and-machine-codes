.pos 0x100
                 ld   $a, r0              # r0 = address of a
                 ld   $b, r1              # r1 = address of b
                 ld   0x0(r0), r2         # r2 = value of a
                 ld   0x0(r1), r3         # r3 = value of b
                 ld   0x0(r1), r5         # r3 = original value of b
                 ld   $0x1, r4            # r4 = 1
                 inc  r3
                 #st   r3, 0x0(r1)

                 ld   $0x4, r4
                 add  r4, r3
                 #st   r3, 0x0(r1)

                 ld   $0xffffffff, r6
                 and  r6, r3

                 shr  $1, r3
                 #st   r3, 0x0(r1)

                 and  r5, r3
                 #st   r3, 0x0(r1)

                 and  r6, r3

                 shl  $2, r3
                 st   r3, 0x0(r0)
                 halt                     # halt
.pos 0x1000
a:                   .long 0x00000000         # a
.pos 0x1004
b:                   .long 0x00000009         # b

