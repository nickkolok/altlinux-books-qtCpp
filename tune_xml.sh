#!/bin/sh -e
# -*- mode: Shell-script; tab-width: 8; fill-column: 70; -*-

PROG="${0##*/}"
TUNE_STYLESHEET="${TUNE_STYLESHEET:-http://docs.altlinux.ru/releases/xsl/current/common/tuning.xsl}"

Fatal() {
  printf "$PROG: Fatal: %s\n" "$*" >&2
  exit 1
}

exit_handler()
{
        local rc=$?
        trap - EXIT
        rm -rf -- "$output_dir"
        exit $rc
}
trap exit_handler EXIT HUP INT QUIT PIPE TERM

output_dir="$(mktemp -d -t $PROG.XXXXXXXX)"
target_document="$1" && shift || Fatal "Insufficient arguments"
resulting_document="$1" && shift
additional_parameters=$@
source_dir="$(dirname $target_document)"

#echo "General parameters: $additional_parameters"
#echo "$(pwd)"

# tuning stage
/usr/bin/xsltproc \
	--output "$resulting_document" \
	--nonet \
	--xinclude \
	$additional_parameters \
	--param ulink.leave.duplicates.after 10 \
	--param revhistory.strip 1 \
	"$TUNE_STYLESHEET" \
	"$target_document" \
  || Fatal "Tuning stage: xsltproc failed"

  # copying images 
mkdir -p $output_dir/images
sh $source_dir/collect_images.sh $source_dir $output_dir
cp -a $output_dir/images $source_dir

