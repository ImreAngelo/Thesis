# The main latex-file
TEXFILE = main

# Fix reference file and compile source
default: mk

PDFLATEX = pdflatex -shell-escape -interaction=nonstopmode

full:
	$(PDFLATEX) $(TEXFILE);\
	biber $(TEXFILE);\
	makeglossaries $(TEXFILE);\
	$(PDFLATEX) $(TEXFILE);\
	makeglossaries $(TEXFILE);\
	$(PDFLATEX) $(TEXFILE);\
	$(PDFLATEX) $(TEXFILE)

mk:
	latexmk -pdf -shell-escape -interaction=nonstopmode \
		-e '$$makeindex = q/makeglossaries %B/' $(TEXFILE)

force:
	latexmk -f -pdf -shell-escape -interaction=nonstopmode \
		-e '$$makeindex = q/makeglossaries %B/' $(TEXFILE)

# Removes TeX-output files
clean:
	rm -f *.aux $(TEXFILE).bbl $(TEXFILE).blg *.log *.out $(TEXFILE).toc $(TEXFILE).lot $(TEXFILE).lof $(TEXFILE).glg $(TEXFILE).glo $(TEXFILE).gls $(TEXFILE).acn $(TEXFILE).acr $(TEXFILE).alg $(TEXFILE).xdy $(TEXFILE).loa $(TEXFILE).bcf $(TEXFILE).run.xml $(TEXFILE).fls $(TEXFILE).fdb_latexmk
clean-all:
	rm -f *.aux $(TEXFILE).bbl $(TEXFILE).blg *.log *.out $(TEXFILE).toc $(TEXFILE).lot $(TEXFILE).lof $(TEXFILE).glg $(TEXFILE).glo $(TEXFILE).gls $(TEXFILE).acn $(TEXFILE).acr $(TEXFILE).alg $(TEXFILE).xdy $(TEXFILE).loa $(TEXFILE).bcf $(TEXFILE).run.xml $(TEXFILE).pdf $(TEXFILE).fls $(TEXFILE).fdb_latexmk
