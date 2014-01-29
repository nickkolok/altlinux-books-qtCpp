\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{altlibrary}[2007/11/19 Class for ALT Linux Library
series books]
\RequirePackage[utf8]{inputenc}
%\RequirePackage[utf8x]{inputenc}
\RequirePackage[english,russian]{babel}
\RequirePackage{calc}
\RequirePackage{indentfirst}
\RequirePackage{ifthen}
\AtEndOfClass{%
%  \RequirePackage[stable]{footmisc}% (re)defines \@mkfoottext, so
                                % should be loaded after memoir class
}
\RequirePackage{graphicx}
\DeclareOption{auto}{%
  \setlength{\emergencystretch}{4pt}
  \tolerance=600
  \hbadness = 2500
}
\DeclareOption{pscyr}{%
  \AtEndOfClass{\RequirePackage{pscyr}
  \renewcommand{\rmdefault}{faq}
  \renewcommand{\ttdefault}{cmtt}
  \renewcommand{\sfdefault}{ftx}}
}
%%% Handling chapter authors
\DeclareOption{sbornik}{%
  \AtBeginDocument{%
    \providecommand{\theauthor}{\relax}
    \newcommand{\thischapterauthor}{\relax}
    \newcommand{\chapauthorfont}{\sffamily\Large}
    \addtoiargdef{\printchaptertitle}{% prepend
      \protected@xdef\thischapterauthor{\theauthor}}{% append
      \par\vspace{\baselineskip}
      {\chapauthorfont\thischapterauthor\hfill\par}}
  }%
}
\newboolean{docs}
\DeclareOption{docs}{%
  \setboolean{docs}{true}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax
\LoadClass[openany]{memoir}
% paper and typeblock formats are set up by separate package
\RequirePackage{format}

% General TeX settings
\widowpenalty=10000
\clubpenalty=10000


% Captions and figure numbering
\captiondelim{. }
\renewcommand{\captionnamefont}{\small\sffamily}
\renewcommand{\captiontitlefont}{\small\rmfamily}
\captionstyle{\centerlastline}
\renewcommand{\thefigure}{\arabic{figure}}

% Headings and sectioning
%% Chapters
\counterwithin*{footnote}{chapter}
\renewcommand{\chaptitlefont}{\sffamily\Huge}
\renewcommand{\chapnamefont}{\sffamily\Huge}
\renewcommand{\chapnumfont}{\sffamily\Huge}
\makechapterstyle{ruled}{%
  \renewcommand{\printchaptertitle}{%
    \protected@xdef\thischapterauthor{\theauthor}}{%
    \hrule height 1pt
    \vspace{\baselineskip}
    \hfill\chapnamefont ##1\par
  }
}
%% Sections
\setsecnumdepth{subsubsection}
\maxsecnumdepth{subsubsection}
\setbeforesecskip{3ex plus .2ex minus .1ex}
\setaftersecskip{2ex plus .2ex}
\setsecheadstyle{\Large\sffamily\bfseries\raggedright}
\setsubsecheadstyle{\large\sffamily\bfseries\raggedright}
\setsubsubsecheadstyle{\normalsize\sffamily\bfseries\raggedright}
%% Bibliographies
\nobibintoc
\renewcommand{\bibsection}{%
%  \section{\bibname}%
   \chapter{\bibname}%
  \prebibhook%
}

% ToC
\setpnumwidth{2.55em}
\setrmarg{3.5em plus 1fil}
\renewcommand{\cftpartfont}{\sffamily\bfseries}
\renewcommand{\cftpartpagefont}{\sffamily\bfseries}
\renewcommand{\cftchapterpagefont}{\sffamily}
\renewcommand{\cftchapterfont}{\sffamily\bfseries}
\renewcommand{\cftchapterpresnum}{\chaptername\space}
\renewcommand{\cftchapteraftersnum}{.}
\renewcommand{\cftsectionfont}{\sffamily}
\renewcommand{\cftsectionpagefont}{\sffamily}
\cftsetindents{chapter}{2em}{5em}
\cftsetindents{section}{2em}{3em}
\renewcommand{\tocheadstart}{\vspace*{-3\baselineskip}\chapterheadstart}


% Pagestyles
\makepagestyle{myheadings}
\aliaspagestyle{part}{empty}
\aliaspagestyle{chapter}{empty}
\aliaspagestyle{title}{myheadings}
\makeheadrule{myheadings}{\textwidth}{\normalrulethickness}
\makeevenhead{myheadings}{{\sffamily\bfseries\thepage}}{}{{\sffamily\leftmark}}
\makeoddhead{myheadings}{{\sffamily\rightmark}}{}{{\sffamily\bfseries\thepage}}
\pagestyle{myheadings}
% headers
\renewcommand{\sectionmark}[1]{\markright{\thesection. #1}}
\renewcommand{\chaptermark}[1]{\markboth{\@chapapp\ \thechapter. \protect#1}%
{\@chapapp\ \thechapter. \protect#1}}
\renewcommand{\partmark}[1]{\markboth{}{}}

% Titlepages
\newcommand{\series}[1]{%
  \global\def\@series{#1}
}
\newcommand{\booktitle}[1]{%
  \global\def\@booktitle{#1}
}
\newcommand{\booksubtitle}[1]{%
  \global\def\@booksubtitle{#1}
}
\newcommand{\coverauthors}[2][]{%
  \global\def\@coverauthors{#2}
  \ifx @#1@
  \let\@bibauthors\relax
  \else
  \global\def\@bibauthors{#1}
  \fi
}
\newcommand{\bibannoteauthors}[1]{%
  \global\def\@bibannoteauthors{#1}
}
\newcommand{\bibnote}[1]{%
  \global\def\@bibnote{#1}
}
\newcommand{\publisher}[2][]{%
  \global\def\@publisher{#2}
  \ifx @#1@
  \let\@bibpublisher\@publisher
  \else
  \global\def\@bibpublisher{#1}
  \fi
}
\newcommand{\pubaddress}[2]{%
  \global\def\@shortpubaddress{#1}
  \global\def\@pubaddress{#2}
}
\newcommand{\pubyear}[1]{%
  \global\def\@pubyear{#1}
}
\newcommand{\classify}[3]{%
  \global\def\@udk{#1}
  \global\def\@bbk{#2}
  \global\def\@authorsign{#3}
}
\newcommand{\annotation}[1]{%
  \global\def\@annotation{#1}
}
\newcommand{\isbn}[1]{%
  \global\def\@isbn{#1}
}
\newcommand{\copyleft}[1]{%
  \global\def\@copyleft{#1}
}
\newcommand{\team}[1]{%
  \global\def\@team{#1}
}
\newcommand{\sales}[1]{%
  \global\def\@sales{#1}
}
\newcommand{\legalnotice}[1]{%
  \global\def\@legalnotice{#1}
}
% strings
\newcommand{\UDK}{\CYRU\CYRD\CYRK}
\newcommand{\BBK}{\CYRB\CYRB\CYRK}
\newcommand{\inseries}{\CYRV\space\cyrs\cyre\cyrr\cyri\cyri}
\newcommand{\seriesname}{\CYRS\cyre\cyrr\cyri\cyrya}
\newcommand{\pageabbr}{\cyrs}
\newcommand{\figabbr}{\cyri\cyrl}
%% Pile up titlepages
\newcommand{\maketitlepages}{%
  % first construct various forms of booktitle for further use on titlepages
  \ifthenelse{\equal{\@booksubtitle}{\empty}}{%
  \let\@fullbooktitle\@booktitle}{%
  \global\def\@fullbooktitle{\@booktitle:\space\@booksubtitle}
}
\global\def\@bibannote{\@booktitle:\space\@booksubtitle\ifx\@bibannoteauthors\undefined\else~/~\@bibannoteauthors\space\fi --- 
  \@shortpubaddress\space: \@bibpublisher, \@pubyear. ---
  \thelastpage\,\pageabbr. : \figabbr. \ifx\@bibnote\undefined\else ; \@bibnote.\fi --- (\@series).}

  \begingroup
  \pagestyle{empty}
%   \setlength{\parindent}{0pt}
  %begin docs titlepage comment
  \ifthenelse{\boolean{docs}}{\vspace*{\stretch{1}}}{%
    \noindent{\Large\texttt{\inseries:\hfill\@series}}%
  }%end docs titlepage comment
  \vspace{\stretch{1}}
  \begin{center}
    {\sffamily\bfseries\Huge\@booktitle\\[1.5ex]\@booksubtitle\par}
  \end{center}
  \vspace{\stretch{1}}
  {\LARGE\sffamily\@coverauthors\par}
  \vspace{\stretch{1}}
  \begin{flushright}
    \sffamily
    \@pubaddress\\ \@publisher\\ \@pubyear
  \end{flushright}
  \clearpage
  % begin docs titlepage comment
  \ifthenelse{\boolean{docs}}{\vspace*{\stretch{1}}\@annotation\par}{%
  \noindent\makebox[3em][l]{\UDK}\@udk\\
  \makebox[3em][l]{\BBK}\@bbk\\
  \makebox[3em]{}\@authorsign
    
  \vspace{\stretch{1}}

  \newlength{\annotwidth}
  \setlength{\annotwidth}{108mm}
  \noindent\begin{minipage}[l]{\annotwidth}
    \setlength{\parindent}{1.5em}
    \addtolength{\annotwidth}{-3em}
    \noindent\parbox[t]{3em}{\hspace*{0pt}\\\@authorsign}%
	\parbox[t]{\annotwidth}{\hspace*{1.5em}\@bibannote}

  \vspace{\baselineskip}

  \begin{adjustwidth}{3em}{0em}
  \hspace*{\parindent}ISBN \@isbn

  \vspace{\baselineskip}
  \begin{footnotesize}
    \@annotation\par

  \begin{flushright}
  \bfseries
  \makebox[3em][l]{\UDK}\makebox[2.5em][l]{\@udk}\\
  \makebox[3em][l]{\BBK}\makebox[2.5em][l]{\@bbk}
  \end{flushright}
  \end{footnotesize}
 \end{adjustwidth}
\end{minipage}
}% end docs titlepage comment
  \vspace{\stretch{1}}

  \begin{center}
  	\bfseries
   \begin{small}
    \@sales
    \end{small}
  \end{center}

  \vspace{\baselineskip}
  
  \begin{footnotesize}
    \@legalnotice
  \end{footnotesize}

  \vspace{\stretch{1}}

  %begin docs titlepage comment
  \ifthenelse{\boolean{docs}}{}{%
 \begin{footnotesize}
  \parbox[t]{.35\linewidth}{\bfseries ISBN \@isbn}\hfill
  \begin{minipage}[t]{0.55\linewidth}
    \hangindent=2em
    \raggedright
    {\everypar{\noindent\copyright{}\quad}\@copyleft\space\@pubyear}
  \end{minipage}
 \end{footnotesize}
 }% end docs titlepage comment
  \clearpage
  \endgroup
}
\newcommand{\pubtype}[1]{%
  \global\def\@pubtype{#1}
}
\newcommand{\signed}[1]{%
  \global\def\@signed{#1}
}
\newcommand{\fullauthors}[1]{%
  \global\def\@fullauthors{#1}
}
\newcommand{\fullpublishers}[1]{%
  \global\def\@fullpublishers{#1}
}
\newcommand{\makefinalpage}{%
  \begingroup
  \clearpage
  \thispagestyle{empty}
  \begin{center}
  \vspace*{\stretch{1}}
  \textit{\@pubtype}\par
  \vspace{\baselineskip}
  \seriesname\space <<\@series>>\par
  \vspace{\baselineskip}
  \@fullauthors\par
  \vspace{\baselineskip}
  \textbf{\@fullbooktitle}\par
  \vspace{2\baselineskip}
  \@team\par
  \vspace{2\baselineskip}
  \@signed\par
  \vspace{2\baselineskip}
  \@fullpublishers\par
  \vspace{7\baselineskip}
  \end{center}
  \endgroup
}
% simple support for ALT docs modules cross referncing
\newcommand{\module}[2][]{\ifthenelse{\equal{#1}{\empty}}{}{%
    \@labelmodule{#1}}
  \input{#2}
}
\newcommand{\@labelmodule}[1]{%
  \renewcommand{\memsecinfo}[5]{%
    \label{#1}
    \renewcommand{\memsecinfo}[5]{\relax}}}

\AtBeginDocument{%
  % delay loading of this package not to interfere with m-k.sty
  \RequirePackage{url}
}
\endinput
