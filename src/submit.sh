#!/bin/bash
host=localhost
root=box
input=/test/input.txt
while getopts "hs:r:f:i:q" opt
do
	case $opt in
		s)
			host="$OPTARG";;
		r)
			root="$OPTARG";;
		f)
			exec < "$OPTARG";;
		i)
			input="$OPTARG";;
		q)
			exec 2>/dev/null;;
		?)
			echo "$0 [-h(elp)] [-s(erver) server=$host] [-r(oot) (root=)$box] [-f(ile) (file=)$(readlink -f /dev/stdin)] [-i(nput) (input=)$input] [-q(uiet)] filelist-replace"
			exit;;
	esac
done
shift $((OPTIND-1))
[ "$#" -gt 0 ] && exec < <(cat "$@")
prefix="$host/$root"
id="$(curl -sf "http://$prefix/submit?input=$(js -e 'print(encodeURIComponent(readline()))' <<< "$input")" --data-binary "@-")"
case "$?" in
	0)
		echo "submission id $id" >&2
		for url in score out
		do
			echo $url: >&2
			until curl -sf "http://$prefix/code/$id/$url"
			do
				if [ "$?" -eq 22 ]
				then
					echo cancelled by admin >&2
					exit 1
				fi
				#sleep 10 #present in javascript client
			done
		done;;
	22)
		echo too many submissions >&2
		exit 2;;
	*)
		exit 3;;
esac
