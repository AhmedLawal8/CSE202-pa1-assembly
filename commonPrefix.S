.global commonPrefix
# a in %rdi, b in %rsi; result (prefix length) in %eax
commonPrefix:

    movl $0, %eax              # n = 0


.loop:

    cmpb $0, (%rdi,%rax)       # compare a[n] to '\0'
    je .done                   # if a[n] == '\0', goto done

    movb (%rdi,%rax), %cl      # %cl = a[n]
    cmpb (%rsi,%rax), %cl      # compare a[n] to b[n]
    jne .done                  # if a[n] != b[n], goto done

    incl %eax                  # n++
    jmp .loop                  # goto loop


.done:

    retq                       # return n (%eax)

# length of the longest common prefix of two null-terminated strings
# int commonPrefix(char *a, char *b){
#     int n = 0;
#     while(a[n] && a[n] == b[n])
#         n++;
#     return n;
# }
