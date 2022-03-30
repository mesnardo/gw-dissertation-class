%% =================================================================================================
%%
%% class: gw-dissertation
%% author: Pi-Yueh Chuang (pychuang@gwu.edu)
%% license: BSD-3 license
%%
%% Provide style class for dissertations and theses at the George Washington University in
%% Washington, DC.
%%
%% =================================================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gw-dissertation}[2021/11/19]
\RequirePackage{kvoptions}  % processes key-value options for this class
\RequirePackage{iftex}  % checks the compiler before anything else
\RequireXeTeX  % will stop compiling if not using xetex/xelatex (WE NEED XETEX)


% =================================================================================================
% class options
% =================================================================================================
\SetupKeyvalOptions{family=@classopts, prefix=@classopts@}
\DeclareStringOption[P052]{font}[P052]
\DeclareBoolOption[false]{debug}
\ProcessKeyvalOptions{@classopts}


% =================================================================================================
% base class
% =================================================================================================
\LoadClass[12pt]{report}


% =================================================================================================
% packages for configuring style
% =================================================================================================
\RequirePackage{geometry}  % sets up the layout/dimensions of the pages
\RequirePackage[document]{ragged2e}  % makes text flushed left and ragged right
\RequirePackage{fancyhdr}  % helps to control layout of the footers and headers
\RequirePackage{etoolbox}  % provides some commands for defining robust macros
\RequirePackage[T1]{fontenc}  % use 8bit encoded fonts
\RequirePackage[no-math]{fontspec}  % allows us to use .ttf or .otf fonts
\RequirePackage{unicode-math}  % allows using unicode for math symbols and ISO math standard
\RequirePackage{biblatex}  % a modern alternative to bibtex for processing bibliography
\RequirePackage[dvipsnames]{xcolor}  % provides ways to colorize words (must before hyperref)
\RequirePackage{hyperref}  % helps creating internal/external hyperlinks
\RequirePackage{arrayjobx}  % provides arrays for holding information of committee members
\RequirePackage{multido}  %  provides a for-loop like command (multido)
\RequirePackage[titles]{tocloft}  % fine tunes loc, lof, and lot
\RequirePackage{enumitem}  % fine tunes enumeration/lists
\RequirePackage{nomencl}  % to have a list of symbols
\RequirePackage{indentfirst}


% =================================================================================================
% public options
% =================================================================================================
\newif\ifshowtitle  % whether to show the title page
\newif\ifshowcertification  % whether to show the certification page
\newif\ifshowcopyright  % whether to show the copyright page
\newif\ifshowdedication  % whether to show the dedication page
\newif\ifshowacknowledgments  % whether to show the acknowledgments page
\newif\ifshowdisclaimer  % whether to show the disclaimer page
\newif\ifshowabstract  % whether to show the abstract page
\newif\ifshowtoc  % whether to show toc (table of contents)
\newif\ifshowlof  % whether to show lof (list of figures)
\newif\ifshowlot  % whether to show lot (list of tables)
\newif\ifshowlos  % whether to show los (list of symbols and abbreviations)
\newif\ifshowglossary  % whether to show glossary of terms
\newif\ifshowpreface  % whether to show preface


% =================================================================================================
% default values for public options
% =================================================================================================
\showtitletrue  % required; could be disabled for debug
\showcertificationtrue  % required; could be disabled for debug
\showcopyrighttrue  % optional
\showdedicationfalse  % will be automatically turned on if users call \dedication
\showacknowledgmentsfalse  % will be automatically turned on if users call \acknowledgements
\showdisclaimerfalse  % will be automatically turned on if users call \disclaimer
\showabstracttrue  % required; could be disabled for debug
\showtoctrue  % required; could be disabled for debug
\showloftrue  % required only when there are figures
\showlottrue  % required only when there are tables
\showlostrue  % optional
\showglossarytrue  % optional
\showprefacefalse  % optional; will be turned on automatically if users call \preface


