#!/bin/sh
# transform.sh --- markdown -> html

# POSIX strict-ish mode, beware eager pipelines!
set -eu

infil=$1

eval "$(sed -e 's/\$/\\$/g' -e '//,$d' $infil)"

sed -e '1,//d' -e '$s/$/\n\n/' $infil  \
    | cat - partials/_links.markdown     \
    | pandoc -f markdown -t html         \
    | ( echo "<!-- $infil --- [page content] -->"; cat - ) \
    | sed 's/^/    /'                    \
    | cat partials/_head.html - partials/_foot.html \
    | sed -e "s/@@LANG@@/$language/g"    \
          -e "s/@@TITLE@@/$title/g"

