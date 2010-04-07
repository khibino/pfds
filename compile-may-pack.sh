#! /bin/sh

#PATH="/usr/bin:/bin"
set -e

compile_cmd="$1"
source="$2"
target="$3"

if [ x"$compile_cmd" = x -o x"$source" = x -o x"$target" = x ]; then
	cat<<EOF
Usage: $0 COMPILE_COMMAND SOURCE TARGET
EOF
	exit 1
fi

module_path() {
	dir_path="$1"
	for dir in $(echo $dir_path | sed 's@/@ @g'); do
		mod="$(echo $dir | sed 's@^\(.\).*$@\1@' | tr 'a-z' 'A-Z')${dir#?}"
		mpath="${mpath}.${mod}"
	done
	echo ${mpath#.}
}

dir=$(dirname $source)
if [ x"$dir" != x. ]; then
	packopt="-for-pack $(module_path $dir)"
	inc="-I $dir"
fi

#echo $packopt

set -x
$compile_cmd $inc $packopt $source -o $target
