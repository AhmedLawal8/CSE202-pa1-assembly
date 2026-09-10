.global product
# a in %rdi, b in %rsi, c in %rdx, size in %ecx
product:
    ret

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
