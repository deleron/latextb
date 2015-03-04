# HTabular - Fancy YES/NO/MAYBE tables for LaTeX

A package dedicated to YES/NO/MAYBE tables with long headers.

![image of output](sample/htabular.png?raw=true "Screenshot of an htabular")

### Options

* `colors` Uses predefined green/red/gray color scheme
* `minimum cell size=<size>` Defines the side width of a YES/NO/MAYBE cell
    (always a square)
* `minimum label width=<width>` Defines the (horizontal) space allocated to
    labels
* `minimum header width=<size>` Defines the (vertical) space allocated to
    headers

See `example.tex` for usage

### Notes

It is possible to combine this package with `postaction` and `preaction`
keywords as in TikZ.
