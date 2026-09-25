.global product
# a in %rdi, b in %rsi, c in %rdx, size in %ecx
product:

    movl $0, %r8d                    # i = 0


.loop:

    # i < size
    cmpl %ecx, %r8d                # compare i to size
    jae .done                      # if i >= size, goto done


    # c[i] = a[i] * b[i]
    movss (%rdi,%r8,4), %xmm0       # %xmm0 = a[i]
    mulss (%rsi,%r8,4), %xmm0        # %xmm0 = a[i] * b[i]
    movss %xmm0, (%rdx,%r8,4)       # c[i] = a[i] * b[i]


    # i++
    incl %r8d           # i = i + 1
    jmp .loop                # goto loop


.done:

    ret                          # return

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