% =================================================================================================
% public functions
% =================================================================================================
\renewrobustcmd*{\title}[1]{\renewrobustcmd*{\@title}{{#1}}}  % dissertation title
\renewrobustcmd*{\author}[1]{\renewrobustcmd*{\@author}{{#1}}}  % author's name
\newrobustcmd*{\defdate}[1]{\renewrobustcmd*{\@defdate}{{#1}}}  % defense date
\newrobustcmd*{\gradyear}[1]{\renewrobustcmd*{\@gradyear}{{#1}}}  % degree conferral year
\newrobustcmd*{\gradmonth}[1]{\renewrobustcmd*{\@gradmonth}{{#1}}}  % degree conferral month
\newrobustcmd*{\graddate}[1]{\renewrobustcmd*{\@graddate}{{#1}}}  % degree conferral date
\newrobustcmd*{\advisor}[2]{\renewrobustcmd*{\@advisor}{{#1}\\{#2}}}  % advisor's name and title
\newrobustcmd*{\school}[1]{\renewrobustcmd*{\@school}{{#1}}}  % the school's name at GW


% content in the dedication, acknowledge, disclaimer, and abstract pages
\newrobustcmd{\dedication}[1]{\renewrobustcmd{\@dedication}{{#1}}\showdedicationtrue}
\newrobustcmd{\acknowledgments}[1]{\renewrobustcmd{\@acknowledgments}{{#1}}\showacknowledgmentstrue}
\newrobustcmd{\disclaimer}[1]{\renewrobustcmd{\@disclaimer}{{#1}}\showdisclaimertrue}
\renewrobustcmd{\abstract}[1]{\renewrobustcmd{\@abstract}{{#1}}}
\newrobustcmd{\preface}[1]{\renewrobustcmd{\@preface}{{#1}}\showprefacetrue}

% the author's previous degrees
\newrobustcmd*{\prevdegree}[1]{\@prevdegrees(\the@prevdegreecounter)={#1}\stepcounter{@prevdegreecounter}}

% committee members
\newrobustcmd*{\committee}[1]{\@committees(\the@committeecounter)={#1}\stepcounter{@committeecounter}}

% line spacing
\newrobustcmd*{\singlespacing}{\renewcommand{\baselinestretch}{\@factor@single}\selectfont}
\newrobustcmd*{\doublespacing}{\renewcommand{\baselinestretch}{\@factor@double}\selectfont}


% =================================================================================================
% private variables
% =================================================================================================
\renewrobustcmd*{\@title}{\{Dissertation Title\}}  % default value for dissertation title
\renewrobustcmd*{\@author}{\{Author\}}  % default value for author
\newrobustcmd*{\@defdate}{\{Defense date\}}  % default value for defense date
\newrobustcmd*{\@gradyear}{\{Graduation year\}}  % default value for graduation year
\newrobustcmd*{\@gradmonth}{\{Graduation month\}}  % default value for graduation month
\newrobustcmd*{\@graddate}{\{Graduation date\}}  % default value for graduation date
\newrobustcmd*{\@advisor}{\{Advisor's Name\}\\\{Advisor's title\}}  % default value for adviser
\newrobustcmd*{\@school}{\{Name of your school\}}  % default value for school name
\newrobustcmd{\@dedication}{\{Dedication body\}}  % default content in dedication page
\newrobustcmd{\@acknowledgments}{\{Acknowledgment body\}}  % default content in acknowledgment page
\newrobustcmd{\@disclaimer}{\{Disclaimer body\}}  % default content in disclaimer page
\newrobustcmd{\@abstract}{\{Abstract body\}}  % default content in abstract page
\newrobustcmd{\@preface}{\{Preface body\}}  % default content in preface page

% use an array to hold previous degree
\newcounter{@prevdegreecounter}
\setcounter{@prevdegreecounter}{1}
\newarray\@prevdegrees
\@prevdegrees(\the@prevdegreecounter)={Insert at least a bachelor's degree}

% use an array to hold committee members
\newcounter{@committeecounter}
\setcounter{@committeecounter}{1}
\newarray\@committees
\@committees(\the@committeecounter)={Insert at least one committee member}

% single-line spacing factor: 0.9875 * 1.208 ~ 1.185 = single-line spacing scale in Microsoft Word
\newrobustcmd*{\@factor@single}{0.9875}

% double-line spacing factor: 1.928 * 1.208 ~ 2.33 = double-line spacing scale in Microsoft Word
\newrobustcmd*{\@factor@double}{1.928}


% =================================================================================================
% private macros/functions
% =================================================================================================
% a macro returning a string that will be added to ToC and the PDF's bookmarks
\newrobustcmd*{\@addanchor}[2]{\phantomsection\addcontentsline{toc}{#1}{#2}}%


% =================================================================================================
% global style configuration
% =================================================================================================

% margins and dimensions
\geometry{letterpaper}
\geometry{top=1in}
\geometry{bottom=1in}
\geometry{left=1.25in}
\geometry{right=1.25in}
\geometry{footskip=0.25in}  % guideline isn't clear it's 0.5 or 0.75in from bottom

% default is double-line spacing
\doublespacing

% skips between paragraphs
\setlength{\parskip}{0pt}

% indent (package ragged2e handles indentation after \begin{document})
\setlength{\RaggedRightParindent}{0.5in}

% header and footer styles
\pagestyle{fancy}  % use fancyhdr's fancy page style
\fancyhf{}  % clear default LaTeX's plain style
\fancyfoot[C]{\thepage}  % position the page number at the bottom center
\renewcommand{\headrulewidth}{0pt}  % make header separation line invisible
\renewcommand{\footrulewidth}{0pt}  % make footer separation line invisible

% force the heading counter visible in text and ToC up to subparagraph
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}

% chapter heading format
\renewcommand{\@makechapterhead}[1]{%
    \singlespacing%
    \begin{Center}\textbf{\chaptername\space\thechapter\ --\ #1}\end{Center}\par%
    \doublespacing%
}

% chapter(with a star) heading format
\renewcommand{\@makeschapterhead}[1]{%
    \singlespacing\begin{Center}\textbf{#1}\end{Center}\par\doublespacing%
}

% heading formats for others
\renewcommand{\section}{\@startsection{section}{1}{\z@}{\z@}{1sp}{\singlespacing\bfseries}}
\renewcommand{\subsection}{\@startsection{subsection}{1}{0.25in}{\z@}{1sp}{\singlespacing\bfseries}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{1}{0.5in}{\z@}{1sp}{\singlespacing\bfseries}}
\renewcommand{\paragraph}{\@startsection{paragraph}{1}{0.75in}{\z@}{1sp}{\singlespacing\bfseries}}
\renewcommand{\subparagraph}{\@startsection{subparagraph}{1}{1in}{\z@}{1sp}{\singlespacing\bfseries}}

% removing extra \addvspace command in LoF and LoT when issuing \chapter
\patchcmd{\Hy@org@chapter}{\addtocontents{lof}{\protect\addvspace{10\p@}}}{}{}{}
\patchcmd{\Hy@org@chapter}{\addtocontents{lot}{\protect\addvspace{10\p@}}}{}{}{}

% allowed fonts
\listadd{\@allowedfonts}{P052}
\listadd{\@allowedfonts}{Pagella}
\listadd{\@allowedfonts}{Palatino}
\listadd{\@allowedfonts}{Times}

% main font configurations
\xifinlist{\@classopts@font}{\@allowedfonts}{%
    \expandafter\ifstrequal\expandafter{\@classopts@font}{P052}{\setmainfont{P052}}{}%
    \expandafter\ifstrequal\expandafter{\@classopts@font}{Pagella}{\setmainfont{Pagella}}{}%
    \expandafter\ifstrequal\expandafter{\@classopts@font}{Palatino}{\setmainfont{Palatino Linotype}}{}%
    \expandafter\ifstrequal\expandafter{\@classopts@font}{Times}{\setmainfont{Times New Roman}}{}
}{% a user provided an unknown font name
    \ClassError{gw-dissertation}{%
        Unknown value: \@classopts@font%
    }{%
        Option `font` encountered an unknown value \@classopts@font%
    }%
}

% default font types for other font families
\setsansfont{Arial}  % Sans Serif family
\setmonofont{DejaVu Sans Mono}  % monospace (typewritter) family


% math equation style configuration
\unimathsetup{math-style=ISO}
\unimathsetup{bold-style=ISO}
\unimathsetup{sans-style=italic}
\unimathsetup{nabla=upright}
\unimathsetup{partial=upright}
\unimathsetup{warnings-off={mathtools-colon, mathtools-overbracket}}
\setmathfont{texgyrepagella-math.otf}

% make sure the hyperlink IDs of chapters and parts are unique even when we restart the counter
% (we restart the counter because appendicies)
\renewcommand{\theHpart}{HPART\thepage}
\renewcommand{\theHchapter}{HCHAP\thepage}

% trigger nomenclature generation
\makenomenclature

% =================================================================================================
%% front matter: title page
% =================================================================================================
\newrobustcmd*{\@titlepage}{%
    \newgeometry{top=2in, bottom=1in, left=1.25in, right=1.25in}%
    \pagenumbering{roman}  % the title page is counted as page i (in roman numeral system)
    \thispagestyle{empty}  % however, don't actually show the page number at the bottom
    \pdfbookmark[0]{Title Page}{TitlePage}%
    \begingroup%
    \Centering%
    \singlespacing%
    \textbf{\@title}\\[3\baselineskip]%
    \textbf{by \@author}\\[3\baselineskip]%
    \multido{\i=1+1}{10}{%
        \check@prevdegrees(\i)\ifemptydata\multidostop\else\cachedata\\\fi%
    }
    \vskip 2\baselineskip%
    A Dissertation submitted to\par\vskip 3\baselineskip
    The Faculty of\\%
    The \@school~\\%
    of The George Washington University\\%
    in partial fulfillment of the requirements\\%
    for the degree of Doctor of Philosophy\\[3\baselineskip]%
    \@gradmonth, \@graddate, \@gradyear\\[3\baselineskip]%
    Dissertation directed by\\[\baselineskip]%
    \@advisor\\%
    \endgroup%
    \restoregeometry%
}

% =================================================================================================
% front matter: certification page
% =================================================================================================
\newrobustcmd*{\@certpage}{%
    \newpage%
    \pdfbookmark[0]{Certification}{CertPage}%
    \begingroup%
    \doublespacing%
    \noindent%
    The \@school~of The George Washington University certifies that \@author~has passed the
    Final Examination for the degree of Doctor of Philosophy as of \@defdate. This is the final
    and approved form of the Dissertation.\par%
    \endgroup%
    \begingroup%
    \singlespacing%
    \vskip 3\baselineskip%
    \begin{center}%
        \textbf{\@title}\\[3\baselineskip]%
        \@author\\[3\baselineskip]%
    \end{center}%
    Dissertation Research Committee:\\[1\baselineskip]%
    \begin{itemize}[leftmargin=0.5in, topsep=0pt]%
        \multido{\i=1+1}{10}{
        \check@committees(\i)%
        \ifemptydata\multidostop\else\item[]\cachedata\fi%
    }%
    \end{itemize}%
    \endgroup%
}

% =================================================================================================
% front matter: copyright page
% =================================================================================================
\newrobustcmd*{\@copyrightpage}{%
    \newpage%
    \pdfbookmark[0]{Copyright}{CopyrightPage}%
    \begingroup%
    \singlespacing%
    \vspace*{\fill}  % let latex automatically determine how much vertical space it needs
    \noindent%
    \begin{minipage}[c][3\baselineskip][c]{\textwidth}
        \Centering© Copyright \@gradyear~by \@author\\ All rights reserved
    \end{minipage}
    \vspace{\fill}  % let latex automatically determine how much vertical space it needs
    \endgroup%
}

% =================================================================================================
% front matter: dedication page
% =================================================================================================
\newrobustcmd*{\@dedicationpage}{%
    \newpage%
    \@addanchor{chapter}{Dedication}%
    \chapter*{Dedication}\@dedication%
}

% =================================================================================================
% front matter: acknowledgments page
% =================================================================================================
\newrobustcmd*{\@acknowledgmentspage}{%
    \newpage%
    \@addanchor{chapter}{Acknowledgments}%
    \chapter*{Acknowledgments}\@acknowledgments%
}

% =================================================================================================
% front matter: disclaimer page
% =================================================================================================
\newrobustcmd*{\@disclaimerpage}{%
    \newpage%
    \@addanchor{chapter}{Disclaimer}%
    \chapter*{Disclaimer}\@disclaimer%
}

% =================================================================================================
% front matter: abstract
% =================================================================================================
\newrobustcmd*{\@abstractpage}{%
    \newpage%
    \@addanchor{chapter}{Abstract of Dissertation}%
    \chapter*{Abstract of Dissertation}
    {\Centering\textbf{\@title}\\}%
    \@abstract%
}


% =================================================================================================
% front matter: table of contents (toc)
% =================================================================================================
\newrobustcmd*{\@tocpage}{%
    \newpage%
    \begingroup%
    \singlespacing  % must be first to correctly setup \baselineskip
    % vertical spacing before entries (to simulate double spacing)
    \setlength{\cftbeforepartskip}{0.6\baselineskip}%
    \setlength{\cftbeforechapskip}{0.6\baselineskip}%
    \setlength{\cftbeforesecskip}{0.6\baselineskip}%
    \setlength{\cftbeforesubsecskip}{0.6\baselineskip}%
    \setlength{\cftbeforesubsubsecskip}{0.6\baselineskip}%
    \setlength{\cftbeforeparaskip}{0.6\baselineskip}%
    \setlength{\cftbeforesubparaskip}{0.6\baselineskip}%
    % indent of each entries (spec not found in guidelines)
    \setlength{\cftpartindent}{0in}%
    \setlength{\cftchapindent}{0in}%
    \setlength{\cftsecindent}{0.25in}%
    \setlength{\cftsubsecindent}{0.5in}%
    \setlength{\cftsubsubsecindent}{0.75in}%
    \setlength{\cftparaindent}{1in}%
    \setlength{\cftsubparaindent}{1.25in}%
    % dots
    \renewrobustcmd*{\cftdotsep}{1}%
    \renewrobustcmd*{\cftchapdotsep}{\cftdotsep}%
    % prefix: part
    \renewrobustcmd*{\cftpartpresnum}{Part }%
    % prefix chapter
    \setlength{\cftchapnumwidth}{0.85in}%
    \renewrobustcmd*{\cftchappresnum}{Chapter }%
    \renewrobustcmd*{\cftchapaftersnum}{:}%
    % disable the page numbers for parts
    \cftpagenumbersoff{part}%
    \setlength{\cftparskip}{0pt}%
    \setlength{\parskip}{0pt}%
    % finally show table of content
    \@addanchor{chapter}{Table of Contents}%
    \chapter*{Table of Contents}%
    \singlespacing  % to revert the \doublespacing added by \chapter*
    \vskip 0.4\baselineskip  % to compensate the \cftbeforechapskip
    \@starttoc{toc}%
    \endgroup%
}


% =================================================================================================
% front matter: list of figures (lof)
% =================================================================================================
\newrobustcmd*{\@lofpage}{%
    \newpage%
    \begingroup%
    \singlespacing  % must be first to correctly setup \baselineskip
    \setlength{\cftbeforefigskip}{\baselineskip}  % to simulate double spacing
    \setlength{\cftfigindent}{0in}  % entry indent (spec not found in guidelines)
    \setlength{\cftfignumwidth}{1in}  % label width (spec not found in guidelines)
    \renewrobustcmd*{\cftdotsep}{1}  %% dots
    \renewrobustcmd*{\cftfigpresnum}{Figure }  % label prefix
    \@addanchor{chapter}{List of Figures}
    \chapter*{List of Figures}%
    \singlespacing  % to revert the \doublespacing added by \chapter*
    \@starttoc{lof}  % show lof
    \endgroup%
}


% =================================================================================================
% front matter: list of tables (lot)
% =================================================================================================
\newrobustcmd*{\@lotpage}{%
    \newpage%
    \begingroup%
    \singlespacing  % must be first to correctly setup \baselineskip
    \setlength{\cftbeforetabskip}{\baselineskip}  % to simulate double spacing
    \setlength{\cfttabindent}{0in}  % entry indent (spec not found in guidelines)
    \setlength{\cfttabnumwidth}{1in}  % label width (spec not found in guidelines)
    \renewrobustcmd*{\cftdotsep}{1}  % dots
    \renewrobustcmd*{\cfttabpresnum}{Table }  % label prefix
    \@addanchor{chapter}{List of Tables}
    \chapter*{List of Tables}%
    \singlespacing  % to revert the \doublespacing added by \chapter*
    \@starttoc{lot}  % show lot
    \endgroup%
}


% =================================================================================================
% front matter: list of symbols (los)
% =================================================================================================
\newrobustcmd*{\@lospage}{%
    \begingroup%
    \newpage%
    \renewenvironment{thenomenclature}{%
        \begin{description}[%
            left=0pt, style=multiline, topsep=0pt, partopsep=0pt, itemsep=0pt,%
            parsep=\baselineskip]%
    }{%
        \end{description}%
    }%
    \@addanchor{chapter}{List of Symbols}%
    \chapter*{List of Symbols}%
    \singlespacing%
    \vskip \baselineskip%
    \printnomenclature%
    \endgroup%
}


% =================================================================================================
% front matter: preface
% =================================================================================================
\newrobustcmd*{\@prefacepage}{%
    \newpage%
    \@addanchor{chapter}{Preface}%
    \chapter*{Preface}\@preface%
}


% =================================================================================================
% custom appendix in the table of content and in the content
% =================================================================================================
\renewcommand*{\appendix}{%
    % write `\renewrobustcmd*{\cftchapnumwidth}{0.96in}` to the *.toc file
    \addtocontents{toc}{%
        \protect\renewrobustcmd*{\protect\cftchapnumwidth}{1.04in}%
    }%
    % write `\renewrobustcmd*{\cftchappresnum}{Appendix }` to the *.toc file
    \addtocontents{toc}{%
        \protect\renewrobustcmd*{\protect\cftchappresnum}{Appendix }%
    }%
    % write `\renewrobustcmd*{\cftpartpresnum}{}` to the *.toc file
    \addtocontents{toc}{%
        \protect\renewrobustcmd*{\protect\cftpartpresnum}{}%
    }%
    \phantomsection  % add a virtual section so we can get a bookmark anchor
    %\addcontentsline{toc}{part}{Appendices}  % add `Appendices` as a part in ToC
    \stepcounter{part}  % advance the part counter because `Appendices` serves as a Part
    \renewcommand\chaptername{Appendix}  % change the chapter prefix from Chapter to Appendix
    \setcounter{chapter}{0}  % reset chapter counter because now the chapters represent appendices
    \renewcommand{\thechapter}{\Alph{chapter}}  % display the chapter count with uppercase letters
}


% =================================================================================================
%% things to be automatically added after `\begin{document}`
% =================================================================================================
\AtBeginDocument{%
    \ifshowtitle\@titlepage\fi%
    \ifshowcertification\@certpage\fi%
    \ifshowcopyright\@copyrightpage\fi%
    \ifshowdedication\@dedicationpage\fi%
    \ifshowacknowledgments\@acknowledgmentspage\fi%
    \ifshowdisclaimer\@disclaimerpage\fi%
    \ifshowabstract\@abstractpage\fi%
    \ifshowtoc\@tocpage\fi%
    \ifshowlof\@lofpage\fi%
    \ifshowlot\@lotpage\fi%
    \ifshowlos\@lospage\fi%
    %\ifshowglossary\newpage\glossary\fi%
    \ifshowpreface\@prefacepage\fi%
    \newpage%
    \pagenumbering{arabic}  % restart page counter using arabic numerals
}


% =================================================================================================
% extra settings for debug mode
% =================================================================================================
\if@classopts@debug%
    \geometry{showframe}%
    \RequirePackage{eso-pic}%
    \RequirePackage{tikz}
    \AddToShipoutPictureBG{%
        \begin{tikzpicture}[opacity=0.25]%
            \filldraw[step=0.2in, line width=0.4pt, BlueGreen] %
                (0pt, 0pt) grid (\paperwidth, \paperheight);%
            \filldraw[step=1in, line width=0.75pt, BlueGreen] %
                (0pt, 0pt) grid (\paperwidth, \paperheight);%
        \end{tikzpicture}%
    }%
\else%
    \hypersetup{hidelinks}%
\fi
