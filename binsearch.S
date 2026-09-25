.global binsearch
# arr in %rdi, n in %esi, target in %edx
binsearch:

    movl $0, %r8d                 # lo = 0

    movl %esi, %r9d               # hi = n
    subl $1, %r9d                 # hi = n - 1


.loop:

    # while (lo <= hi)
    cmpl %r9d, %r8d               # compare lo to hi (%r8d - %r9d)
    jg .not_found                 # if lo > hi, goto not_found


    # mid = lo + (hi - lo) / 2
    movl %r9d, %r10d              # mid = hi
    subl %r8d, %r10d              # mid = hi - lo
    sarl $1, %r10d                 # mid = (hi - lo) / 2
    addl %r8d, %r10d              # mid = lo + (hi - lo) / 2


    # if (arr[mid] == target)
    cmpl %edx, (%rdi,%r10,4)      # compare arr[mid] to target
    je .found                      # if arr[mid] == target, goto found


    # else if (arr[mid] < target)
    cmpl %edx, (%rdi,%r10,4)      # compare arr[mid] to target
    jl .less_than                  # if arr[mid] < target, goto less_than


    # else
    # hi = mid - 1
    movl %r10d, %r9d              # hi = mid
    subl $1, %r9d                 # hi = mid - 1
    jmp .loop                      # goto loop


.less_than:

    # lo = mid + 1
    movl %r10d, %r8d              # lo = mid
    addl $1, %r8d                 # lo = mid + 1
    jmp .loop                      # goto loop


.found:

    movl %r10d, %eax              # %eax = mid
    ret                           # return mid


.not_found:

    movl $-1, %eax                # %eax = -1
    ret                           # return -1


# binary search over a sorted int array; returns the index of target, or -1
# int binsearch(int *arr, unsigned n, int target){
#     int lo = 0;
#     int hi = (int)n - 1;
#     while(lo <= hi){
#         int mid = lo + (hi - lo) / 2;
#         if(arr[mid] == target)
#             return mid;
#         else if(arr[mid] < target)
#             lo = mid + 1;
#         else
#             hi = mid - 1;
#     }
#     return -1;
# }
