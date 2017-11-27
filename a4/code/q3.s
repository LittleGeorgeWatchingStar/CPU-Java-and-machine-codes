.pos 0x1000
# code:

# Line One: Compute v0 = s.x[i];
  ld   $v0, r0             # r0 = & v0
  ld   $i,r1               # r1 = & i
  ld   0(r1),r2            # r1 = the value of i, which is 1
  ld   $s,r4               # r4 = the base address of s 
  ld   (r4,r2,4), r3       # r3 = the value of s.x[1] = 3
  st   r3,0(r0)            # v0 = s.x[i] = 3


# Line two : Compute v1 = s.y[i];
  ld   $v1, r0             # r0 = & v1
  ld   0x8(r4),r3          # r3 = the value of y, the address of y[0]
  ld   (r3,r2,4),r5        # r5 = the value of s.y[i] =  5
  st   r5,0(r0)            # v1 = s.y[i];

# Line three : Compute v2 = s.z->x[i];
  ld   $v2, r0             # r0 = & v2
  ld   0xc(r4),r3          # r3 = the value of z, the address of s.z->x[0]
  ld   (r3,r2,4),r5        # r5 = the value of s.z->x[i] = 7
  st   r5,0(r0)            # v1 = v2 = s.z->x[i];

# Line three : Compute v3 = s.z->z->y[i];
  ld   $v3, r0             # r0 = & v3
  ld   0xc(r3),r5          # r5 = the value of  s.z->z = the address of s.z->z->x[0]
  ld   0x8(r5),r6          # r6 = the value of  s.z->z ->y = the address of s.z->z->y[0]
  ld   (r6,r2,4),r7        # r7 = the value of s.z->z->y[i] = 9
  st   r7,0(r0)            # v3 = s.z->z->y[i];





  



   halt                     














.pos 0x2000
# Static:



i:               .long 0x00000001         # i
v0:              .long 0x00000000         # v0
v1:              .long 0x00000000         # v1
v2:              .long 0x00000000         # v2
v3:              .long 0x00000000         # v3
s:               .long 0x00000000         # s.x[0]
                 .long 0x00000003         # s.x[1]
                 .long s_y                # s_y
                 .long s_z                # s_z

# heap: 
.pos 0x3000
s_y:             .long 0x00000000         # s.y[0]    
                 .long 0x00000005         # s.y[1]   

s_z   :          .long 0x00000000         # s.z -> x[0]
                 .long 0x00000007         # s.z -> x[1]
                 .long 0x00000000         # s.z -> y
                 .long s_z_z              # s.z -> z

s_z_z:           .long 0x00000000         # s.z -> z-> x[0]
                 .long 0x00000000         # s.z -> z-> x[1]
                 .long s_z_z_y            # s.z -> z-> y
                 .long 0x00000000         # s.z -> z-> z

s_z_z_y:         .long 0x00000000         # s.z -> z-> z-> y[0]    
                 .long 0x00000009         # s.z -> z-> z-> y[1]                 

                


