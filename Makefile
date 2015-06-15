all: rebuild

site: site.hs
	ghc --make site.hs

build: site
	./site build

rebuild: site
	./site rebuild

watch: site
	./site watch

clean: site
	./site clean



.PHONY: all rebuild clean build
