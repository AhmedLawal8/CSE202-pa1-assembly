.global secondMax
# v1 in %di, v2 in %si, v3 in %dx, v4 in %cx  (signed 16-bit); result in %ax

secondMax:

    # if (v1 >= v2)
    cmpw %si, %di          # compare v1 to v2 (%di - %si)
    jge .v1_greater_equal  # if v1 >= v2, goto if body

    # else
    movw %si, %r8w  # %r8w = v2 = first
    movw %di, %r9w  # %r9w = v1 = second
    jmp .check_v3   # finished if/else, move to v3


.v1_greater_equal:

    movw %di, %r8w  # first = v1
    movw %si, %r9w  # second = v2


.check_v3:

    # if (v3 > first)
    cmpw %r8w, %dx  # compare v3 to first (%dx - %r8w)
    jg .v3_greater   # if v3 > first, jump to if body

    # else if (v3 > second)
    cmpw %r9w, %dx  # compare v3 to second (%dx - %r9w)
    jg .v3_greater_second  # if v3 > second, jump to else-if body

    jmp .check_v4   # neither was true, move to v4


.v3_greater:

    movw %r8w, %r9w            # second = first
    movw %dx, %r8w             # first = v3
    jmp .check_v4              # finished v3 check, move to v4


.v3_greater_second:

    movw %dx, %r9w             # second = v3
    jmp .check_v4              # finished v3 check, move to v4


.check_v4:

    # if (v4 > first)
    cmpw %r8w, %cx             # compare v4 to first (%cx - %r8w)
    jg .v4_greater             # if v4 > first, jump to if body

    # else if (v4 > second)
    cmpw %r9w, %cx          # compare v4 to second (%cx - %r9w)
    jg .v4_greater_second   # if v4 > second, jump to else-if body

    jmp .done               # neither was true, we're done


.v4_greater:

    movw %r8w, %r9w          # second = first
    movw %cx, %r8w          # first = v4
    jmp .done              # finished v4 check


.v4_greater_second:
    movw %cx, %r9w     # second = v4

    jmp .done         # finished v4 check


.done:

    movw %r9w, %ax             # %ax = second (return value)
    retq                       # return second

# short secondMax(short v1, short v2, short v3, short v4){
#     short first, second;
#     if(v1 >= v2){ first = v1; second = v2; }
#     else        { first = v2; second = v1; }
#     if(v3 > first)       { second = first; first = v3; }
#     else if(v3 > second) { second = v3; }
#     if(v4 > first)       { second = first; first = v4; }
#     else if(v4 > second) { second = v4; }
#     return second;
# }
