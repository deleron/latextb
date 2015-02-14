# A beamer theme for LaTeX

I used and developed this theme for my own presentations.
It comes packaged with several useful tools to make the writing and review
of presentations easier.

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

#### Available options
Update the `\usetheme[<options>]{lrde}` in `manuscript.tex` with the options needed:
* `navsym` Uses of short navigation symbols.
* `exnavsym` Uses extended navigation symbols.
* `nonavsym` Without navigation symbols.
* `<beamer-options>` Can be combined with classical beamer options

One can see how these options behave by generating a portfolio pdf
```
make -f Makefile.full
```
and to clean it 
```
make -f Makefile.full clean
```

The `Makefile.full` file and `themes` repository can be deleted without troubles.

### Extended features

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

