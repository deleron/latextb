##############################################################################
# Tool to neatly compile LaTeX files
# See README.md for usage
##############################################################################

NAME = $(notdir $(PWD))
PDF = $(NAME).pdf

BASE = slides

BUILD_DIR=tmp.t2d

STYLE_DIR=styles
FIGURES_DIR=figures
BIB_DIR=bib
PKG_DIR=packages
DEP_DIR=src

all: $(PDF)

##############################################################################
### LaTeX Generated images - Generation of .eps images from .tex files

# Customizable options
DPI=300# dots per inch
MAXWIDTH=6.83# maximum width in inches
MAXHEIGHT=9.19# maximum height in inches
GENFIGURES_DIR=genfigures# figures to be generated

# Automatically retrieved/generated parameters
MAXSIZE:=$(shell echo "$(DPI)*$(MAXWIDTH);$(DPI)*$(MAXHEIGHT)" | bc -l | xargs printf "%1.0fx%1.0f\>")# max WxH pixel box
TEXFIGURES=$(shell test -e $(GENFIGURES_DIR) && find `find $(GENFIGURES_DIR) -type d | sort -r` -maxdepth 1 -iname "*.tex")# tex files
GENFIGURES=$(subst .tex,.eps,$(TEXFIGURES))# associated .eps files
FIGURES=$(shell test -e $(FIGURES_DIR) && find $(FIGURES_DIR)/ -type f)
CONVERT_FLAGS=+profile '!exif,*' -set units PixelsPerInch -density $(DPI) -flatten -set colorspace RGB -depth 32 -resize $(MAXSIZE) -compress lzw

# Generates a 300 dpi suitable figure
%.eps: %.tex
	PDFLATEX=xelatex $(TEXI2PDF) $(TEXI2DVI_FLAGS) -o $*.pdf $<
	convert $(CONVERT_FLAGS) $*.pdf $@
	rm $*.pdf

# Generates figures from TeX files
figures: $(FIGURES) $(GENFIGURES)

##############################################################################
### Manuscript generation

DEP_TEX = $(wildcard *.tex) \
	  $(shell test -e $(DEP_DIR) && find `find $(DEP_DIR) -type d | sort -r` -maxdepth 1 -iname "*.tex")
DEP = $(DEP_TEX) \
      $(GENFIGURES) \
      $(wildcard *.cls) \
      $(wildcard $(PKG_DIR)/*.sty) \
      $(wildcard $(BIB_DIR)/*.bib) \
      $(wildcard $(FIGURES_DIR)/*)

TEXI2PDF = texi2pdf
TEXI2DVI_FLAGS = --build-dir=$(BUILD_DIR) --batch
TEXI2DVI_FLAGS += -I $(STYLE_DIR) -I $(FIGURES_DIR) -I $(BIB_DIR) -I $(PKG_DIR) -I ./

clean:
	rm -rf vc.info
	rm -rf $(BUILD_DIR)
	rm -rf $(PDF)

$(PDF): $(DEP) vc.info
	PDFLATEX=xelatex $(TEXI2PDF) $(TEXI2DVI_FLAGS) -o $@ $<

##############################################################################
### Git handling

# Generates file with information about current git revision
vc.info: $(DEP)
	$(PWD)/bin/vc

# Generates a pdf file named with the current git revision
versioned: $(PDF)
	@cp -r $(PDF) `git log -1 HEAD --date=rfc --pretty=format:"$(NAME)_%ai_%h.pdf%n" | tr ": " "-" | tr -d "+"`

# Allows to generate a pdf which will underline differences between two git versions of the document 
BUILD_DIR_DIFF = $(BUILD_DIR).diff
HASH1 = HEAD# Default comparison is made with the last available git revision
HASH2 = unset
DIFF_TEX = $(DEP_TEX)# Possibility to make a diff for a specific part only ! (always include the $(BASE).tex !)
diff:
	@test $(HASH2) != unset || (echo "You need pass HASH2=<git-hash> as parameter" && exit 1)
	@rm -rf $(BUILD_DIR_DIFF) && mkdir -p $(BUILD_DIR_DIFF)
	git archive $(HASH1) | tar -x -C $(BUILD_DIR_DIFF)
	for i in `git ls-files $(HASH1)`; do \
	  mkdir -p $(BUILD_DIR_DIFF)/`dirname $$i`; \
	  echo mkdir -p $(BUILD_DIR_DIFF)/`dirname $$i`; \
	  cp -r $$i $(BUILD_DIR_DIFF)/; \
	done
	for i in $(DIFF_TEX); do \
	  git --no-pager show $(HASH1):./$$i > $(BUILD_DIR_DIFF)/$$i.diff.1; \
	  git --no-pager show $(HASH2):./$$i > $(BUILD_DIR_DIFF)/$$i.diff.2; \
	  latexdiff $(BUILD_DIR_DIFF)/$$i.diff.2 $(BUILD_DIR_DIFF)/$$i.diff.1 > $(BUILD_DIR_DIFF)/$$i; \
	  perl -pi -e "s///g" $(BUILD_DIR_DIFF)/$$i; \
	done
	cd $(BUILD_DIR_DIFF) && $(MAKE) NAME=$(NAME)_diff versioned

##############################################################################
### Useful tools

# Generate a PDF with only a subpart of the original pages
RANGE = unset
PARTNAME = $(NAME)
part: $(PDF)
	@test $(PARTNAME) != $(NAME) || (echo "You can pass PARTNAME=partname as parameter to specify to what part its correspond")
	@test $(RANGE) != unset || (echo "You need pass RANGE=pBegin-pEnd as parameter" && exit 1)
	pdftk A=$(PDF) cat A$(RANGE) output `git log -1 HEAD --date=rfc --pretty=format:"$(PARTNAME)_%ai_%h_p$(RANGE).pdf%n" | tr ": " "-" | tr -d "+"`

# Extend clean target to handle extra temporary generated files
distclean: clean
	@(test ! "$(GENFIGURES)") || (echo rm -f $(GENFIGURES) && rm -f $(GENFIGURES))
	@(test ! -e $(BUILD_DIR_DIFF)) || (echo rm -rf $(BUILD_DIR_DIFF) && rm -rf $(BUILD_DIR_DIFF))

.PHONY: clean distclean versioned diff figures part
