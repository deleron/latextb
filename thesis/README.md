# A thesis document class for LaTeX

I used and developed this LaTeX class for my own PhD Thesis.
It comes packaged with several useful tools to make the writing and review
easier.

### Requirements
Some LaTeX related packages are required and may be retrieved with the following
command (e.g. on ubuntu)
```
sudo apt-get install texinfo texlive texlive-xetex texlive-latex-extra biblatex
```

Some additional packages are required to take full advantage of this class, and
may be retrieved with the following command (e.g. on ubuntu)
```
sudo apt-get gawk
```

### Basic usage
To generate the PDF (without index nor glossary), simply run
```
make
```
The default name (variable `NAME` in the `Makefile`) is based on the name of the
repository used.

To clean 
```
make clean
```
and to clean additional generated files (i.e. diff and figures)
```
make distclean
```

#### Available options
Update the `\documentclass[<options>]` in `manuscript.tex` with the options needed:
* `print` Adds an extra margin of 0.5cm around an a4paper format (for bleeding
    parts, i.e. black marks on sides). *Requires recent packages.*
* `twoside` Makes the inner margins larger than the outer ones, giving a nicer look in 
    a book/booklet version. 
* `booklet` Generates extra blank pages at the end of the manuscript making
    it easier to print it as a booklet, i.e. 2 pages on a A4 paper.
* `gitinfo` Allows to embed GIT information (when available) on each page to track changes.
    *Requires gawk.*

### Extended features

#### Bibliography handling

It is possible to hide a reference from the bibliography by extending its bib
entry with the following key:
```
@misc{entry,
  ...
  keywords = {unbib}
}
```

It is also possible to have dedicated bibliographies by using other keywords.
See `src/publications.tex` for an example.

#### Figures automatic generation

I mainly use TikZ for schemas and hence, my figures are nothing more than LaTeX
files. For the ease of sharing (and publications purposes), I find it better to
generate the figures independently from the main content as `EPS` files.

To only generate the LaTeX figures, run
```
make figures
```

*All LaTeX generated figures must be under the `GENFIGURES_DIR` repository
defined in the `Makefile`.*

Furthermore, generated figures may be resized according to the `DPI`,
`MAXWIDTH` and `MAXHEIGHT` variables in the `Makefile`.

Note that such figures might depend upon other generated figures. A proper way
of handling dependencies would involve recrusive Makefiles (not provided).
However, I made it such that any figure in a subdirectory will be generated
before any figure in a parent directory.

#### Glossary and index

With (little) extra work, it is possible to provide the readers with an index and a glossary.
The index lists all (predefined by hands) terms/acronyms with their positions in
the text (if read on a PDF, hyperlinks are provided). The glossary lists
definition of (predefined by hands) terms/acronyms.

To generate the full PDF from scratch, run
```
make full
```
or after `make`, you may simply run
```
make glossary
```

##### Use/define acronyms/terms 

See `src/glossary.tex` to see how terms can be defined and used.

#### Review tools

##### PDF samples

To extract a subpart of your pdf, run
```
make part PARTNAME=<part-name> RANGE=<pBegin-pEnd>
```

##### PDF versioned name

To a generate a PDF with a unique timestamp name based on GIT information, run
```
make versioned
```

##### Diff tools

It is sometimes useful to see the increments made between 2 different versions.
*Requires latexdiff package.* Note that complex diff might fail ! I recommend to
use the third possibility (a diff only on a specific part).

To make a diff between git revision <hash2> and HEAD, run
```
make diff HASH2=<hash2>
```

To make a diff between git revisions <hash2> and <hash1>, run
```
make diff HASH2=<hash2> HASH1=<hash1>
```

To make a diff only on a specific part (e.g. discussion.tex), run
```
make diff HASH2=<hash2> DIFF_TEX="discussion.tex manuscript.tex"
```
*Including the main file (manuscript.tex) is mandatory*

