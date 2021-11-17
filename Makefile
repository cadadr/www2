# Makefile

OUTDIR=out
PAGES:=$(wildcard pages/*.markdown)
PAGES:=$(PAGES:%.markdown=%.html)
PAGES:=$(PAGES:pages/%=out/%)
SRCS=$(wildcard partials/_*.html)

help:
	@echo Targets:
	@echo "	all	compile"
	@echo "	clean	remove generated files"
	@echo "	help	show this help message"
	@echo "	watch	automatic build"

all: $(PAGES) $(SRCS) .gitignore
	cp static/* out/

watch:
	ls $(PAGES) $(SRCS) | entr make all

out/%.html: pages/%.markdown $(SRCS)
	./transform.sh $< > $@

clean:
	rm out/*

.PHONY: all clean watch
