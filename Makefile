# The main latex-file
TEXFILE = main

# Build main.pdf (default target)
default: mk

PDFLATEX = pdflatex -shell-escape -interaction=nonstopmode

# Preferred build: latexmk drives pdflatex + biber + glossaries as needed
mk:
	latexmk -pdf -shell-escape -interaction=nonstopmode \
		-e '$$makeindex = q/makeglossaries %B/' $(TEXFILE)

# Force a rebuild even if latexmk thinks nothing changed
force:
	latexmk -f -pdf -shell-escape -interaction=nonstopmode \
		-e '$$makeindex = q/makeglossaries %B/' $(TEXFILE)

# Explicit full build without relying on latexmk's dependency tracking
full:
	$(PDFLATEX) $(TEXFILE);\
	biber $(TEXFILE);\
	makeglossaries $(TEXFILE);\
	$(PDFLATEX) $(TEXFILE);\
	makeglossaries $(TEXFILE);\
	$(PDFLATEX) $(TEXFILE);\
	$(PDFLATEX) $(TEXFILE)

# Removes TeX-output files (keeps main.pdf)
clean:
	latexmk -c $(TEXFILE)
	rm -f *.aux $(TEXFILE).bbl $(TEXFILE).blg *.log *.out $(TEXFILE).toc $(TEXFILE).lot $(TEXFILE).lof $(TEXFILE).glg $(TEXFILE).glo $(TEXFILE).gls $(TEXFILE).acn $(TEXFILE).acr $(TEXFILE).alg $(TEXFILE).xdy $(TEXFILE).loa $(TEXFILE).bcf $(TEXFILE).run.xml $(TEXFILE).fls $(TEXFILE).fdb_latexmk

# Removes TeX-output files including main.pdf
clean-all: clean
	rm -f $(TEXFILE).pdf

.PHONY: default mk force full clean clean-all
