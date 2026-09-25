.global area
# a in %edi, b in %esi, c in %edx; result in %eax
area:

    # int p = (a + b + c) / 2
    movl %edi, %eax               # %eax = a
    addl %esi, %eax               # %eax = a + b
    addl %edx, %eax               # %eax = a + b + c
    sarl $1, %eax                 # %eax = (a + b + c) / 2
    movl %eax, %r8d               # %r8d = p


    # p = p * (p-a) * (p-b) * (p-c)

    movl %r8d, %eax               # %eax = p

    movl %r8d, %r9d               # %r9d = p
    subl %edi, %r9d               # %r9d = p - a
    imull %r9d, %eax              # %eax = p * (p-a)

    movl %r8d, %r9d               # %r9d = p
    subl %esi, %r9d               # %r9d = p - b
    imull %r9d, %eax              # %eax = p * (p-a) * (p-b)

    movl %r8d, %r9d               # %r9d = p
    subl %edx, %r9d               # %r9d = p - c
    imull %r9d, %eax              # %eax = p * (p-a) * (p-b) * (p-c)


    # return r_sqrt(p)
    movl %eax, %edi               # first argument = p
    call r_sqrt                   # %eax = r_sqrt(p)
    retq                          # return result



# int r_sqrt(int x)
# x in %edi
# result in %eax

r_sqrt:

    # if (x < 0)
    cmpl $0, %edi                 # compare x to 0
    jl .sqrt_negative             # if x < 0, goto sqrt_negative


    # if (x < 2)
    cmpl $2, %edi                 # compare x to 2
    jl .sqrt_small                # if x < 2, goto sqrt_small


    # We need x again after recursive call, so save it
    pushq %rdi                    # save x on stack


    # int small_cand = r_sqrt(x >> 2) << 1
    sarl $2, %edi                 # %edi = x >> 2
    call r_sqrt                   # %eax = r_sqrt(x >> 2)
    sall $1, %eax                 # %eax = r_sqrt(x >> 2) << 1

    popq %rdi                     # restore original x

    movl %eax, %r8d               # %r8d = small_cand


    # int large_cand = small_cand + 1
    movl %r8d, %r9d               # %r9d = small_cand
    addl $1, %r9d                 # %r9d = large_cand


    # if (large_cand * large_cand > x)
    movl %r9d, %eax              # %eax = large_cand
    imull %r9d, %eax            # %eax = large_cand * large_cand

    cmpl %edi, %eax            # compare large_cand² to x
    jg .return_small           # if large_cand² > x, goto return_small


    # else return large_cand
    movl %r9d, %eax            # %eax = large_cand
    retq                       # return large_cand


.return_small:

    movl %r8d, %eax               # %eax = small_cand
    retq                          # return small_cand


.sqrt_negative:

    movl $-1, %eax               # %eax = -1
    retq                        # return -1


.sqrt_small:

    movl %edi, %eax            # %eax = x
    retq                       # return x


# int area(int a, int b, int c){
#     int p = (a + b + c)/2;
#     p = p * (p-a) * (p-b) * (p-c);
#     return sqrt(p);
# }
# calculate recursively the square root of an int (in C)
# int r_sqrt(int x){
#    if(x < 0)
#        return -1;
#    if (x < 2)
#        return x;
#   /* recursive call */
#    int small_cand = r_sqrt(x >> 2) << 1;
#    int large_cand = small_cand + 1;
#    if (large_cand * large_cand > x)
#        return small_cand;
#    else
#        return large_cand;
# }
