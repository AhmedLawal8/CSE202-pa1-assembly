.global isPrime
# n in %edi; result in %eax (1 = prime, 0 = not prime)
isPrime:

    # if (n < 2)
    cmpl $2, %edi              # compare n to 2
    jl .not_prime              # if n < 2, goto not_prime


    # if (n % 2 == 0)
    testl $1, %edi             # check lowest bit of n
    jz .even                   # if lowest bit is 0, n is even


    # int i = 3
    movl $3, %r8d              # i = 3


.loop:

    # for (...; i * i <= n; ...)
    movl %r8d, %r9d            # %r9d = i
    imull %r8d, %r9d           # %r9d = i * i

    cmpl %edi, %r9d            # compare i*i to n
    jg .prime                  # if i*i > n, goto prime


    # if (n % i == 0)
    movl %edi, %eax            # %eax = n
    cltd                       # prepare %edx:%eax for signed division
    idivl %r8d                 # %eax = n/i, %edx = n%i

    cmpl $0, %edx              # compare n%i to 0
    je .not_prime              # if n%i == 0, goto not_prime


    # i += 2
    addl $2, %r8d              # i = i + 2
    jmp .loop                  # goto loop


.even:

    # return n == 2
    cmpl $2, %edi              # compare n to 2
    je .prime                  # if n == 2, goto prime
    jmp .not_prime             # otherwise goto not_prime


.prime:

    movl $1, %eax              # %eax = 1
    ret                        # return 1


.not_prime:

    movl $0, %eax              # %eax = 0
    ret                        # return 0


# int isPrime(int n){
#     if(n < 2)
#         return 0;
#     if(n % 2 == 0)
#         return n == 2;
#     /* only test odd divisors i while i*i <= n */
#     for(int i = 3; i * i <= n; i += 2){
#         if(n % i == 0)
#             return 0;
#     }
#     return 1;
# }
