# Makefile

# Copyright (C) 2021 İ. Göktuğ Kayaalp <self at gkayaalp dot com> This
# file is part of “Göktuğ’s homepage”.
#
# “Göktuğ’s homepage” is non-violent software: you can use,
# redistribute, and/or modify it under the terms of the CNPLv6+ as
# found in the LICENCE_CNPLv6.txt file in the source code root
# directory or at <https://git.pixie.town/thufie/CNPL>.
#
# “Göktuğ’s Gemini Scripts” comes with ABSOLUTELY NO WARRANTY, to the
# extent permitted by applicable law.  See the CNPL for details.


OUTDIR=out
PAGES:=$(wildcard pages/*.markdown)
PAGES:=$(PAGES:%.markdown=%.html)
PAGES:=$(PAGES:pages/%=out/%)
LINKBLOG=out/linkblog/index.html out/linkblog/feed.xml
SRCS=$(wildcard partials/_*.html) $(wildcard linkblog/*)

help:
	@echo Targets:
	@echo "	all	compile"
	@echo "	clean	remove generated files"
	@echo "	help	show this help message"
	@echo "	watch	automatic build"

all: _outdirs $(PAGES) $(LINKBLOG) $(SRCS) .gitignore
	cp static/* out/
	cp linkblog/style.css out/linkblog/

_outdirs:
	[ -d $(OUTDIR) ]          || mkdir -p $(OUTDIR)
	[ -d $(OUTDIR)/linkblog ] || mkdir -p $(OUTDIR)/linkblog

watch:
	ls $(PAGES) $(SRCS) static/* | entr make all

out/%.html: pages/%.markdown $(SRCS)
	./transform.sh $< > $@

out/linkblog/index.html: $(wildcard linkblog/*)
	ruby linkblog/linkblog.rb html > $@

out/linkblog/feed.xml: $(wildcard linkblog/*)
	ruby linkblog/linkblog.rb atom > $@

clean:
	rm -r $(OUTDIR)

.PHONY: all clean watch outdirs
