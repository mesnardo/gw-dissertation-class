\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gw-dissertation-class/gw-dissertation}[2021/11/19]

% class options
% -----------------------------------------------------------------------------

% enable debug mode
\DeclareOption{debug}{\newcommand*{\@debug}{}}

% all other options are passed to LaTeX's report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

% process the options passed into this class
\ProcessOptions

% base class
% -----------------------------------------------------------------------------

% this template is modified from the native report class w/ default fontsize 12pt
\LoadClass[12pt]{report}

% required packages
% -----------------------------------------------------------------------------

% iftex checks the compiler
\RequirePackage{iftex}
\RequireXeTeX  % will stop compiling if not using xetex/xelatex (We need XeTeX)

% geometry sets up the layout/dimensions of the pages
\RequirePackage{geometry}

\RequirePackage[document]{ragged2e}

% fancyhdr helps to control layout of the footers and headers
\RequirePackage{fancyhdr}

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
% in math equations using other packages.
\RequirePackage[no-math]{fontspec}

% unicode-math allows us to use unicode for math symbols and ISO math standard.
\RequirePackage{unicode-math}

% biblatex is a modern alternative to bibtex for processing bibliography 
\RequirePackage{biblatex}

% setspace provides commands to easily change the spacing. Default to double
% spacing
\RequirePackage{setspace}

% xcolor package provides ways to colorize words. Must be imported before hyperref.
\RequirePackage[dvipsnames]{xcolor}

% hyperref helps in creating internal/external hyperlinks
\RequirePackage{hyperref}

% GW's front pages
\RequirePackage{gw-dissertation-class/gw-frontpages}

% default page layout
% -----------------------------------------------------------------------------

% margins and dimensions
\geometry{letterpaper}
\geometry{top=1in}
\geometry{bottom=1in}
\geometry{left=1.25in}
\geometry{right=1.25in}
\geometry{footskip=0.25in}  % guideline isn't clear it's 0.5 or 0.75in from bottom

% default line spacing
\doublespacing

% paragraph spacing (extra 0.4 lines on top of double-line spacing);
% Note: paragraph spacing not mentioned in GW guideline.
\setlength{\parskip}{0.4\baselineskip}

% header and footer style
\pagestyle{fancy}  % use fancyhdr's fancy page style
\fancyhf{}  % clear default LaTeX's plain style
\fancyfoot[C]{\thepage}  % position the page number at the bottom center
\renewcommand{\headrulewidth}{0pt}  % make header separation line invisible
\renewcommand{\footrulewidth}{0pt}  % make footer separation line invisible

% indentation
\setlength{\parindent}{0.5in}

% font type configurations
% -----------------------------------------------------------------------------

% Times New Roman is the designated font type by GW. However, my adviser prefers Palatino over
% Times New Roman. Moreover, Palatino doesn't seem to be open-source nor free. So I have no choice
% and use URW P052 or TeX Gyre Pagella, which are "claimed" to be open-source equivalents of
% Palatino.
\setmainfont{P052}  % an open-source equivalent to Palatino
%\setmainfont{TeX Gyre Pagella}  % an open-source equivalent to Palatino
%\setmainfont{Palatino Linotype}  % Palatino (probably not open-source nor free)
%\setmainfont{Palatino}  % Palatino (probably not open-source nor free)

% un-comment to use Times New Roman 
%\setmainfont{Times New Roman}  % default serif: Microdoft's Times New Roman

% default font types for other font families
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
\setmathfont{texgyrepagella-math.otf}

% extra settings for debug mode
% -----------------------------------------------------------------------------
\ifdef{\@debug}{%
    \geometry{showframe}%
}{%
    \hypersetup{hidelinks}%
}

% hyperlinks of PDF bookmarks. By default, hyperlinks are set to be the
% displayed counters of parts, chapters, etc. When we reset the displayed
% counters, it makes different chapters, for example, share the same hyperlinks
% (because both have the same displayed counter value). We need to make them
% independent to displayed counters because we will reset displayed chapter
% counter for appendices. Only parts and chapters have to be handled because
% section, subsection, etc., by default, are prefixed with chapters' hyperlink
% names, meaning as long as chapters' hyperlinks are unique, their hyperlinks
% are also unique.
% -----------------------------------------------------------------------------
\renewcommand{\theHpart}{HPART\thepage}
\renewcommand{\theHchapter}{HCHAP\thepage}

%% things to be automatically added after `\begin{document}`
% -----------------------------------------------------------------------------
\AtBeginDocument{%
    \frontpages
    \newpage%
    \pagenumbering{arabic}  % restart page counter using arabic numerals
}
