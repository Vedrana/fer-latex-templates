\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zavrsni}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions

\LoadClass[12pt, onecolumn]{report}

\RequirePackage[a4paper, left=3.5cm, right=3cm, bottom=3cm, top=3cm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[croatian]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
% Za promjenu fonta, umjesto ``times'' paketa učitajte drugi paket, primjerice ``lmodern''
\RequirePackage{times}
% Da bi se promjenio stil citiranja umjesto:
% [authoryear, round]
% staviti:
% [numbers, square]
\RequirePackage[authoryear, round]{natbib}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{fixltx2e}
\RequirePackage[outsidefoot]{pageno}
\RequirePackage{caption}
\RequirePackage{ifthen}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{url}

\renewcommand{\captionlabelfont}{\bfseries}
\renewcommand{\captionfont}{\small}

% 1.5 prored, 1.3 je faktor za množenje
\linespread{1.3}

% Promjena naziva poglavlja ``Bibliografija'' -> ``Literatura''
\addto\captionscroatian{%
	\def\bibname{Literatura}
}

% Podešavanje oznaka kod listi (1. razina je crtica, 2. puni krug) 
\renewcommand{\labelitemi}{\textendash}
\renewcommand{\labelitemii}{\textbullet}

% Dodavanje točke na kraj broja poglavlja, odjeljaka, pododjeljaka ..
\renewcommand\thechapter{\@arabic\c@chapter.}
\renewcommand\thesection{\thechapter\@arabic\c@section.}
\renewcommand\thesubsection{\thesection\@arabic\c@subsection.}
\renewcommand\thesubsubsection{\thesubsection\@arabic\c@subsubsection.}

\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter\fi \@arabic\c@equation}
\renewcommand\thefigure{\ifnum \c@chapter>\z@ \thechapter\fi \@arabic\c@figure}
\renewcommand\thetable{\ifnum \c@chapter>\z@ \thechapter\fi \@arabic\c@table}

% Rimski brojevi stranica za zahvalu i tablicu sadržaja.
\renewcommand{\thepage}{\roman{page}}

% Ispis napomene o umetanju izvornika.
\newcommand{\izvornik}{%
	\newpage
	\thispagestyle{empty}
	\vspace*{\fill}
	\hfil \textsl{Umjesto ove stranice umetnite izvornik Va\v{s}eg rada.} \par \hfil
	\hfil \textsl{Da bi ste uklonili ovu stranicu obri\v{s}ite naredbu \texttt{\@backslashchar izvornik}.} \hfil
	\vspace*{\fill}
}

