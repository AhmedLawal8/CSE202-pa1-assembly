
#!/bin/bash
rm -f tests.out 2>&1 >/dev/null
echo -e "\nRunning make clean"
make -f makefile clean
echo -e "\nRunning make prog1"
make
rc=$?
total=0
if [[ $rc == 0 ]]; then
  tests=( "binsearch 5 1 3 5 7 9 11 13"
          "binsearch 8 1 3 5 7 9 11 13"
          "mult7div8 9"
          "mult7div8 25"
          "mult7div8 -9"
          "mult7div8 -64"
          "area 6 8 10"
          "area 2 2 2"
          "area 3 3 3"
          "area 4 4 4"
          "secondMax 11 77 44 22"
          "secondMax -11 -22 -33 -44"
          "secondMax 1 5 5 2"
          "secondMax 10 40 40 20"
          "gcd 48 18"
          "gcd 1071 462"
          "gcd 17 5"
          "gcd 0 5"
          "reverse bla bli blo blu bly"
          "reverse 100 200 300 400 500"
          "reverse Monday Tuesday Wednesday Thursday Friday"
          "reverse 500 400 300 200 100"
          "sum apple 3 kiwi 5 lemon 2 pear 4"
          "sum Emma 400 Helen 100 Paul 400 Lily 100"
          "sum Monday 65 Tuesday 71 Wednesday 78 Thursday 68"
          "sum Jan -10 Feb 10 Mar -5 Apr 5"
          "product 3.5 4.5 2.5 2.0 2.0 2.0"
          "product 3.5 4.5 2.5 0.5 0.5 0.5"
          "product 0.5 2.0 0.5 2.0 0.5 2.0"
          "product 4.0 6.0 8.0 0.5 2.0 0.5"
          "commonPrefix hello help"
          "commonPrefix abc abc"
          "commonPrefix abc xyz"
          "commonPrefix foobar foo"
          "isPrime 7"
          "isPrime 1"
          "isPrime 97"
          "isPrime 100"
          "commonPrefix Monday Money"
          "isPrime 2"
        )

  for test in "${tests[@]}"; do
    total=$((total + 1))
    echo -e "\nTest $total with args: $test"
    ./prog1 $test | tee -a tests.out
  done
paste -d '|' tests.out tests.reference | grep -Po '^(.*)\|+\K\1$' > out
count=0
input="./out"
while IFS= read -r line
do
  count=$((count + 1))
done < "$input"

if [[ $count == 40 ]]; then
   echo -e "\nAll tests passed"
   echo -e "Score: 120/120\n"
   exit 0
else
   echo -e "\n$count out of 40 passed"
   count=$((count * 3))
   echo -e "Score: $count /120\n"
   exit 1
fi

fi
