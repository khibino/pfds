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

. ./sh-lib

dir=$(dirname $source)
if [ x"$dir" != x. ]; then
	packopt="-for-pack $(module_path $dir)"
	inc="-I $dir"
fi

#echo $packopt

set -x
$compile_cmd $inc $packopt $source -o $target
