\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gwu-dissertation-class/dissertation}[2021/11/19]

% class options
% -----------------------------------------------------------------------------

% all other options are passed to LaTeX's report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% process the options passed into this class
\ProcessOptions

% base class
% -----------------------------------------------------------------------------

% this template is modified from the native report class
\LoadClass[12pt, letterpaper, titlepage]{report}

% required packages
% -----------------------------------------------------------------------------

% to check the compiler. We need XeTeX
\RequirePackage{iftex}
\RequireXeTeX  % will stop compiling if not using xetex/xelatex

% geometry sets up the layout/dimensions of the pages
\RequirePackage[top=1in, bottom=1in, lmargin=1.25in, right=1.25in]{geometry}

% etoolbox provides some commands for defining robust macros
\RequirePackage{etoolbox}

% inputenc tells compiler that the input tex files are written with utf8 text.
% It is not required for newer compilers, but we include it here just in case.
\RequirePackage[utf8]{inputenc}

% fontenc change the default font encoding in generated documents from 7bit
% encoding to 8bit encoding. 8bit encoding contains more basic characters.
\RequirePackage[T1]{fontenc}

% fontspec allows us to select modern TTF based font types. Note, this package
% requires XeLaTeX or LuaLaTeX. Math fonts are excluded so we can tune the fonts
% in equations using other packages.
\RequirePackage[no-math]{fontspec}

% unicode-math allows us to use unicode for math symbols.
\RequirePackage{unicode-math}

% biblatex is a modern alternative to bibtex for processing bibliography 
\RequirePackage[backend=biber, style=apa]{biblatex}

% graphicx extend the interface for including graphisc. It provides commands
% including \graphicspath and \DeclareGraphicsExtensions
\RequirePackage{graphicx}

% setspace provides commands to easily change the spacing
\RequirePackage{setspace}

% enumitem gives fine control over itemize list/description
\RequirePackage{enumitem}

% arrayjob provides arrays for holding information of committee members
\RequirePackage{arrayjob}

% pgffor provides for loops
\RequirePackage{multido}

% font type configurations
% -----------------------------------------------------------------------------
\setmainfont{Times New Roman}  % default font (serif family)
\setsansfont{Arial}  % Sans Serif family
\setmonofont{DejaVu Sans Mono}  % monospace (typewritter) family

% math equation style configuration
% -----------------------------------------------------------------------------
\unimathsetup{math-style=ISO}
\unimathsetup{bold-style=ISO}
\unimathsetup{sans-style=italic}
\unimathsetup{nabla=upright}
\unimathsetup{partial=upright}
\unimathsetup{warnings-off={mathtools-colon, mathtools-overbracket}}
\setmathfont{latinmodern-math.otf}

% showing options
% -----------------------------------------------------------------------------
\newif\if@showmsdegree
\@showmsdegreefalse

% macros
% -----------------------------------------------------------------------------
\renewrobustcmd*{\@title}{\{Dissertation Title\}}
\renewrobustcmd*{\title}[1]{\renewrobustcmd*{\@title}{\textbf{#1}}}

\renewrobustcmd*{\@author}{\{Author\}}
\renewrobustcmd*{\author}[1]{\renewrobustcmd*{\@author}{{#1}}}

\newrobustcmd*{\@bsdegree}{B.S.~in \{major\}, \{date\}, and \{intitution\}}
\newrobustcmd*{\bsdegree}[3]{\renewrobustcmd*{\@bsdegree}{B.S.~in {#1}, {#2}, {#3}}}

\newrobustcmd*{\@msdegree}{M.S.~in \{major\}, \{date\}, and \{intitution\}}
\newrobustcmd*{\msdegree}[3]{%
    \renewrobustcmd*{\@msdegree}{M.S.~in {#1}, {#2}, {#3}}\@showmsdegreetrue%
}

\newrobustcmd*{\@defdate}{\{Defense date\}}
\newrobustcmd*{\defdate}[1]{\renewrobustcmd*{\@defdate}{{#1}}}

\newrobustcmd*{\@gradyear}{\{Graduation year\}}
\newrobustcmd*{\gradyear}[1]{\renewrobustcmd*{\@gradyear}{{#1}}}
\newrobustcmd*{\@gradmonth}{\{Graduation month\}}
\newrobustcmd*{\gradmonth}[1]{\renewrobustcmd*{\@gradmonth}{{#1}}}
\newrobustcmd*{\@graddate}{\{Graduation date\}}
\newrobustcmd*{\graddate}[1]{\renewrobustcmd*{\@graddate}{{#1}}}

\newrobustcmd*{\@advisor}{\{Advisor's Name\}\\\{Advisor's title\}}
\newrobustcmd*{\advisor}[2]{\renewrobustcmd*{\@advisor}{{#1}\\{#2}}}

\newrobustcmd*{\@school}{\{Name of your school\}}
\newrobustcmd*{\school}[1]{\renewrobustcmd*{\@school}{{#1}}}

\newarray\committee
\committee(1)={Insert at least one committee member}

% front matter pages
% -----------------------------------------------------------------------------

% custom title page
\renewrobustcmd*{\titlepage}{%
    % title starts from 2in below the paper edge
    \newgeometry{top=2in}%
    % the title page is counted as page i (in roman numeral system)
    \pagenumbering{roman}%
    % but GW doesn't want this page number to show in this page
    \thispagestyle{empty}%
    % all things on this page are center-aligned
    \begin{singlespace}%
        \begin{center}%
            \@title\\*[3\baselineskip]%
            by \@author\\*[3\baselineskip]%
            \@bsdegree\\%
            \if@showmsdegree\@msdegree\\\fi%
            \vspace{2\baselineskip}%
            A Dissertation submitted to:\\*[3\baselineskip]%
            The Faculty of\\%
            The \@school~\\%
            of The George Washington University\\%
            in partial satisfaction of the requirements\\%
            for the degree of Doctor of Philosophy\\*[3\baselineskip]%
            \@gradmonth, \@graddate, \@gradyear\\*[3\baselineskip]%
            Dissertation directed by\\*[\baselineskip]%
            \@advisor\\%
        \end{center}%
    \end{singlespace}%
    \restoregeometry%
}

% certification page
\newrobustcmd*{\certpage}{%
    \newpage%
    \thispagestyle{plain}%
    \begin{doublespace}
        \noindent%
        The \@school~of The George Washington %
        University certifies that \@author~has passed the Final %
        Examination for the degree of Doctor of Philosophy as of \@defdate. %
        This is the final and approved form of the dissertation.
    \end{doublespace}%
    \begin{singlespace}%
        \vspace*{3\baselineskip}%
        \begin{center}%
            \@title\\[3\baselineskip]%
            \@author\\[3\baselineskip]%
        \end{center}%
        Dissertation Research Committee:\\%
        \begin{itemize}[leftmargin=0.5in, itemsep=1\baselineskip]%
            \multido{\i=1+1}{10}{%
                \checkcommittee(\i)%
                \ifemptydata\multidostop\else\item[]\cachedata\fi%
            }%
        \end{itemize}%
    \end{singlespace}
}

% copyright page
\newrobustcmd*{\copyrightpage}{%
    \newpage%
    \vspace*{\fill}%
    \begin{center}%
        © Copyright \@gradyear~by \@author\\%
        All rights reserved%
    \end{center}%
    \vspace*{\fill}%
}


%% thing automatically added after `\begin{document}`
% -----------------------------------------------------------------------------
\AtBeginDocument{%
    % show the title page
    \titlepage%
    \certpage%
    \copyrightpage%
    \newpage%
    % restart page counter using arabic numerals
    \pagenumbering{arabic}%
}
