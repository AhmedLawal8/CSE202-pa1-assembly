/*
 *  CSE202: Program Representation (Assembly Programming)
 *  Full name: 
 *  Full Lehigh Email Address: 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

struct ll{
    char *name;
    long value;
    struct ll *next;
};


extern int binsearch(int*, unsigned, int);
extern int mult7div8(char, unsigned char*);
extern int area(int, int, int);
extern short secondMax(short, short, short, short);
extern void reverse(char**, unsigned);
extern long sum(struct ll*);
extern void product(float*, float*, float*, unsigned);
extern int gcd(int, int);
extern int commonPrefix(char*, char*);
extern int isPrime(int);

int main(int argc, char **argv) {
  int i, val1, val2, val3;
  unsigned char overflow;
  struct ll *llist, *current, *temp;
  if (argc >= 3 && argc <= 10) {
    switch (argc) {
      case 3: // mult7div8 or isPrime
        if(strcmp(argv[1], "mult7div8") == 0){
          char c = (char)(atoi(argv[2]));
          char j = mult7div8(c, &overflow);
          fprintf(stdout, "mult7div8(%d) = %d, overflow? %s\n", c, j, (overflow==0)?"false":"true");
        }
        else if(strcmp(argv[1], "isPrime") == 0){
          i = atoi(argv[2]);
          fprintf(stdout, "isPrime(%d) = %s\n", i, isPrime(i) ? "true" : "false");
        }
        else{
          fprintf(stderr, "Error: invalid operation\n");
          return 1;
        }
        break;
      case 4://commonPrefix or gcd
        if(strcmp(argv[1], "commonPrefix") == 0){
          fprintf(stdout, "commonPrefix(\"%s\", \"%s\") = %d\n",
                argv[2], argv[3], commonPrefix(argv[2], argv[3]));
        }
        else if(strcmp(argv[1], "gcd") == 0){
          val1 = atoi(argv[2]);
          val2 = atoi(argv[3]);
          fprintf(stdout, "gcd(%d, %d) = %d\n", val1, val2, gcd(val1, val2));
        }
        else{
          fprintf(stderr, "Error: invalid operation\n");
          return 1;
        }
        break;
      case 5://area
        val1 = atoi(argv[2]);
        val2 = atoi(argv[3]);
        val3 = atoi(argv[4]);
        if(strcmp(argv[1], "area") == 0){
          fprintf(stdout, "area(%d, %d, %d) = %d\n",
                val1, val2, val3, area(val1, val2, val3));
        }
        else{
          fprintf(stderr, "Error: invalid operation\n");
          return 1;
        }
        break;
      case 6: //secondMax
        if(strcmp(argv[1], "secondMax") == 0){
          short v1, v2, v3, v4;
          v1 = (short)(atoi(argv[2]));
          v2 = (short)(atoi(argv[3]));
          v3 = (short)(atoi(argv[4]));
          v4 = (short)(atoi(argv[5]));

          short result = secondMax(v1, v2, v3, v4);
          fprintf(stdout, "secondMax(%d, %d, %d, %d) = %d\n",
                  v1, v2, v3, v4, result);
        }
        else{
          fprintf(stderr, "Error: invalid operation\n");
          return 1;
        }
        break;
      case 7: //reverse
        if(strcmp(argv[1], "reverse") == 0){
          char *arr1[5];
          for(i=0; i<5; i++){
            arr1[i] = argv[i+2];
          }
          reverse(arr1, 5);
          fprintf(stdout, "reversed list = {%s, %s, %s, %s, %s}\n",
                  arr1[0], arr1[1], arr1[2], arr1[3], arr1[4]);
        }
        else{
          fprintf(stderr, "Error: invalid operation\n");
          return 1;
        }
        break;
      case 8://product
        if(strcmp(argv[1], "product") == 0){
          float arr1[3], arr2[3], result[3];
          for(i=0; i<3; i++){
            arr1[i] = atof(argv[i+2]);
            arr2[i] = atof(argv[i+2+3]);
          }
          product(arr1, arr2, result, 3);
          fprintf(stdout, "[%.1f %.1f %.1f] x [%.1f %.1f %.1f] = [%.1f %.1f %.1f]\n",
                arr1[0], arr1[1], arr1[2], arr2[0], arr2[1], arr2[2], result[0], result[1], result[2]);
        }
        else{
          fprintf(stderr, "Error: invalid operation\n");
          return 1;
        }
        break;
      case 10://sum or binsearch (both take 8 trailing args -> argc 10)
        if(strcmp(argv[1], "binsearch") == 0){
          int arr[7];
          int target = atoi(argv[2]);
          for(i=0; i<7; i++){
            arr[i] = atoi(argv[i+3]);
          }
          fprintf(stdout, "binsearch(%d, {%d, %d, %d, %d, %d, %d, %d}) = %d\n",
                target, arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6],
                binsearch(arr, 7, target));
        }
        else if(strcmp(argv[1], "sum") == 0){
          llist = current = (struct ll*) malloc(sizeof(struct ll));
          char *name = (char*) malloc(strlen(argv[2])+1);
          strcpy(name, argv[2]);
          current->name = name;
          current->value = atol(argv[3]);
          current->next = NULL;
          for(int i=4; i<10; i+=2){
            temp = (struct ll*) malloc(sizeof(struct ll));
            name = (char*) malloc(strlen(argv[i])+1);
            strcpy(name, argv[i]);
            temp->name = name;
            temp->value = atol(argv[i+1]);
            temp->next = NULL;
            current->next = temp;
            current = temp;
          }
          long llsum = sum(llist);
          current = llist;
          printf("sum("); 
          while(current->next){
              printf("%ld, ", current->value);
              current = current->next;
          }
          printf("%ld) = %ld\n", current->value, llsum);
        }
        else{
          fprintf(stderr, "Error: invalid operation\n");
          return 1;
        }
        break;
      default:
          fprintf(stderr, "Wrong number of arguments on the command-line\n");
          return 1;
        break;
    }
  } else {
    fprintf(stderr, "Wrong number of arguments on the command-line\n");
    return 1;
  }
  return 0;
}
