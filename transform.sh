#!/bin/sh
# transform.sh --- markdown -> html

# Copyright (C) 2021, 2023 İ. Göktuğ Kayaalp <self at gkayaalp dot com> This
# file is part of “Göktuğ’s homepage”.
#
# “Göktuğ’s homepage” is non-violent software: you can use,
# redistribute, and/or modify it under the terms of the CNPLv6+ as
# found in the LICENCE_CNPLv6.txt file in the source code root
# directory or at <https://git.pixie.town/thufie/CNPL>.
#
# “Göktuğ’s Gemini Scripts” comes with ABSOLUTELY NO WARRANTY, to the
# extent permitted by applicable law.  See the CNPL for details.


# POSIX strict-ish mode, beware eager pipelines!
set -eu

infil="$1"
lastup="$(LANG=en LANG=en git log -1 --pretty=format:%cD $infil)"
lastup="${lastup:-Unknown}"

eval "$(sed -e 's/\$/\\$/g' -e '//,$d' $infil)"

sed -e '1,//d' -e '$s/$/\n\n/' $infil  \
    | cat - partials/_links.markdown     \
    | pandoc -f markdown -t html         \
    | ( echo "<!-- $infil --- [page content] -->"; cat - ) \
    | sed 's/^/    /'                    \
    | cat partials/_head.html - partials/_foot.html \
    | sed -e "s/@@LANG@@/$language/g"    \
          -e "s/@@TITLE@@/$title/g"      \
          -e "s/@@LASTUPDATE@@/$lastup/g"

