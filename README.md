# prog1: Assembly Language
Assembly: A programming exercise to write, compile, and link assembly code

# Learning Objectives
1) Write different functions in X86-64 ISA assembly code 
2) Compile assembly (.S) source files using the GNU AS(as) assembler
3) Write C program that uses functions compiled from assembly into object files
4) Link compiled assembly object files with the main C program
5) View the values in registers and the stack frame using gdb

# Instructions
Use the C program named prog1.c to call externally defined functions that you will write in assembly. You do NOT need (nor should you) edit the prog1.c code. In prog1.c, you will see ten function prototypes that are defined in separate assembly source code files: binsearch.S, mult7div8.S, area.S, secondMax.S, gcd.S, reverse.S, sum.S, product.S, commonPrefix.S, and isPrime.S. They are named based on the operation they perform. For example, binsearch returns the index of a target value in a sorted array and secondMax returns the second largest value in a list of shorts.

Your task is to implement each function in X86-64 assembly. Because of this requirement, it is highly recommended you do your development work on the sunlab machines.

Function shells have already been written in binsearch.S, mult7div8.S, area.S, secondMax.S, gcd.S, reverse.S, sum.S, product.S, commonPrefix.S, and isPrime.S. Here's a listing of the purpose of the functions. The C code is provided as comments at the end of each .S file. 

- **binsearch**: accepts a pointer to a sorted array of integers, an unsigned for its length, and a target integer. It returns the index of the target using binary search, or -1 if the target is not present.
  
- **mult7div8**: accepts two parameters: a signed character and a pointer to an unsigned char. The function multiplies the signed character by 7 and divides the product by 8 using shift and add/sub operations only. If the multiplication  overflows, the unsigned character is set 1 and to 0 if no overflow occurs.
  
- **secondMax**: accepts four short integers and returns the second largest value (duplicates count, so secondMax(5, 5, 1, 2) is 5).
  
- **area**: accepts three integers a, b, and c, representing the sides of a triangle and returns the area of the triangle. The area of a triangle is sqrt(p*(p-a)*(p-b)*(p-c)), where p is (a+b+c)/2. area invokes a recursive function, defined in the same file area.S, to recursively determine the square root of an integer. The C code of the recursive sqrt is provided in area.S.

- **reverse**: accepts two parameters: a pointer to an array of strings and an unsigned for the size of the array. The function reverses the elements in the array.
  
- **gcd**: accepts two integers a and b and returns their greatest common divisor. gcd invokes itself recursively using Euclid's algorithm (gcd(a, b) = gcd(b, a % b), with gcd(a, 0) = a). The recursive C code is provided in gcd.S.
  
- **sum**: accepts a pointer to the head of a linked list (struct ll defined in prog1.c) and returns the sum of the field value in the linked list nodes.
  
- **product**: accepts three pointers to float (vectors of float) and an unsigned integer for the size of the three vectors, and returns the product of the first vector by the second vector in the third vector. The equation below shows how the vector product is performed:
`[1.5 1.5 1.5] x [2.0 2.0 2.0] = [3.0 3.0 3.0]` 

- **commonPrefix**: accepts two pointers to null-terminated strings and returns the length of their longest common prefix (the number of leading characters they share). The C code is provided in commonPrefix.S.

- **isPrime**: accepts one integer n and returns 1 if n is prime and 0 otherwise. The implementation skips even divisors and only tests candidate divisors i while i*i <= n. The C code is provided in isPrime.S.

Before you modify anything, you should test what you have downloaded. To do this, simply type "bash runTests.sh". This Bash script compiles the program and runs a suite of tests. It compares the output of your program with the reference output of the program. You do NOT need (nor should you) edit runTests.sh, makefile, tests.reference, or prog1.c.

# Submission
Submit only .S files:
1) area.S
2) binsearch.S
3) commonPrefix.S
4) gcd.S
5) isPrime.S
6) mult7div8.S
7) product.S
8) reverse.S
9) secondMax.S
10) sum.S

# Recommended Approach
1) Leverage the textbook.
2) Work on this assignment a little every day.

# Important Notes
1) Add comments to your code; it will help you and the graders, especially during code review. 
2) Do NOT modify the files prog1.c, runTests.sh, makefile, tests.reference; only modify the .S files.
3) I will run your assembly on sunlab machine, please make sure your codes work on sunlab machine before submit. 
4) Submit all your codes on Gradescope for grading.
