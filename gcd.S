.global gcd
# a in %edi, b in %esi; result in %eax
gcd:

    # if (b == 0)
    cmpl $0, %esi              # compare b to 0
    je .base_case              # if b == 0, goto base_case


    # Find a % b
    movl %edi, %eax            # %eax = a
    cltd                       # prepare %edx:%eax for signed division
    idivl %esi                 # %eax = a / b, %edx = a % b


    # return gcd(b, a % b)
    movl %esi, %edi            # new a = b
    movl %edx, %esi            # new b = a % b

    call gcd                    # call gcd(new a, new b)

    retq                       # return result from recursive call


.base_case:

    movl %edi, %eax            # %eax = a
    retq                       # return a


# greatest common divisor via Euclid's algorithm (recursive)
# int gcd(int a, int b){
#     if(b == 0)
#         return a;
#     /* recursive call */
#     return gcd(b, a % b);
# }
