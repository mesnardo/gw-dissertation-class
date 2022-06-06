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
\RequirePackage[dvipsnames]{xcolor}  % provides ways to colorize words (must before hyperref)
\RequirePackage{hyperref}  % helps creating internal/external hyperlinks
\RequirePackage{arrayjobx}  % provides arrays for holding information of committee members
\RequirePackage{multido}  %  provides a for-loop like command (multido)
\RequirePackage[titles]{tocloft}  % fine tunes loc, lof, and lot
\RequirePackage{enumitem}  % fine tunes enumeration/lists
\RequirePackage{nomencl}  % to have a list of symbols
\RequirePackage{indentfirst}  % as its name
\RequirePackage{xparse}  % LaTeX 3 style to define functions
\RequirePackage{caption} % change the formats of fig/table captions


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
\RenewDocumentCommand{\title}{m}{\RenewDocumentCommand{\@title}{}{#1}}  % dissertation title
\RenewDocumentCommand{\author}{m}{\RenewDocumentCommand{\@author}{}{#1}}  % author's name
\NewDocumentCommand{\defdate}{m}{\RenewDocumentCommand{\@defdate}{}{#1}}  % defense date
\NewDocumentCommand{\gradyear}{m}{\RenewDocumentCommand{\@gradyear}{}{#1}}  % degree conferral year
\NewDocumentCommand{\gradmonth}{m}{\RenewDocumentCommand{\@gradmonth}{}{#1}}  % degree conferral month
\NewDocumentCommand{\graddate}{m}{\RenewDocumentCommand{\@graddate}{}{#1}}  % degree conferral date
\NewDocumentCommand{\advisor}{m m}{\RenewDocumentCommand{\@advisor}{}{#1\\#2}}  % advisor's name and title
\NewDocumentCommand{\school}{m}{\RenewDocumentCommand{\@school}{}{#1}}  % the school's name at GW


% content in the dedication, acknowledge, disclaimer, and abstract pages
\NewDocumentCommand{\dedication}{+m}{\RenewDocumentCommand{\@dedication}{}{#1}\showdedicationtrue}
\NewDocumentCommand{\acknowledgments}{+m}{\RenewDocumentCommand{\@acknowledgments}{}{#1}\showacknowledgmentstrue}
\NewDocumentCommand{\disclaimer}{+m}{\RenewDocumentCommand{\@disclaimer}{}{#1}\showdisclaimertrue}
\RenewDocumentCommand{\abstract}{+m}{\RenewDocumentCommand{\@abstract}{}{#1}}
\NewDocumentCommand{\preface}{+m}{\RenewDocumentCommand{\@preface}{}{#1}\showprefacetrue}

% the author's previous degrees
\NewDocumentCommand{\prevdegree}{m}{\@prevdegrees(\the@prevdegreecounter)={#1}\stepcounter{@prevdegreecounter}}

% committee members
\NewDocumentCommand{\committee}{m}{\@committees(\the@committeecounter)={#1}\stepcounter{@committeecounter}}

% line spacing
\NewDocumentCommand{\singlespacing}{}{\RenewExpandableDocumentCommand{\baselinestretch}{}{\@factor@single}\selectfont}
\NewDocumentCommand{\doublespacing}{}{\RenewExpandableDocumentCommand{\baselinestretch}{}{\@factor@double}\selectfont}


% =================================================================================================
% private variables
% =================================================================================================
\RenewDocumentCommand{\@title}{}{\{Dissertation Title\}}  % default value for dissertation title
\RenewDocumentCommand{\@author}{}{\{Author\}}  % default value for author
\NewDocumentCommand{\@defdate}{}{\{Defense date\}}  % default value for defense date
\NewDocumentCommand{\@gradyear}{}{\{Graduation year\}}  % default value for graduation year
\NewDocumentCommand{\@gradmonth}{}{\{Graduation month\}}  % default value for graduation month
\NewDocumentCommand{\@graddate}{}{\{Graduation date\}}  % default value for graduation date
\NewDocumentCommand{\@advisor}{}{\{Advisor's Name\}\\\{Advisor's title\}}  % default value for adviser
\NewDocumentCommand{\@school}{}{\{Name of your school\}}  % default value for school name
\NewDocumentCommand{\@dedication}{}{\{Dedication body\}}  % default content in dedication page
\NewDocumentCommand{\@acknowledgments}{}{\{Acknowledgment body\}}  % default content in acknowledgment page
\NewDocumentCommand{\@disclaimer}{}{\{Disclaimer body\}}  % default content in disclaimer page
\NewDocumentCommand{\@abstract}{}{\{Abstract body\}}  % default content in abstract page
\NewDocumentCommand{\@preface}{}{\{Preface body\}}  % default content in preface page

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

% single-line spacing factor: 0.9517 * 1.208 ~ 1.15 = single-line spacing scale in Google Docs
\NewDocumentCommand{\@factor@single}{}{0.9517241379310345}

% double-line spacing factor: 1.9034 * 1.208 ~ 2.3 = double-line spacing scale in Google Docs
\NewDocumentCommand{\@factor@double}{}{1.903448275862069}


% =================================================================================================
% global format configuration
% =================================================================================================

% margins and dimensions
\geometry{letterpaper, top=1in, bottom=1in, left=1.25in, right=1.25in, footskip=0.25in}

% default is double-line spacing
\doublespacing

% skips between paragraphs
\setlength{\parskip}{8pt\relax}

% indent (package ragged2e handles indentation after \begin{document})
\setlength{\RaggedRightParindent}{0.5in\relax}
\AtBeginEnvironment{figure}{\setlength{\RaggedRightParindent}{0em}}
\AtBeginEnvironment{table}{\setlength{\RaggedRightParindent}{0em}}

% header and footer styles
\pagestyle{fancy}  % use fancyhdr's fancy page style
\fancyhf{}  % clear default LaTeX's plain style
\fancyfoot[C]{\thepage}  % position the page number at the bottom center
\RenewDocumentCommand{\headrulewidth}{}{0pt}  % make header separation line invisible
\RenewDocumentCommand{\footrulewidth}{}{0pt}  % make footer separation line invisible

% force the heading counter visible in text and ToC up to subparagraph
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}

% chapter heading formats
\RenewDocumentCommand{\@makechapterhead}{m}{\@chapterhbase[\chaptername\space\thechapter\ --\ ]{#1}}
\RenewDocumentCommand{\@makeschapterhead}{m}{\@chapterhbase{#1}}

% section, subsection, subsubsection, paragraph, subparagraph
\RenewDocumentCommand{\section}{ s o m }{\@heading{#1}{section}{1}{\z@}[#2]{#3}}
\RenewDocumentCommand{\subsection}{ s o m }{\@heading{#1}{subsection}{2}{0.25in}[#2]{#3}}
\RenewDocumentCommand{\subsubsection}{ s o m }{\@heading{#1}{subsubsection}{3}{0.5in}[#2]{#3}}
\RenewDocumentCommand{\paragraph}{ s o m }{\@heading{#1}{paragraph}{4}{0.75in}[#2]{#3}}
\RenewDocumentCommand{\subparagraph}{ s o m }{\@heading{#1}{subparagraph}{5}{1in}[#2]{#3}}

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
\RenewExpandableDocumentCommand{\theHpart}{}{HPART\thepage}
\RenewExpandableDocumentCommand{\theHchapter}{}{HCHAP\thepage}

% caption format (figures and tables): no smaller than 8pt; single spacing
\captionsetup{format=hang}
\captionsetup{justification=raggedright}
\captionsetup{singlelinecheck=true}
\captionsetup{font={footnotesize, stretch=\@factor@single}}
\captionsetup{labelfont={bf}}
\captionsetup{position=bottom}

% =================================================================================================
% private macros/functions/helpers
% =================================================================================================

% a macro returning a string that will be added to ToC and the PDF's bookmarks
\NewDocumentCommand{\@addanchor}{m m}{\phantomsection\addcontentsline{toc}{#1}{#2}}%

% base macro for chapter headings' format
\NewDocumentCommand{\@chapterhbase}{o m}{%
    \begingroup%
        \singlespacing%
        \IfNoValueTF{#1}
            {\centering\textbf{#2}\par\nobreak}%
            {\centering\textbf{#1#2}\par\nobreak}%
        \vskip -\parskip\relax%
    \endgroup%
    \vskip -\baselineskip\relax\vskip 0pt\relax%
    \begingroup%
        \singlespacing%
        \addvspace{3\baselineskip}%
    \endgroup%
}

% a macro to unify formats for all headers (except for chapters)
\NewDocumentCommand{\@heading}{m m m m o m}{
    \nointerlineskip\relax%
    \removelastskip\relax%
    \begingroup
        \singlespacing
        \addvspace{1\baselineskip}
    \endgroup
    \IfBooleanTF{#1}
        {\@startsection{#2}{#3}{#4}{\z@}{1sp}{\singlespacing\bfseries}*{#6}}
        {
            \IfNoValueTF{#5}
                {\@startsection{#2}{#3}{#4}{\z@}{1sp}{\singlespacing\bfseries}{#6}}
                {\@startsection{#2}{#3}{#4}{\z@}{1sp}{\singlespacing\bfseries}[#5]{#6}}
        }
    \vskip -\parskip\relax%
}

% =================================================================================================
%% front matter: title page
% =================================================================================================
\NewDocumentCommand{\@titlepage}{}{%
    \newgeometry{top=2in, bottom=1in, left=1.25in, right=1.25in}%
    \pagenumbering{roman}  % the title page is counted as page i (in roman numeral system)
    \thispagestyle{empty}  % however, don't actually show the page number at the bottom
    \pdfbookmark[0]{Title Page}{TitlePage}%
    \begingroup%
        \setlength{\parskip}{0pt}%
        \centering%
        \singlespacing%
        \textbf{\@title}\\[3\baselineskip]%
        \textbf{by \@author}\\[3\baselineskip]%
        \multido{\i=1+1}{10}{%
            \check@prevdegrees(\i)\ifemptydata\multidostop\else\cachedata\\\fi%
        }
        \vskip 2\baselineskip\relax%
        A Dissertation submitted to\par\vskip 3\baselineskip\relax%
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
\NewDocumentCommand{\@certpage}{}{%
    \newpage%
    \pdfbookmark[0]{Certification}{CertPage}%
    \begingroup%
        \setlength{\parskip}{0pt}%
        \doublespacing%
        \noindent%
        The \@school~of The George Washington University certifies that \@author~has passed the
        Final Examination for the degree of Doctor of Philosophy as of \@defdate. This is the final
        and approved form of the Dissertation.\par%
    \endgroup%
    \begingroup%
        \setlength{\parskip}{0pt}%
        \singlespacing%
        \vskip 3\baselineskip\relax%
        \begin{center}%
            \textbf{\@title}\\[3\baselineskip]%
            \@author\\[3\baselineskip]%
        \end{center}%
        Dissertation Research Committee:\vskip \baselineskip\relax%
        \begin{description}[
            leftmargin=0.5in, style=multiline, topsep=0pt, partopsep=0pt, %
            itemsep=0pt, parsep=\baselineskip%
        ]%
            \multido{\i=1+1}{10}{%
                \check@committees(\i)%
                \ifemptydata\multidostop\else\item \cachedata\fi%
            }%
        \end{description}%
    \endgroup%
}

% =================================================================================================
% front matter: copyright page
% =================================================================================================
\NewDocumentCommand{\@copyrightpage}{}{%
    \newpage%
    \pdfbookmark[0]{Copyright}{CopyrightPage}%
    \begingroup%
        \singlespacing%
        \vspace*{\fill}  % let latex automatically determine how much vertical space it needs
        \noindent%
        \begin{minipage}[c][3\baselineskip][c]{\textwidth}
            \centering© Copyright \@gradyear~by \@author\\ All rights reserved
        \end{minipage}
        \vspace{\fill}  % let latex automatically determine how much vertical space it needs
    \endgroup%
}

% =================================================================================================
% front matter: dedication page
% =================================================================================================
\NewDocumentCommand{\@dedicationpage}{}{%
    \newpage%
    \@addanchor{chapter}{Dedication}%
    \chapter*{Dedication}\@dedication%
}

% =================================================================================================
% front matter: acknowledgments page
% =================================================================================================
\NewDocumentCommand{\@acknowledgmentspage}{}{%
    \newpage%
    \@addanchor{chapter}{Acknowledgments}%
    \chapter*{Acknowledgments}\@acknowledgments%
}

% =================================================================================================
% front matter: disclaimer page
% =================================================================================================
\NewDocumentCommand{\@disclaimerpage}{}{%
    \newpage%
    \@addanchor{chapter}{Disclaimer}%
    \chapter*{Disclaimer}\@disclaimer%
}

% =================================================================================================
% front matter: abstract
% =================================================================================================
\NewDocumentCommand{\@abstractpage}{}{%
    \newpage%
    \@addanchor{chapter}{Abstract of Dissertation}%
    \chapter*{Abstract of Dissertation}
    {\centering\textbf{\@title}\\}%
    \@abstract%
}


% =================================================================================================
% front matter: table of contents (toc)
% =================================================================================================
\NewDocumentCommand{\@tocpage}{}{%
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
        \RenewDocumentCommand{\cftdotsep}{}{1}%
        \RenewDocumentCommand{\cftchapdotsep}{}{\cftdotsep}%
        % prefix: part
        \RenewDocumentCommand{\cftpartpresnum}{}{Part }%
        % prefix chapter
        \setlength{\cftchapnumwidth}{0.85in}%
        \RenewDocumentCommand{\cftchappresnum}{}{Chapter }%
        \RenewDocumentCommand{\cftchapaftersnum}{}{:}%
        % disable the page numbers for parts
        \cftpagenumbersoff{part}%
        \setlength{\cftparskip}{0pt}%
        \setlength{\parskip}{0pt}%
        % finally show table of content
        \@addanchor{chapter}{Table of Contents}%
        \chapter*{Table of Contents}%
        \vskip -0.6\baselineskip\relax  % to compensate the \cftbeforechapskip
        \@starttoc{toc}%
    \endgroup%
}


% =================================================================================================
% front matter: list of figures (lof)
% =================================================================================================
\NewDocumentCommand{\@lofpage}{}{%
    \newpage%
    \begingroup%
        \singlespacing  % must be first to correctly setup \baselineskip
        \setlength{\parskip}{0pt}%
        \setlength{\cftbeforefigskip}{\baselineskip}  % to simulate double spacing
        \setlength{\cftfigindent}{0in}  % entry indent (spec not found in guidelines)
        \setlength{\cftfignumwidth}{1in}  % label width (spec not found in guidelines)
        \RenewDocumentCommand{\cftdotsep}{}{1}  %% dots
        \RenewDocumentCommand{\cftfigpresnum}{}{Figure }  % label prefix
        \@addanchor{chapter}{List of Figures}
        \chapter*{List of Figures}%
        \vskip -\baselineskip\relax% to compensate the first \cftxxxxbeforeskip
        \@starttoc{lof}  % show lof
    \endgroup%
}


% =================================================================================================
% front matter: list of tables (lot)
% =================================================================================================
\NewDocumentCommand{\@lotpage}{}{%
    \newpage%
    \begingroup%
        \singlespacing  % must be first to correctly setup \baselineskip
        \setlength{\parskip}{0pt}%
        \setlength{\cftbeforetabskip}{\baselineskip}  % to simulate double spacing
        \setlength{\cfttabindent}{0in}  % entry indent (spec not found in guidelines)
        \setlength{\cfttabnumwidth}{1in}  % label width (spec not found in guidelines)
        \RenewDocumentCommand{\cftdotsep}{}{1}  % dots
        \RenewDocumentCommand{\cfttabpresnum}{}{Table }  % label prefix
        \@addanchor{chapter}{List of Tables}
        \chapter*{List of Tables}%
        \vskip -\baselineskip\relax% to compensate the first \cftxxxxbeforeskip
        \@starttoc{lot}  % show lot
    \endgroup%
}


% =================================================================================================
% front matter: list of symbols (los)
% =================================================================================================
\NewDocumentCommand{\@lospage}{}{%
    \begingroup%
        \newpage%
        \singlespacing%
        \RenewDocumentEnvironment{thenomenclature}{}{%
            \begin{description}[%
                left=0pt, style=multiline, topsep=0pt, partopsep=0pt, itemsep=0pt,%
                parsep=\baselineskip]%
        }{%
            \end{description}%
        }%
        \@addanchor{chapter}{List of Symbols}%
        \chapter*{List of Symbols}%
        \printnomenclature%
    \endgroup%
}


% =================================================================================================
% front matter: preface
% =================================================================================================
\NewDocumentCommand{\@prefacepage}{}{%
    \newpage%
    \@addanchor{chapter}{Preface}%
    \chapter*{Preface}\@preface%
}


% =================================================================================================
% lightly adjusting styles for bibliography (if using biblatex)
% =================================================================================================
\NewDocumentCommand{\@adjustbib}{}{%
    \@ifpackageloaded{biblatex}{%
        \AtBeginBibliography{\nointerlineskip\vskip 2\baselineskip\relax\vskip 0pt\relax}
        \RenewDocumentCommand{\bibsetup}{}{%
            \singlespacing%
            \setlength{\bibitemsep}{\baselineskip}%
            \setlength{\parskip}{\z@}%
        }%
    }{%
        \ClassWarningNoLine{gw-dissertation}{%
            Not detecting biblatex. The user has to do the formatting of bibliography manually%
        }%
    }%
}


% =================================================================================================
% custom appendix in the table of content and in the content
% =================================================================================================
\RenewDocumentCommand{\appendix}{}{%
    % write `\RenewDocumentCommand{\cftchapnumwidth}{}{0.96in}` to the *.toc file
    \addtocontents{toc}{%
        \protect\RenewDocumentCommand{\protect\cftchapnumwidth}{}{1.04in}%
    }%
    % write `\RenewDocumentCommand{\cftchappresnum}{Appendix }` to the *.toc file
    \addtocontents{toc}{%
        \protect\RenewDocumentCommand{\protect\cftchappresnum}{}{Appendix }%
    }%
    % write `\RenewDocumentCommand{\cftpartpresnum}{}` to the *.toc file
    \addtocontents{toc}{%
        \protect\RenewDocumentCommand{\protect\cftpartpresnum}{}{}%
    }%
    \phantomsection  % add a virtual section so we can get a bookmark anchor
    \stepcounter{part}  % advance the part counter because `Appendices` serves as a Part
    \RenewDocumentCommand{\chaptername}{}{Appendix}  % change the chapter prefix from Chapter to Appendix
    \setcounter{chapter}{0}  % reset chapter counter because now the chapters represent appendices
    \RenewExpandableDocumentCommand{\thechapter}{}{\Alph{chapter}}  % display the chapter count with uppercase letters
}


% =================================================================================================
%% things to be automatically added right before `\begin{document}`
% =================================================================================================
\AtEndPreamble{%
    \@adjustbib  % adjust bibliography format if using biblatex
    \makenomenclature  % trigger nomenclature generation
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
