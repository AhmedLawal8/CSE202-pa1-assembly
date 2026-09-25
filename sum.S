.global sum
# pointer to list head in %rdi; result in %rax
# struct ll { char *name; long value; struct ll *next; }
#   offset 0  : name
#   offset 8  : value
#   offset 16 : next

sum:

    movq $0, %rax             # total = 0
    movq %rdi, %r8            # ptr = list


.loop:

    # while (ptr)
    cmpq $0, %r8              # compare ptr to NULL
    je .done                  # if ptr == NULL, goto done


    # total += ptr->value
    addq 8(%r8), %rax         # total = total + ptr->value


    # ptr = ptr->next
    movq 16(%r8), %r8         # ptr = ptr->next

    jmp .loop                 # goto loop


.done:

    retq                      # return total


# sum of the elements of a linkedlist in C
# long sum(struct ll *list){
#    long total = 0;
#    struct ll *ptr = list;
#    while(ptr){
#        total += ptr->value;
#        ptr = ptr->next;
#    }
#    return total;
# }
