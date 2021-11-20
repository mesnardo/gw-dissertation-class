\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gw-dissertation-class/gw-dissertation}[2021/11/19]

% class options
% -----------------------------------------------------------------------------

% enable debug mode
\DeclareOption{debug}{\newcommand*{\@debug}{}}

% all other options are passed to LaTeX's report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% process the options passed into this class
\ProcessOptions

% base class
% -----------------------------------------------------------------------------

% this template is modified from the native report class
\LoadClass[12pt]{report}

% required packages
% -----------------------------------------------------------------------------

% to check the compiler. We need XeTeX
\RequirePackage{iftex}
\RequireXeTeX  % will stop compiling if not using xetex/xelatex

% geometry sets up the layout/dimensions of the pages
\RequirePackage{geometry}

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
% in equations using other packages.
\RequirePackage[no-math]{fontspec}

% unicode-math allows us to use unicode for math symbols.
\RequirePackage{unicode-math}

% biblatex is a modern alternative to bibtex for processing bibliography 
\RequirePackage{biblatex}

% graphicx extend the interface for including graphisc. It provides commands
% including \graphicspath and \DeclareGraphicsExtensions
\RequirePackage{graphicx}

% setspace provides commands to easily change the spacing. Default to double
% spacing
\RequirePackage{setspace}

% enumitem gives fine control over itemize list/description
\RequirePackage{enumitem}

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
\geometry{footskip=0.25in}  % guideline is not clear it's 0.5in or 0.75in from the bottom

% default line spacing
\doublespacing

% default paragraph spacing (extra 0.4 lines on top of double-line spacing); not regularized by GW
\setlength{\parskip}{0.4\baselineskip}

% header and footer style
\pagestyle{fancy}  % use fancyhdr's fancy page style
\fancyhf{}  % clear default LaTeX's plain style
\fancyfoot[C]{\thepage}  % position the page number at the bottom center
\renewcommand{\headrulewidth}{0pt}  % make header separation line invisible
\renewcommand{\footrulewidth}{0pt}  % make header separation line invisible

% indentation
\setlength{\parindent}{0.5in}

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

% extra settings for debug mode
\ifdef{\@debug}{%
    \geometry{showframe}%
}{%
    \hypersetup{hidelinks}%
}

% showing options
% -----------------------------------------------------------------------------

% macros
% -----------------------------------------------------------------------------

% front matter pages
% -----------------------------------------------------------------------------

%% thing automatically added after `\begin{document}`
% -----------------------------------------------------------------------------
\AtBeginDocument{%
    \frontpages
    \newpage%
    % restart page counter using arabic numerals
    \pagenumbering{arabic}%
}
