# directory that contains source documents
SOURCEDIR=src
# list of .odt files with source documents
MODULESLIST=list
SRCLIST=src.list
IMAGEDIR=images
W2L=java -jar /usr/share/java/writer2latex.jar -latex
W2LCONF=convert.xml
W2LADD=
W2LOPTS=-config=$(W2LCONF) $(W2LADD)
CLEANSCRIPT=-e 's,\\tableofcontents,%&,' -e 's,{tabulary}{[^}]\+},{tabulary}{\\linewidth},'
ALDC=LC_ALL=POSIX ALDConvert
MKCLEANSCRIPT=-e '/Figure/s,\\_\([^}]\+}\)$$,@@\1,' -e 's,\\label{\([^_}]\+\)\\_\([^}_]\+\)},\\label{\1@@\2},g' \
			  -e 's,\\label{\([^"}]\+\)"\([^}]\+\)},\\label{\1\2},g' \
			  -e "s,\\\'\(.\),\\\'{\1},g" -e 's,\Href\(\[[^]]\+\]{\.\./[^}/]\+/index.html}\),\Mref\1,g'
DBLATEX=XML_CATALOG_FILES=/usr/share/xml/docbook/dtd/4.5/catalog dblatex
DBLATEXCONF=dblatex_cfg.xsl
DBCLEANSCRIPT=-e '0,/\\mainmatter/d' -e '/\\end{document}/d' -e "s,{\(images[^}]\+\).png},{$(dir $<)\1},g" \
			  -e 's, —, "---,g' -e 's, ,~,g' -e 's,-{},"=,g'
TUNEXML=sh tune_xml.sh
TUNEXMLPARAMS=

.PHONY: source


all: 
	make distclean
	make index
	make pass ||: 
	make pass ||:
	make pass ||:
	make block.pdf


%.tex: %.odt
	$(W2L) $(W2LOPTS) $< $@
	sed -i $(CLEANSCRIPT) $@
	echo '%%% Local Variables: ' >> $@
	echo '%%% mode: latex' >> $@
	echo '%%% TeX-master: "main"' >> $@
	echo '%%% End: ' >> $@

%.tex: %.m-k
	file -bi $< | awk '/utf-8/ {exit 1}' || { iconv -f utf-8 -t koi8-r $< > $<.koi ; mv $<.koi $< ;}
	$(ALDC) -F -w latex $< $@ -C utf-8
	# workaround for ALDConvert bug (huge resulting images)
	sed -i $(MKCLEANSCRIPT) $@
	for i in $(@D)/*.png ; do convert $$i -colorspace Gray $$i.eps ; done

%.tuned.xml: %.xml
	$(TUNEXML) $< $@ $(TUNEXMLPARAMS)

%.tex: %.tuned.xml
	$(DBLATEX) -p $(DBLATEXCONF) -m 4xslt -t tex $<
	sed -i $(DBCLEANSCRIPT) $(basename $<).tex
	mv $(basename $<).tex $@
	for i in  $(@D)/images/*.{png,jpg} ; do convert $$i -colorspace Gray $${i%.*}.eps ; done

%.dvi: %.tex
	latex "\nonstopmode\input{$<}"
	latex "\nonstopmode\input{$<}"

pass:
	latex "\nonstopmode\input{block.tex}"

%.ps: %.dvi
	dvips -j0 -Ppdf -o $@ $<

%.pdf: %.ps
	ps2pdf -dPDFSETTINGS=/prepress -dAutoFilterGrayImages=false -dGrayImageFilter=/FlateEncode $< $@

%.pdf: %.eps
	ps2pdf -dEPSCrop $< $@

%.raw.txt: %.pdf
	pdftotext -layout -nopgbrk -q $< $@

%.stat: %.dvi %.raw.txt
	echo "scale=2; `dvitype --output-level=1 $< | fgrep PSfile | sed 's/.*llx=\(-\?[0-9]\+\) lly=\(-\?[0-9]\+\) urx=\(-\?[0-9]\+\) ury=\(-\?[0-9]\+\).*/\3 \1 \4 \2/' | awk '{s=s+(($$1-$$2)/72)*(($$3-$$4)/72)*2.54; next} END{printf "%.2f", s/3000}'` + (`cat $(basename $<).raw.txt| wc -m` / 40000)" | bc > $@

# Handle idiosyncrasies of particular documents formatting
#document.tex: W2LADD = <options list>

default: block.pdf
#default: tex

get-sources: $(SRCLIST)
	[ -d $(SOURCEDIR) ] || mkdir $(SOURCEDIR)
	cat $(SRCLIST) | grep -v '^#' | grep . | while read repo head ; do \
		git-clone $$repo $(SOURCEDIR)/`basename $$repo` && \
		{ pushd $(SOURCEDIR)/`basename $$repo` && git-checkout -b work $$head ; popd ; } done

update-sources: $(SRCLIST) $(SOURCEDIR)
	cat $(SRCLIST) | grep -v -e '^#' | grep . | while read repo head ; do \
		pushd $(SOURCEDIR)/`basename $$repo` ; \
		git-fetch origin && \
		git-merge $$head ; \
		popd ; done

source: $(MODULESLIST) $(SOURCEDIR)
	cat $(MODULESLIST) | grep -v '^#' | grep . | while read dir f ; do \
		test -d $$dir || mkdir $$dir ; \
		cp -a $(SOURCEDIR)/$$dir/$$f ./$$dir/ ; done

tex: source 
	cat $(MODULESLIST) | grep -v '^#' | grep . | while read dir f ; do \
		bf="$${f##*/}" ; \
		test "$$bf" == "*" || $(MAKE) $$dir/$${bf%%.*}.tex ; done

pictures:
	for i in images/*.png ; do convert $$i -colorspace Gray $${i%%.png}.eps && rm -f $$i; done
	for i in images/*.tif ; do convert $$i -colorspace Gray $${i%%.tif}.eps && rm -f $$i; done

clean:
	rm -f *.png *.jpg *.dvi *.log *.toc *.aux *.eps *~

distclean: clean
	rm -f block.pdf

latex: block.dvi

index:
#	rumakeindex main.idx
#	mv main.ind main.ind.
#	iconv -f koi8-r -t utf-8 < main.ind. > main.ind
#	rm -f main.ind.
#	$(MAKE) latex
	./rumakeindex block
#	makeindex -t block.ilg block.idx > block.ind
#	mv block.ind block.ind.
#	iconv -f koi8-r -t utf-8 < block.ind. > block.ind
#	rm -f block.ind.
#	$(MAKE) latex

ps: main.ps

pdf: main.pdf

add-images:
	for i in book/*.tif ; do convert $$i images/`basename $$i .tif`.eps ; done
	for i in book/*.png ; do convert $$i -colorspace Gray $${i%%.png}.eps && rm -f $$i; done
	for i in book/*.gif ; do convert $$i -colorspace Gray $${i%%.gif}.eps && rm -f $$i; done
