#!/bin/sh
declare -ar fact=(1 1 2 6 4) pow2=(6 2 4 8)
declare -i n last zeroes
while read -r n && [[ n -ge 0 ]]
do
	zeroes=0
	for((last=fact[n%5];n/=5;zeroes+=n))
	do
		((last=last*fact[n%5]*pow2[n%4]%10))
	done
	echo ${last}u$zeroes
done
