gw-dissertation-class
=====================

This is a modernized rewrite of GW's LaTeX class for PhD dissertations. It is currently a WIP and
will be _officially finished_ once I also finish my dissertation.


## Class options
----------------

This class is derived from the standard report class, so it accepts all standard report class
options. Additionally, there two more class options:

1. **debug**
  
   The `debug` class option will enable background gridlines, layout frames, and also boxes
   surrounding hyperlinks.

2. **font**
  
   Times New Roman is the designated font type by GW. However, we prefer Palatino over Times New
   Roman. Palatino doesn't seem to be open-source nor free. So the class also allows URW P052 or
   TeX Gyre Pagella, which are the open-source equivalents to Palatino. The default font is P052.'
   To specify the font, use the package option `font`:

   * Times New Roman: `\documentclass[font=Times]{gw-dissertation}[2021/11/19] `
   * URW P052 (default): `\documentclass[font=P052]{gw-dissertation}[2021/11/19] `
   * TeX Gyre Pagella: `\documentclass[font=Pagella]{gw-dissertation}[2021/11/19] `
   * Palatino: `\documentclass[font=Palatino]{gw-dissertation}[2021/11/19] `
  
   These fonts may not be available by default on your system and require installation. For example,
   in Arch Linux:
   * `$ sudo pacman -S tex-gyre-fonts` installs TeX Gyre Pagella
   * `$ sudo pacman -S gsfonts` installs URW P052
   * Times New Roman is not open-source. It is only available in AUR packages, such as
     [ttf-ms-fonts](https://aur.archlinux.org/packages/ttf-ms-fonts)
   * Palatino is not open-source. It is only available in AUR packages, such as
     [ttf-win7-fonts](https://aur.archlinux.org/packages/ttf-win7-fonts).


## Usage
--------

This is a document class, not a package. Use `\documentclass{gw-dissertation}` to use the class.

To configure front matter:

| command | note |
| ------- | ---- |
| `\title{<title>}` | |
| `\author{<full name}` | |
| `\defdate{<defense date>}` | |
| `\gradyear{<degree deferral year>}` | |
| `\gradmonth{<degree deferral month>}` | |
| `\graddate{<degree deferral date>}` | |
| `\advisor{<full name>}{<job title>}` | |
| `\school{<school>}` | |
| `\prevdegree{<previous degree>}` | see note 1 |
| `\committee{<name, affiliation, and title>}` | see note 2 |
| `\dedication{<dedication>}` | |
| `\acknowledgments{<acknowledgements>}` | |
| `\disclaimer{<disclaimer>}` | |
| `\abstract{<abstract>}` | |
| `\preface{<preface>}` | |

***Note***

1. This ***appends*** the provided degree to a list, meaning this command can appear multiple times,
   and each time it only needs one degree provided. When rendering the title page, these previous
   degrees will be present in a first-in-first-out manner.
2. Similar to `\prevdegree`, this command can be called multiple times.

To control whether to show each page in the front matter, use `\show<page name>true` to show a page
or `\show<page name>false` to make the page invisible. The following table shows available page
names in the front matter:

| page name | default | note |
| ---------- | ----------- | --------------- | ------- | ---- |
| title | on | |
| certification | on | |
| copyright | on | |
| dedication | off | auto-turned on if `\dedication` is called |
| acknowledgments | off | auto-turned on if `\acknowledgements` is called |
| disclaimer | off | auto-turned on if `\disclaimer` is called |
| abstract | on | |
| toc | on | table of contents |
| lof | on | list of figures; required if figures are present |
| lot | on | list of tables; required if tables are present |
| los | on | use command `\nomenclature` from package `nomencl` to define <br> symbols |
| glossary | off | not implemented yet |
| preface | off | auto-turned on if `\preface` is called |


## Example
----------

There's an example TeX file and corresponding `latexmk` configuration file in the folder `example`.
When using command-line in Linux, simply go to the example folder and execute:

```shell
$ latexmk
```


## Format guidelines
--------------------

The major guideline is the example PDF from the School of Engineering and Applied Science (SEAS) for
Spring 2021:

  * [Sample PDF](https://library.gwu.edu/sites/default/files/2021-06/SEAS%20Dissertation%20Sample%20format_Spring%202021.pdf)

If the SEAS guideline is not clear enough, then the GW university-level guideline (as of Feb. 15,
2022) is used as a supplement. Guideline from GW Library as of Feb. 15, 2022:

  * [Webpage](https://library.gwu.edu/gw-etd-formatting)
  * [PDF](https://library.gwu.edu/sites/default/files/2021-10/Downloadable%20University%20Formatting%20Guidelines%20Oct%205%202021.pdf)

There's another version of SEAS sample PDF file on the internet. There are some differences between
the Spring 2021 version and this version. So this one is not used as a guideline. Just for your
information:

  * [Another SEAS sample PDF](https://graduate.seas.gwu.edu/sites/g/files/zaxdzs1526/f/downloads/SEAS%20PhD%20ETD%20Style%20Guide.pdf)


## Issues
---------

This section lists some format issues and discrepancies between the GW library guideline and the
SEAS sample PDF.

##### Title page:

1. Author name: GW uses normal font; SEAS' sample uses bold face.
2. Text: GW says: _"... in partial_satisfaction ..."; SEAS says: _"... in partial
   fulfillment ..."_

##### Certification page:

Letter case: GW says: _"... approved form of the dissertation."_; SEAS says: _"... approved form of
the Dissertation."_

##### Dedication page:

SEAS uses an indent of 0.5in for all paragraph; GW doesn't say that (though GW also requires 0.5in
indent for all other front pages).

##### Abstract page:

Dissertation title: GW wants a normal-font title, while SEAS sample uses bold-face font. Space after
title: GW says 2 single-line spacing; SEAS sample says one single-line spacing.

##### Table of Contents:

1. GW uses single-spacing within an entry but uses double-spacing between entries. However, the
   example PDF from SEAS doesn't seem to use the double-spacing between entries. In SEAS sample
   PDF, the spacing between entries is something smaller than double-spacing but definitely
   larger than single-spacing.
2. Both GW and SEAS guidelines do not specified the indents of sections, subsections, etc.\~ in
   the table of contents.

##### List of Figures:

GW guidelines says: _"Use two (2) single spaces between entries."_ This is probably a typo.  Based
on the sample figure in the GW guideline, it probably means double-spacing.

##### List of Symbols:

SEAS adds indices to symbols in the list, which totally doesn't make sense. I removed them in this
class.

##### Normal paragraphs in the body of document:

GW guideline uses 0.5in indent for all paragraphs. GW sample PDF actually uses 0.5in indent for
paragraphs in chapter 2 to 5 and appendices. However, in chapter 1, GW sample uses some number less
than 0.5in, which I believe it's a mistake.

## License
----------

BSD-3 license.

## Other known efforts
----------------------

* https://github.com/skulumani/thesis-gwu
