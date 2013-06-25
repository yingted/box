#!/usr/bin/awk -f
{y=$2;z=$3;while(y--){getline;if($1<=z&&z<=$2)s+=$3};print s}
