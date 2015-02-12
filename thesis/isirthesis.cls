%%% isirthesis.cls --- Phd Thesis Class

%% Copyright (C) 2009-2015, Florian Lesaint

%% Inspired from a class developed by Didier Verna <didier@lrde.epita.fr>

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{isirthesis}[2014/02/12 v1.2 Isir Thesis Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options

\newif\if@langfrench \@langfrenchfalse
\DeclareOption{french}{\@langfrenchtrue}
% Allows to translate the documents and keywords in french

\newif\if@booklet \@bookletfalse
\DeclareOption{booklet}{\@booklettrue}
% Allows to build a document which can easily be printed in booklet

\newif\if@gitinfo \@gitinfofalse
\DeclareOption{gitinfo}{\@gitinfotrue}
% Provide informations about the current GIT revision of the document

\newif\if@print \@printfalse
\DeclareOption{print}{\@printtrue}

\ProcessOptions

%% Base class
\LoadClassWithOptions{report}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Basics packages

% Uses utf8 encoding
\RequirePackage{eurosym}
\if@langfrench
  \RequirePackage[frenchb]{babel}
\else
  \RequirePackage[frenchb,english]{babel}
\fi
\RequirePackage{fontspec}
\RequirePackage{csquotes}

\RequirePackage{xspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Handling options

%% Handling language
% default: english
\def\@theby{A PhD Thesis by}
\def\@theat{submitted to}
\def\@thefor{in partial fulfillment of\\the requirements for the degree of}
\def\@thedoctor{Doctor in}
\def\@thekeywords{Keywords}
\def\@theinfos{Informations}
\def\@theglossary{Glossary}
\def\@theindex{Index}
\def\@thejury{Committee}
%% specific: french
\if@langfrench
  \def\@theby{Une Thèse de doctorat par}
  \def\@theat{présentée à}
  \def\@thefor{pour obtenir le grade de}
  \def\@thedoctor{Docteur en}
  \def\@thekeywords{Mots clefs}
  \def\@theinfos{Informations}
  \def\@theglossary{Glossaire}
  \def\@theindex{Index}
  \def\@thejury{Jury}
  \def\@thefield{Dans le domaine de}
\fi


%% Handling booklet option
\newcounter{modulopage}
\if@booklet
  \setcounter{modulopage}{4}
\else
  \setcounter{modulopage}{2}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Headers

% Author
\def\@email{%
  \ClassError{isirthesis}{No email given}{%
    You must call \protect\email\space in the preamble
    of your document\MessageBreak
    to provide email.}}
\newcommand\email[1]{\gdef\@email{#1}}
\@onlypreamble\email

% General infos
\def\@keywords{%
  \ClassError{isirthesis}{No keywords given}{%
    You must call \protect\keywords\space in the preamble
    of your document\MessageBreak
    to provide keywords.}}
\newcommand\keywords[1]{\gdef\@keywords{#1}}
\@onlypreamble\keywords

% University infos
\def\@university{%
  \ClassError{isirthesis}{No university given}{%
    You must call \protect\university\space in the preamble
    of your document\MessageBreak
    to provide a university.}}
\newcommand\university[1]{\gdef\@university{#1}}
\@onlypreamble\university

% Doctoral school infos
\def\@school{%
  \ClassError{isirthesis}{No doctoral school given}{%
    You must call \protect\school\space in the preamble
    of your document\MessageBreak
    to provide a doctoral school.}}
\newcommand\school[1]{\gdef\@school{#1}}
\@onlypreamble\school

% Laboratory infos
\def\@laboratory{%
  \ClassError{isirthesis}{No doctoral laboratory given}{%
    You must call \protect\laboratory\space in the preamble
    of your document\MessageBreak
    to provide a doctoral laboratory.}}
\newcommand\laboratory[1]{\gdef\@laboratory{#1}}
\@onlypreamble\laboratory

% Speciality infos
\def\@school{%
  \ClassError{isirthesis}{No speciality given}{%
    You must call \protect\speciality\space in the preamble
    of your document\MessageBreak
    to provide a speciality.}}
\newcommand\speciality[1]{\gdef\@speciality{#1}}
\@onlypreamble\speciality

% Jury
\def\@jury{%
  \ClassError{isirthesis}{No jury given}{%
    You must call \protect\jury\space in the preamble
    of your document\MessageBreak
    to provide a jury.}}
\newcommand\jury[1]{\gdef\@jury{#1}}
\@onlypreamble\jury

% Subtitle
\def\@subtitle{}
\newcommand\subtitle[1]{\gdef\@subtitle{#1}}
\@onlypreamble\subtitle

% Global infos
\newcommand\infostext[1]{\gdef\@infostext{
  \thispagestyle{empty}
  ~
  \vfill
  \section*{\@theinfos}#1}
}
\@onlypreamble\infostext

\newcommand\keywordstext[1]{\gdef\@keywordstext{
  \section*{\@thekeywords}#1}
}
\@onlypreamble\keywordstext

\def\@reference{\jobname}

% Handling logo options
\newif\if@logos \@logosfalse
\def\@logos{%
  \ClassInfo{isirthesis}{No logos given}{%
    You must call \protect\logos\space in the preamble
    of your document\MessageBreak
    to provide logos.}}
\newcommand\logos[1]{
  \gdef\@logos{#1}
  \@logostrue
}
\@onlypreamble\logos

% Cover image option
\newif\if@coimage \@coimagefalse
\def\@coverimage{%
  \ClassInfo{isirthesis}{No cover image given}{%
    You must call \protect\coverimage\space in the preamble
    of your document\MessageBreak
    to provide a cover image.}}
\newcommand\coverimage[1]{
  \gdef\@coverimage{#1}
  \@coimagetrue
}
\@onlypreamble\coverimage

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{pgf,tikz}
\usetikzlibrary{
  calc,
  positioning
}

%% Paper layout
\RequirePackage[a4paper,twoside]{geometry}
\geometry{a4paper,inner=2cm, outer=3cm, bottom=2.5cm, top=2.5cm,includefoot,includehead} % default

\@ifpackagelater{geometry}{2010/09/12}{
  \if@print
  \geometry{papersize={22cm,30.7cm},layout=a4paper,layoutvoffset=0.5cm,layouthoffset=0.5cm,showcrop,
	    inner=2cm, outer=3cm, bottom=2.5cm, top=2.5cm,includefoot,includehead}
  \fi
}{}%


%% Links
\RequirePackage{color}
\if@print
  \definecolor{links}{RGB}{00,00,00}
\else
  \definecolor{links}{RGB}{57,74,88}
\fi%

\RequirePackage[xetex,
		colorlinks=true,
		urlcolor=links,       % \href{...}{...} external (URL)
		filecolor=links,     % \href{...} local file
		linkcolor=links,   % \ref{...} and \pageref{...}
		citecolor=links,	     % \cite{...}
		pdfpagemode=UseNone,
		bookmarks, 
		bookmarksnumbered,
		bookmarksopen=true]{hyperref}

%% Acronyms
\RequirePackage[printonlyused,footnote]{acronym}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Headers and Footers
\RequirePackage[bottom]{footmisc} % fixes a problem with footnotes
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{refcount} % provides macro \getpagerefnumber{LastPage}
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}

\fancypagestyle{isirthesis}{
  \fancyfoot[LE]{
    \begin{tikzpicture}[remember picture,overlay] 
      \node[yshift=1.5cm] (LE) at (current page.south west) 
	[align=right,text width=1.1cm, minimum height=2em, fill=black,above right, inner xsep=0.4cm] 
	{% 
	  \hspace*{0.4cm}%
	  \color{white}%
	  {\bfseries\thepage}%
	};
	\node[right=1em of LE] {\nouppercase{\leftmark}};
      \if@gitinfo
	\node[yshift=3cm,rotate=90,below right,gray,inner ysep=0.7cm] at (current page.south west) {GIT : \GITAbrHash{} - \GITCommitterDate{}};
      \fi
    \end{tikzpicture} 
    \begin{tikzpicture}[remember picture,overlay] 
      \node[yshift=-2.5cm-1.5cm*\thefchapter] at (current page.north west) 
	[rotate=90, minimum width=1.5cm, minimum height=0.8cm,
	fill=black,below left, inner xsep=0] 
	{ 
	}; 
    \end{tikzpicture} 
  }
  \fancyfoot[RO]{
    \begin{tikzpicture}[remember picture,overlay] 
      \node[yshift=1.5cm] (RO) at (current page.south east) 
	[align=right,text width=1.1cm, minimum height=2em, fill=black,above left, inner xsep=0.4cm] 
	{%
	  \color{white}%
	  {\bfseries\thepage}%
	  \hspace*{0.4cm}%
	}; 
	\node[left=1em of RO] {\nouppercase{\rightmark}};
      \if@gitinfo
	\node[yshift=3cm,rotate=90,above right,gray,inner ysep=0.7cm] at (current page.south east) {GIT : \GITAbrHash{} - \GITCommitterDate{}};
      \fi
    \end{tikzpicture} 
    \begin{tikzpicture}[remember picture,overlay] 
      \node[yshift=-2.5cm-1.5cm*\thefchapter] at (current page.north east) 
	[rotate=90, minimum width=1.5cm, minimum height=0.8cm,
	 fill=black,above left, inner xsep=0] 
	{ 
	}; 
    \end{tikzpicture} 
  }
  \fancyfoot[C]{}
}
\pagestyle{isirthesis}

\renewcommand\chaptermark[1]{\markboth{#1}{}}
\renewcommand\sectionmark[1]{\markright{\thesection\ #1}}

\renewcommand{\headrulewidth}{0.0pt} 
\renewcommand{\footrulewidth}{0.0pt} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title layout
\RequirePackage{tabularx}

\renewcommand\maketitle{%
  \begin{titlepage}%
    %% cover page
    \if@coimage
      \begin{tikzpicture}[remember picture,overlay] 
	\pgfdeclareimage[width=\textwidth]{cimage}{\@coverimage}
	\node [scale=3, text opacity=0.05] at (current page.center) {\pgfuseimage{cimage}}; 
      \end{tikzpicture} 
    \fi

    %% git info
    \if@gitinfo
      \input{vc.info}
      {GIT : \GITAbrHash{} - \GITCommitterDate{}}
      \vspace{1em}
    \fi
    
    %% possible logos
    \if@logos
      \@logos
    \fi

    \par\vfill
    %% general infos
    \begin{center}
      \@theby

      \vspace{0.5em}

      {\LARGE\href{mailto:\@email}{\@author}}

      \vspace{0.5em}

      \@theat

      \vspace{0.5em}
      
      {\Large\bf\@university}
      
      \vspace{0.5em}

      {\bf\@school}
      
      \vspace{0.5em}
      
      {\bf\@laboratory}
      
      \vspace{0.5em}

      \@thefor

      \vspace{1.0em}

      \@thedoctor\ \@speciality 

      \vspace{1.0cm}

      {\LARGE\bf\@title}

      \vspace{0.5cm}

      {\normalsize\bf\@subtitle}

      \vspace{1.0cm}
      
      \@date
    \end{center}

    %% jury
    \par\vfill
    {
    \@thejury
    \vspace{1em}

    {
      \small
    \begin{tabularx}{\textwidth}{Xr}
      \@jury
    \end{tabularx}}}

    \@thanks
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

\clearpage{\pagestyle{empty}\cleardoublepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chapters layout
\newcounter{fchapter}
\renewcommand\chapter{%
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else 
      \hbox{} 
      \vspace*{\fill} 
      \vspace{\fill} 
      \thispagestyle{empty} 
      \newpage 
      \if@twocolumn
	\hbox{}
	\newpage
      \fi
    \fi
  \fi 
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter
}
\let\oldmakechapterhead=\@makechapterhead
\renewcommand{\@makechapterhead}[1]{% 
    \stepcounter{fchapter}
    \oldmakechapterhead{#1}
    \begin{tikzpicture}[remember picture,overlay] 
      \node[yshift=-2.5cm-1.5cm*\thefchapter] at (current page.north east) 
	[rotate=90, text width=1.5cm, minimum height=1.5cm,text centered,
	 fill=black, above left, inner xsep=0, inner ysep=0.4cm] 
	{\color{white}%
	  {%
	    \ifnum\c@secnumdepth>\m@ne%
	    \huge\thechapter% Chapter number 
	    \fi%
	    \vspace*{0.4cm}%
	  }%
	}; 
    \end{tikzpicture} 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figures
\usepackage[font=small,format=plain,labelfont=bf,up,textfont=it,up]{caption}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Automatic generation of title page
\AtBeginDocument{
  \makeglossaries

  \let\oldand\and
  \let\oldurl\url
  \let\oldhref\href
  \def\and{-~~}
  \def\url#1{#1}
  \def\href#1#2{#2}
  \def\extra#1{}
  \hypersetup{
    pdftitle={\@title},
    pdfauthor={\@author},
    pdfsubject={\@title, \@school, \@date},
    pdfkeywords={\@keywords}
  }
  \def\and{\oldand}
  \def\url{\oldurl}
  \def\href{\oldhref}
  \def\extra#1{#1}

  \setlength\parindent{1em}
  \maketitle
    
  \@infostext
  \@keywordstext

  \setcounter{tocdepth}{1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Table of content
\RequirePackage[nohints,tight]{minitoc}
\setcounter{minitocdepth}{2}
\nomtcrule % remove rules

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bibliography
\RequirePackage[url=false,
		doi=false,
		uniquename=false,
		uniquelist=false,
		style=authoryear-comp,
		sorting=nyt,
		sortcites=false,
		texencoding=utf8,bibencoding=utf8,
		maxnames=2,
		maxbibnames=99,
		hyperref=true]{biblatex}


\defbibheading{bibliography}[\bibname]{%
  \cleardoublepage
  \stepcounter{fchapter}
  \chapter*{#1}%
  \addstarredchapter{\bibname}
  \markboth{#1}{#1}%
}%

\DeclareCiteCommand{\fullcite}
  {\defcounter{maxnames}{\blx@maxbibnames}%
    \usebibmacro{prenote}}
  {\usedriver
     {\DeclareNameAlias{sortname}{default}}
     {\thefield{entrytype}}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

%% Tool to count cited references
\newcounter{refs}
\defbibenvironment{counter}
  {\setcounter{refs}{0}
  \renewcommand{\blx@driver}[1]{}
  }
  {References: \therefs}
  {\stepcounter{refs}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Booklet extra white space
\newcommand{\modulo}[3]{%
  \newcounter{n}
  \newcounter{q}
  
  \setcounter{n}{#1}
  \setcounter{q}{#2}
  \whiledo{\value{n}>\value{q}}{%
    \addtocounter{n}{-\value{q}}
  }
  \setcounter{#3}{\value{n}}
}

\AtEndDocument{%
  \clearpage{\pagestyle{empty}\cleardoublepage}

  \newcounter{r}
  \modulo{\thepage}{\value{modulopage}}{r}

  \whiledo{\value{r}<\value{modulopage}}{
    \addtocounter{r}{1}
    \thispagestyle{empty}
    ~\newpage~
  }

  \thispagestyle{empty}
    \if@coimage
      \begin{tikzpicture}[remember picture,overlay] 
	\pgfdeclareimage[width=\textwidth]{cimage}{\@coverimage}
	\node [scale=3, text opacity=0.05] at (current page.center) {\pgfuseimage{cimage}}; 
      \end{tikzpicture} 
    \else
      ~
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Glossary and index
\RequirePackage[numberedsection=nolabel]{glossaries}

\newcommand{\newentry}[2]{
  \newglossaryentry{#1}{#2}
  \glsunset{#1} % Required if not an acronym (to avoid useless footnote)
}

\newcommand{\tableofglossaries}{
  \clearpage{\pagestyle{empty}\cleardoublepage}
  \printglossary[title=\@theglossary,style=myglossary,toctitle=\@theglossary,numberedsection=false]
  \addstarredchapter{\@theglossary}
}
\newcommand{\tableofindex}{
  \clearpage{\pagestyle{empty}\cleardoublepage}
  \printglossary[title=\@theindex,style=myindex,toctitle=\@theindex,numberedsection=false]
  \addstarredchapter{\@theindex}
}

\RequirePackage{multicol}

\newglossarystyle{myindex}{%
  \glossarystyle{treenonamegroup}
  % put the glossary in the itemize environment:
  \renewenvironment{theglossary}{\begin{multicols}{3}\begin{flushleft}}{\end{flushleft}\end{multicols}}%
  % have nothing after \begin{theglossary}:
  \renewcommand*{\glossaryheader}{}%
  % have nothing between glossary groups:
  \renewcommand*{\glsgroupheading}[1]{\begin{center}\large\bf##1\end{center}}%
  \renewcommand*{\glsgroupskip}{}%
  % set how each entry should appear:
  \renewcommand*{\glossaryentryfield}[5]{%
    \par % bullet point
    \glstarget{##1}{##2}% the entry name
    %\space (##4)% the symbol in brackets
    %\space ##3% the description
    \dotfill
    \space ##5% the number list in square brackets
  }%
 % set how sub-entries appear:
 %\renewcommand*{\glossarysubentryfield}[6]{%
 %  \glossaryentryfield{##2}{##3}{##4}{##5}{##6}}%
}

\newcounter{glogrpc}
\newglossarystyle{myglossary}{%
  \def\curhead{}
  \setcounter{glogrpc}{0}
  \renewenvironment{theglossary}%
    {\begin{longtable}{p{1em}p{.3\textwidth}p{0.65\textwidth}}}%
    {\end{longtable}}%
  \renewcommand*{\glossaryheader}{}%
  \renewcommand*{\glsgroupheading}[1]{\setcounter{glogrpc}{0}\def\curhead{##1}}%
  \newlength{\desclength}%
  \newlength{\symbollength}%
  \renewcommand*{\glossaryentryfield}[5]{%
    \settowidth{\desclength}{##3}%
    \ifthenelse{\desclength > 0}{%
    \settowidth{\symbollength}{##4}%
    \addtocounter{glogrpc}{1}%
    {\bf\curhead} & \glstarget{##1}{##2
	  \ifthenelse{\symbollength > 0}{ (##4)}{} % symbol in brackets
    } \dotfill & ##3\\%
    }{}%
  }%

\renewcommand*{\glsgroupskip}{%
  \ifnum\value{glogrpc}>0 \uppercase{&} \uppercase{&} \\%
\fi%
}%
}

\newacronym{FIXFOOTNOTESFORACRONYMS}{}{}

\endinput

%% isirthesis.cls ends here.
