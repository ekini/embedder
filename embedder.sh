#!/bin/bash

declare -A program
IFS=""
#binary data
program["testbinary"]="""
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
"""
program["test.sh"]="""
QlpoOTFBWSZTWQfDSwQAAARTgAAQeACEABph3AAgADFNMjExMQpk0yNGTajocBiVGltwF6cyKokh
30Pi7kinChIA+GlggA==
"""


function embed
{
tmpself=`tempfile`
tmpselfembedded=`tempfile`
sed -e '/^program\[\"'$1'\"\]=\"\"\"$/,/^\"\"\"/d' < "$0" > "$tmpself"
sed -e '1,/^#binary\sdata/!d' < "$tmpself" > "$tmpselfembedded"
echo 'program["'$1'"]="""' >> "$tmpselfembedded"
cat "$2" | bzip2 -9 | base64 >> "$tmpselfembedded"
echo '"""' >> "$tmpselfembedded"
sed -e '1,/^#binary\sdata/d' < "$tmpself" >> "$tmpselfembedded"

mv "$tmpselfembedded" "$0"
chmod u+x "$0"
rm $tmpself
}
function unembed
{
tmpself=`tempfile`
sed -e '/^program\[\"'$1'\"\]=\"\"\"$/,/^\"\"\"/d' < "$0" > "$tmpself"
mv "$tmpself" "$0"
chmod u+x "$0"
}
function run
{
    grep -P "^program\[\"$1\"\]=\"\"\"$" -q < "$0"
    if [ $? -eq 0 ]
    then
        tmpfile=`tempfile`
        echo ${program[$1]} | base64 -d | bzip2 -d > "$tmpfile"
        chmod u+x "$tmpfile"
        shift
        $tmpfile $@
        rm "$tmpfile"
    else
        echo "There is no program \"$1\""
    fi
}
function save
{
    if [ -n "$2" ]
    then
        grep -P "^program\[\"$1\"\]=\"\"\"$" -q < "$0"
        if [ $? -eq 0 ]
        then
            echo ${program[$1]} | base64 -d | bzip2 -d > "$2"
        else
            echo "There is no program \"$1\""
        fi
    else
        echo "Please specify output file"
    fi
}

case "$1" in
    "embed")
    echo "embedding..."
    embed "$2" "$3"
    ;;
    "unembed")
    echo "unembedding $2"
    unembed "$2"
    ;;
    "run")
    shift
    run $@
    ;;
    "save")
    save "$2" "$3"
    ;;
    "list")
    echo -n "programs: "
        for p in ${!program[@]}
        do
            echo -n "$p "
        done
        echo
    ;;
    *)
    echo "usage: $0 embed|unembed|run|save|list"
    ;;
esac
