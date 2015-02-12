BASE = example
PDF = $(BASE).pdf
TEX = $(BASE).tex

BUILD_DIR=tmp.t2d

DEP = $(BASE).tex htabular.sty

TEXI2PDF = texi2pdf
TEXI2DVI_FLAGS = --build-dir=$(BUILD_DIR) --batch
TEXI2DVI_FLAGS += -I packages -I ./

all: $(PDF)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(PDF)

$(PDF): $(TEX) $(DEP)
	$(TEXI2PDF) $(TEXI2DVI_FLAGS) -o $@ $<

.PHONY: clean
