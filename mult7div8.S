.global mult7div8
# a in %dil (signed char), overflow pointer in %rsi; result in %eax
mult7div8:

    # char mult = 7 * a
    movb %dil, %r8b            # mult = a
    shlb $3, %r8b              # mult = a * 8
    subb %dil, %r8b            # mult = (a * 8) - a = 7 * a


    # if (a > 0 && mult < 0)
    cmpb $0, %dil              # compare a to 0
    jle .check_negative        # if a <= 0, goto check_negative

    cmpb $0, %r8b              # compare mult to 0
    jl .overflow               # if mult < 0, goto overflow

    jmp .no_overflow           # goto no_overflow


.check_negative:

    # if (a < 0 && mult > 0)
    cmpb $0, %dil              # compare a to 0
    jge .no_overflow           # if a >= 0, goto no_overflow

    cmpb $0, %r8b              # compare mult to 0
    jg .overflow               # if mult > 0, goto overflow

    jmp .no_overflow           # goto no_overflow


.overflow:

    movb $1, (%rsi)            # *overflow = 1
    jmp .divide                # goto divide


.no_overflow:

    movb $0, (%rsi)            # *overflow = 0


.divide:

    movsbl %r8b, %eax          # %eax = mult (sign-extended)

    cmpl $0, %eax              # compare mult to 0
    jge .shift                 # if mult >= 0, goto shift

    addl $7, %eax              # mult = mult + 7


.shift:

    sarl $3, %eax              # %eax = mult / 8
    ret                        # return mult / 8


# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       *overflow = 1;
#     else
#       *overflow = 0;
#     return mult/8;
# }
