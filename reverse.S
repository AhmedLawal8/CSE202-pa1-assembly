.global reverse
# list in %rdi (array of char*), n in %esi

reverse:

    movl $0, %r8d                  # i = 0


.loop:

    # while (i < n/2)
    movl %esi, %eax                # %eax = n
    shrl $1, %eax                  # %eax = n / 2

    cmpl %eax, %r8d                # compare i to n/2
    jae .done                      # if i >= n/2, goto done


    # char *temp = list[i]
    movq (%rdi,%r8,8), %r9         # temp = list[i]


    # Need to calculate n - i - 1
    movl %esi, %eax                # %eax = n
    subl %r8d, %eax                # %eax = n - i
    subl $1, %eax                  # %eax = n - i - 1


    # list[i] = list[n-i-1]
    movq (%rdi,%rax,8), %r10       # %r10 = list[n-i-1]
    movq %r10, (%rdi,%r8,8)        # list[i] = list[n-i-1]


    # list[n-i-1] = temp
    movq %r9, (%rdi,%rax,8)        # list[n-i-1] = temp


    # i++
    incl %r8d                      # i = i + 1
    jmp .loop                      # goto loop


.done:

    retq                           # return


# void reverse(char **list, unsigned n){
#     unsigned i = 0;
#     while (i < n/2){
#      char *temp = list[i];
#      list[i] = list[n-i-1];
#      list[n-i-1] = temp;
#      i++;
#     }
# }
