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
\RequirePackage[utf8]{inputenc}  % tells compiler the files are written in utf-8 text
\RequirePackage[T1]{fontenc}  % use 8bit encoded fonts
\RequirePackage[no-math]{fontspec}  % allows us to use .ttf or .otf fonts
\RequirePackage{unicode-math}  % allows using unicode for math symbols and ISO math standard
\RequirePackage{biblatex}  % a modern alternative to bibtex for processing bibliography 
\RequirePackage{setspace}  % provides convenient commands to switch line spacing
\RequirePackage[dvipsnames]{xcolor}  % provides ways to colorize words (must before hyperref)
\RequirePackage{hyperref}  % helps creating internal/external hyperlinks
\RequirePackage{arrayjobx}  % provides arrays for holding information of committee members
\RequirePackage{multido}  %  provides a for-loop like command (multido)
\RequirePackage{tocloft}  % fine tunes loc, lof, and lot


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

\newlength\@oldindent  % holding users' previous indent length


% =================================================================================================
% public options
% =================================================================================================
\newif\ifshowdedication  % whether to show the dedication page
\newif\ifshowacknowledgments  % whether to show the acknowledgments page
\newif\ifshowdisclaimer  % whether to show the disclaimer page
\newif\ifshowlof  % whether to show lof (list of figures)
\newif\ifshowlot  % whether to show lot (list of tables)


% =================================================================================================
% default values for public options
% =================================================================================================
\showdisclaimerfalse  % will be automatically turned on if users provide disclaimer
\showdedicationfalse  % will be automatically turned on if users provide dedication
\showacknowledgmentsfalse  % will be automatically turned on if users provide acknowledge
\showloftrue
\showlottrue


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