% Naredba za dodavanje zahvale.
\newcommand{\zahvala}[1]{%
	\newpage
 	\setcounter{page}{3}
	\vspace*{\fill}
	\hfil {\itshape #1}\hfil
	\vspace*{\fill}
}

% TOC
\renewcommand\tableofcontents{%
   \chapter*{\contentsname
   \@mkboth{%
   \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
   \@starttoc{toc}%
}

\newboolean{atappendix}
\setboolean{atappendix}{false}
\newboolean{secondpart}
\setboolean{secondpart}{false}

\renewcommand{\appendix}{
	\setboolean{atappendix}{true}
	\setcounter{chapter}{0}
	\renewcommand{\thechapter}{\Alph{chapter}}
}

\renewcommand{\@makechapterhead}[1]{%
\ifthenelse{\boolean{atappendix}}{
	\vspace*{50\p@}%
	{\setlength{\parskip}{0em} \parindent \z@ \raggedright \normalfont
		\interlinepenalty\@M
		\ifnum \c@secnumdepth >\m@ne
			\Huge\bfseries Dodatak \thechapter \\ #1
			\par\nobreak
		\fi
		\nobreak
		\vskip 40\p@
	}
}
{
	\ifthenelse{\boolean{secondpart}}
	{
	}
	{
		\setcounter{page}{1}
		\renewcommand{\thepage}{\arabic{page}}
		\setboolean{secondpart}{true}
	}

	\vspace*{50\p@}%
	{\setlength{\parskip}{0em} \parindent \z@ \raggedright \normalfont
		\interlinepenalty\@M
		\ifnum \c@secnumdepth >\m@ne
			\Huge\bfseries \thechapter~#1
			\par\nobreak
		\fi
		\nobreak
		\vskip 40\p@
	}
}
}

\renewcommand{\@makeschapterhead}[1]{%
\ifthenelse{\boolean{atappendix}}{
	\vspace*{50\p@}%
	{\setlength{\parskip}{0em} \parindent \z@ \raggedright
		\normalfont
		\interlinepenalty\@Mdef
		\Huge\scshape Dodatak \\ #1\par
		\nobreak
		\vskip 40\p@
	}
}
{
	\vspace*{50\p@}%
	{\setlength{\parskip}{0em} \parindent \z@ \raggedright
		\normalfont
		\interlinepenalty\@M
		\Huge\scshape #1\par
		\nobreak
		\vskip 40\p@
	}
}
}

\def\thesisnumber#1{\gdef\@thesisnumber{#1}}
\def\@thesisnumber{\@latex@warning@no@line{Broj rada nije definiran.
Koristi \noexpand\thesisnumber za definiranje}}

\if@titlepage
	\renewcommand\maketitle{\begin{titlepage}%
	\let\footnotesize\small
	\let\footnoterule\relax

	\begin{center}
		{\large\sffamily SVEU\v{C}ILI\v{S}TE U ZAGREBU}
		
		{\large\bfseries\sffamily FAKULTET ELEKTROTEHNIKE I RA\v{C}UNARSTVA}
	\end{center}
	\vfill
	\begin{center}%
		{\large\sffamily DIPLOMSKI RAD br.~\@thesisnumber \par}%
		\vskip 1em%
		{\huge \bfseries\sffamily \@title \par}%
		\vskip 1em%
		{\large\lineskip .75em%
		\begin{tabular}[t]{c}%
			{\sffamily\@author}
		\end{tabular}\par}%
	\end{center}\par
	\vfill
	\begin{center}
		{\sffamily\large Zagreb, 
		\ifcase\month\or
			sije\v{c}anj\or velja\v{c}a\or o\v{z}ujak\or travanj\or svibanj\or
   	 		lipanj\or srpanj\or kolovoz\or rujan\or listopad\or studeni\or
    			prosinac\fi \space \number\year.%
    	}
	\end{center}
	\end{titlepage}%
	\setcounter{footnote}{0}%
	\global\let\maketitle\relax
% 	\global\let\@thanks\@empty
% 	\global\let\@author\@empty
	\global\let\@date\@empty
	%\global\let\@title\@empty
	%\global\let\title\relax
% 	\global\let\author\relax
	\global\let\date\relax
	\global\let\and\relax
	}
\fi

\newdimen\listindentation
\setlength{\listindentation}{3 em}

\renewenvironment{itemize}%
{
	\setlength{\parskip}{0em}
	\advance\@itemdepth\@ne
	\edef\@itemitem{labelitem\romannumeral\@itemdepth}%

	\begin{list}{\csname\@itemitem\endcsname}{\setlength{\leftmargin}{\listindentation}\setlength{\itemsep}{0 em}\setlength{\topsep}{0 em}}
}%
{\end{list}}

% Naredba \engl
\newcommand{\engl}[1]{(engl.~\emph{#1})}

% Sažetak na hrvatskom
\newenvironment{sazetak}
{
\newpage
\vspace*{\fill}
\thispagestyle{empty}
\begin{center}
  {\bf \@title}
\end{center}
\hspace*{\fill} {\bf Sa\v{z}etak} \hspace*{\fill} \par
\vspace*{25pt}
}
{
\vspace*{\fill}
}

% Ključne riječi na hrvatskom
\newcommand{\kljucnerijeci}[1]
{
\vspace{15pt}
\noindent \textbf{Klju\v{c}ne rije\v{c}i:} #1
}

% Ključne riječi na engleskom
\newcommand{\keywords}[1]
{
\vspace{15pt}
\noindent \textbf{Keywords:} #1
}

% Sažetak na engleskom
\def\engtitle#1{\gdef\@engtitle{#1}}
\def\@engtitle{\@latex@warning@no@line{Engleski naziv rada nije definiran.
Koristi \noexpand\engtitle za definiranje}}
\renewenvironment{abstract}
{
\vspace*{\fill}
\thispagestyle{empty}
\begin{center}
  {\bf \@engtitle}
\end{center}
\hspace*{\fill} {\bf Abstract} \hspace*{\fill} \par
\vspace*{25pt}
}
{
\vspace*{\fill}
}

\endinput