% the author's previous degrees
\newrobustcmd*{\prevdegree}[1]{\@prevdegrees(\the@prevdegreecounter)={#1}\stepcounter{@prevdegreecounter}}

% committee members
\newrobustcmd*{\committee}[1]{\@committees(\the@committeecounter)={#1}\stepcounter{@committeecounter}}


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

% default line spacing
\doublespacing

% paragraph spacing (extra 0.4 lines on top of double-line spacing; not mentioned in guideline);
\setlength{\parskip}{0.4\baselineskip}

% header and footer styles
\pagestyle{fancy}  % use fancyhdr's fancy page style
\fancyhf{}  % clear default LaTeX's plain style
\fancyfoot[C]{\thepage}  % position the page number at the bottom center
\renewcommand{\headrulewidth}{0pt}  % make header separation line invisible
\renewcommand{\footrulewidth}{0pt}  % make footer separation line invisible

% indentation
\setlength{\parindent}{0.5in}

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


% =================================================================================================
% math equation style configuration
% =================================================================================================
\unimathsetup{math-style=ISO}
\unimathsetup{bold-style=ISO}
\unimathsetup{sans-style=italic}
\unimathsetup{nabla=upright}
\unimathsetup{partial=upright}
\unimathsetup{warnings-off={mathtools-colon, mathtools-overbracket}}
\setmathfont{texgyrepagella-math.otf}

% =================================================================================================
% hyperlinks of PDF bookmarks. By default, hyperlinks are set to be the
% displayed counters of parts, chapters, etc. When we reset the displayed
% counters, it makes different chapters, for example, share the same hyperlinks
% (because both have the same displayed counter value). We need to make them
% independent to displayed counters because we will reset displayed chapter
% counter for appendices. Only parts and chapters have to be handled because
% section, subsection, etc., by default, are prefixed with chapters' hyperlink
% names, meaning as long as chapters' hyperlinks are unique, their hyperlinks
% are also unique.
% =================================================================================================
\renewcommand{\theHpart}{HPART\thepage}
\renewcommand{\theHchapter}{HCHAP\thepage}


% =================================================================================================
%% special pages' configurations
% =================================================================================================

% custom title page
% -----------------------------------------------
\renewrobustcmd*{\titlepage}{%
    % temporarily change the layout: title starts from 2in below the paper edge
    \newgeometry{top=2in, bottom=1in, left=1.25in, right=1.25in}%
    % the title page is counted as page i (in roman numeral system)
    \pagenumbering{roman}%
    % but GW doesn't want this page number to show in this title page
    \thispagestyle{empty}%
    % add a bookmark manually so hyperref knows what page this is
    \phantomsection%
    % add this page's book mark to PDF's data so PDF viewers know where this page is
    \pdfbookmark[0]{Title Page}{\thepage}%
    % all things on this page are center-aligned
    \begin{singlespace}%
        \begin{center}%
            % title: boldface, 12pt, followed by a 3-line space
            {\normalsize\textbf{\@title}}\\*[3\baselineskip]%
            % author: 12pt, follow by a 3-line space
            by \@author\\*[3\baselineskip]%
            % loop over previous degrees
            \multido{\i=1+1}{10}{%
                \check@prevdegrees(\i)%
                \ifemptydata%
                    \multidostop%
                \else%
                    \cachedata\\%
                \fi%
            }
            % add a 2-line space after all previous degrees
            \vspace{2\baselineskip}%
            % submission info header: 12pt followed by 3-line space
            A Dissertation submitted to:\\*[3\baselineskip]%
            % submission info (line breaks are hard-coded): followed by 3-line space
            The Faculty of\\%
            The \@school~\\%
            of The George Washington University\\%
            in partial satisfaction of the requirements\\%
            for the degree of Doctor of Philosophy\\*[3\baselineskip]%
            % degree conferral date: 12pt followed by 3-line space
            \@gradmonth, \@graddate, \@gradyear\\*[3\baselineskip]%
            % advisor: 12pt followed by 3-line space
            Dissertation directed by\\*[\baselineskip]%
            \@advisor\\%
        \end{center}%
    \end{singlespace}%
    % restore to default page layout
    \restoregeometry%
}

% certification page
% -----------------------------------------------
\newrobustcmd*{\certpage}{%
    % force the layout, so users' original layouts don't matter
    \newgeometry{top=1in, bottom=1in, left=1.25in, right=1.25in}%
    % add a bookmark manually so hyperref knows what page this is
    \phantomsection%
    % add this page's book mark to PDF's data so PDF viewers know where this page is
    \pdfbookmark[0]{Certification}{\thepage}%
    \begin{doublespace}
        % required text
        \noindent%
        The \@school~of The George Washington %
        University certifies that \@author~has passed the Final %
        Examination for the degree of Doctor of Philosophy as of \@defdate. %
        This is the final and approved form of the dissertation.
    \end{doublespace}
    \begin{singlespace}%
        \vspace*{3\baselineskip}%
        % title and author
        \begin{center}%
            \textbf{\@title}\\[3\baselineskip]%
            \@author\\[3\baselineskip]%
        \end{center}%
        % committee members
        Dissertation Research Committee:\\%
        \begin{itemize}[leftmargin=0.5in, topsep=0pt]%
            \multido{\i=1+1}{10}{%
                \check@committees(\i)%
                \ifemptydata\multidostop\else\item[]\cachedata\fi%
            }%
        \end{itemize}%
    \end{singlespace}
    % restore to users' original page layout
    \restoregeometry%
}

% copyright page
% -----------------------------------------------
\newrobustcmd*{\copyrightpage}{%
    % force the layout, so users' original layouts don't matter
    \newgeometry{top=1in, bottom=1in, left=1.25in, right=1.25in}%
    % add a bookmark manually so hyperref knows what page this is
    \phantomsection%
    % add this page's book mark to PDF's data so PDF viewers know where this page is
    \pdfbookmark[0]{Copyright}{\thepage}%
    \begin{singlespace}
        % let latex automatically determine how much vertical space it needs
        \vspace*{\fill}%
        % copyright text
        \begin{center}%
            © Copyright \@gradyear~by \@author\\%
            All rights reserved%
        \end{center}%
        % let latex automatically determine how much vertical space it needs
        \vspace*{\fill}%
    \end{singlespace}
    % restore to users' original page layout
    \restoregeometry%
}

% dedication
% -----------------------------------------------
\newrobustcmd*{\dedicationpage}{%
    % force the layout, so users' original layouts don't matter
    \newgeometry{top=1in, bottom=1in, left=1.25in, right=1.25in}%
    % add to the table of contents
    \phantomsection\addcontentsline{toc}{chapter}{Dedication}%
    % copy the old indent setting
    \setlength{\@oldindent}{\parindent}%
    % enforce the indent length
    \setlength{\parindent}{0in}%
    % title of this specific page
    \begin{singlespace}%
        \begin{center}\textbf{Dedication}\\[2\baselineskip]\end{center}%
    \end{singlespace}%
    % content body
    \begin{doublespace}%
        \@dedication%
    \end{doublespace}%
    % restore to the old indent
    \setlength{\parindent}{\@oldindent}%
    % restore to users' original page layout
    \restoregeometry%
}

% acknowledgments
% -----------------------------------------------
\newrobustcmd*{\acknowledgmentspage}{%
    % force the layout, so users' original layouts don't matter
    \newgeometry{top=1in, bottom=1in, left=1.25in, right=1.25in}%
    % add to the table of contents
    \phantomsection\addcontentsline{toc}{chapter}{Acknowledgments}%
    % copy the old indent setting
    \setlength{\@oldindent}{\parindent}%
    % enforce the indent length
    \setlength{\parindent}{0.5in}%
    % title of this specific page
    \begin{singlespace}%
        \begin{center}\textbf{Acknowledgments}\\[2\baselineskip]\end{center}%
    \end{singlespace}%
    % content body
    \begin{doublespace}%
        \@acknowledgments%
    \end{doublespace}%
    % restore to the old indent
    \setlength{\parindent}{\@oldindent}%
    % restore to users' original page layout
    \restoregeometry%
}

% dedication
% -----------------------------------------------
\newrobustcmd*{\disclaimerpage}{%
    % force the layout, so users' original layouts don't matter
    \newgeometry{top=1in, bottom=1in, left=1.25in, right=1.25in}%
    % add to the table of contents
    \phantomsection\addcontentsline{toc}{chapter}{Disclaimer}%
    % copy the old indent setting
    \setlength{\@oldindent}{\parindent}%
    % enforce the indent length
    \setlength{\parindent}{0in}%
    % title of this specific page
    \begin{center}\textbf{Disclaimer}\\[2\baselineskip]\end{center}%
    \@disclaimer%
    % restore to the old indent
    \setlength{\parindent}{\@oldindent}%
    % restore to users' original page layout
    \restoregeometry%
}

% abstract
% -----------------------------------------------
\newrobustcmd*{\abstractpage}{%
    % force the layout, so users' original layouts don't matter
    \newgeometry{top=1in, bottom=1in, left=1.25in, right=1.25in}%
    % add to the table of contents
    \phantomsection\addcontentsline{toc}{chapter}{Abstract of Dissertation}%
    % headers
    \begin{singlespace}
        \begin{center}
            \textbf{Abstract of Dissertation}\\[2\baselineskip]
            \textbf{\@title}\\[2\baselineskip]  % GW says using normal font, but SEAS says boldface
        \end{center}
    \end{singlespace}
    % copy the old indent setting
    \setlength{\@oldindent}{\parindent}%
    % enforce the indent length
    \setlength{\parindent}{0.5in}%
    % content body
    \begin{doublespace}
        \@abstract
    \end{doublespace}
    % restore to the old indent
    \setlength{\parindent}{\@oldindent}%
    % restore to users' original page layout
    \restoregeometry%
}

% ToC, LoF, and LoT
% -----------------------------------------------

% cheat on tocloft package so that we have more explicit controls over the format
\@cfthaschapterfalse

% a macro to return a string that will be added to ToC and the PDF's bookmarks
\newrobustcmd*{\@anchoredtitle}[1]{\phantomsection\addcontentsline{toc}{chapter}{#1}#1}%

% the title of ToC
\renewrobustcmd*{\contentsname}{\@anchoredtitle{Table of Contents}}
\renewrobustcmd*{\cfttoctitlefont}{\hfill\normalsize\bfseries}
\renewrobustcmd*{\cftaftertoctitle}{\hfill}
\setlength{\cftbeforetoctitleskip}{0\baselineskip}
\setlength{\cftaftertoctitleskip}{0\baselineskip}

% the title of LoF
\renewrobustcmd*{\listfigurename}{\@anchoredtitle{List of Figures}}
\renewrobustcmd*{\cftloftitlefont}{\hfill\normalsize\bfseries}
\renewrobustcmd*{\cftafterloftitle}{\hfill}
\setlength{\cftbeforeloftitleskip}{0\baselineskip}
\setlength{\cftafterloftitleskip}{0\baselineskip}

% the title of LoT
\renewrobustcmd*{\listtablename}{\@anchoredtitle{List of Tables}}
\renewrobustcmd*{\cftlottitlefont}{\hfill\normalsize\bfseries}
\renewrobustcmd*{\cftafterlottitle}{\hfill}
\setlength{\cftbeforelottitleskip}{0\baselineskip}
\setlength{\cftafterlottitleskip}{0\baselineskip}

% vertical spacing before entries (spec not found in any GW formatting guideline)
\setlength{\cftbeforepartskip}{0\baselineskip}
\setlength{\cftbeforechapskip}{0\baselineskip}
\setlength{\cftbeforesecskip}{0\baselineskip}
\setlength{\cftbeforesubsecskip}{0\baselineskip}
\setlength{\cftbeforesubsubsecskip}{0\baselineskip}
\setlength{\cftbeforeparaskip}{0\baselineskip}
\setlength{\cftbeforesubparaskip}{0\baselineskip}
\setlength{\cftbeforefigskip}{0\baselineskip}
\setlength{\cftbeforetabskip}{0\baselineskip}

% indent of each entries (spec not found in any GW formatting guideline)
\setlength{\cftpartindent}{0in}
\setlength{\cftchapindent}{0in}
\setlength{\cftsecindent}{0.1in}
\setlength{\cftsubsecindent}{0.2in}
\setlength{\cftsubsubsecindent}{0.3in}
\setlength{\cftparaindent}{0.4in}
\setlength{\cftsubparaindent}{0.5in}
\setlength{\cftfigindent}{0in}
\setlength{\cfttabindent}{0in}

% single spacing inside each entry (happens when a chap/sec/subsec title is too long)
\let\@old@l@chapter\l@chapter
\let\@old@l@section\l@section
\let\@old@l@subsection\l@subsection
\let\@old@l@subsubsection\l@subsubsection
\renewrobustcmd*{\l@chapter}[2]{\singlespacing\@old@l@chapter{#1}{#2}\doublespacing}
\renewrobustcmd*{\l@section}[2]{\singlespacing\@old@l@section{#1}{#2}\doublespacing}
\renewrobustcmd*{\l@subsection}[2]{\@old@l@subsection{#1}{#2}\doublespacing}
\renewrobustcmd*{\l@subsubsection}[2]{\singlespacing\@old@l@subsubsection{#1}{#2}\doublespacing}

% dots
\renewrobustcmd*{\cftdotsep}{1}
\renewrobustcmd*{\cftchapdotsep}{\cftdotsep}

% prefix: part
\renewrobustcmd*{\cftpartpresnum}{Part }

% prefix chapter
\setlength{\cftchapnumwidth}{0.85in}
\renewrobustcmd*{\cftchappresnum}{Chapter }
\renewrobustcmd*{\cftchapaftersnum}{:}

% disable the page numbers for parts
\cftpagenumbersoff{part}

% custom appendix in the table of content and in the content
% -----------------------------------------------------------------------------
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
    \addcontentsline{toc}{part}{Appendices}  % add `Appendices` as a part in ToC
    \stepcounter{part}  % advance the part counter because `Appendices` serves as a Part
    \renewcommand\chaptername{Appendix}  % change the chapter prefix from Chapter to Appendix
    \setcounter{chapter}{0}  % reset chapter counter because now the chapters represent appendices
    \renewcommand{\thechapter}{\Alph{chapter}}  % display the chapter count with uppercase letters
}


% =================================================================================================
% end-user command to show front pages
% =================================================================================================
\newrobustcmd*{\frontpages}{%
    \titlepage%
    \certpage%
    \copyrightpage%
    \ifshowdedication\dedicationpage\fi%
    \ifshowacknowledgments\acknowledgmentspage\fi%
    \ifshowdisclaimer\disclaimerpage\fi%
    \abstractpage%
    \tableofcontents%
    \newpage%
    \ifshowlof\listoffigures\fi%
    \newpage%
    \ifshowlot\listoftables\fi%
}


% =================================================================================================
%% things to be automatically added after `\begin{document}`
% =================================================================================================
\AtBeginDocument{%
    \frontpages
    \newpage%
    \pagenumbering{arabic}  % restart page counter using arabic numerals
}


% =================================================================================================
% extra settings for debug mode
% =================================================================================================
\if@classopts@debug%
    \geometry{showframe}%
\else%
    \hypersetup{hidelinks}%
\fi
