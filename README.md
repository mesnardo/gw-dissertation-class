gw-dissertation-class
=====================

This is a modernized rewrite of GW's LaTeX class for PhD dissertation. It is currently a WIP and
will be _officially finished_ once I also finish my dissertation.

## Guidelines

The major guideline is the example PDF from the School of Engineering and Applied Science (SEAS) for
Spring 2021:

  * [Sample PDF](https://library.gwu.edu/sites/default/files/2021-06/SEAS%20Dissertation%20Sample%20format_Spring%202021.pdf)

If the SEAS guideline is not clear enough, then the GW university-level guideline (as of Feb. 15,
2022) is used as supplement. Guideline from GW Library as of Feb. 15, 2022:

  * [Webpage](https://library.gwu.edu/gw-etd-formatting)
  * [PDF](https://library.gwu.edu/sites/default/files/2021-10/Downloadable%20University%20Formatting%20Guidelines%20Oct%205%202021.pdf)

There's another version of SEAS sample PDF file on the internet. There are some differences between
the Spring 2021 version and this version. So this one is not used as a guideline. Just for your
information:

  * [Another SEAS sample PDF](https://graduate.seas.gwu.edu/sites/g/files/zaxdzs1526/f/downloads/SEAS%20PhD%20ETD%20Style%20Guide.pdf)

## Notes

### Issues and discrepancy between GW library and SEAS format

1. Title page:
    1. Author name: GW uses normal font; SEAS' sample uses bold face.
    2. Text: GW says: _"... in partial_satisfaction ..."; SEAS says: _"... in partial
       fulfillment ..."_
2. Certification page:
    1. Letter case: GW says: _"... approved form of the dissertation."_; SEAS says: _"... approved
       form of the Dissertation."_
3. Dedication page:
    1. SEAS uses an indent of 0.5in for all paragraph; GW doesn't say that (though GW also requires
       0.5in indent for all other front pages).
4. Abstract page:
    1. Dissertation title: GW wants a normal-font title, while SEAS sample uses bold-face font.
    2. Space after title: GW says 2 single-line spacing; SEAS sample says one single-line spacing.
5. Table of Contents:
    1. GW uses single-spacing within an entry but uses double-spacing between entries. However, the
       example PDF from SEAS doesn't seem to use the double-spacing between entries. In SEAS sample
       PDF, the spacing between entries is something smaller than double-spacing but definitely
       larger than single-spacing.
    2. Both GW and SEAS guidelines do not specified the indents of sections, subsections, etc.\~ in
       the table of contents.
6. List of Figures:
    1. GW guidelines says: _"Use two (2) single spaces between entries."_ This is probably a typo.
       Based on the sample figure in the GW guideline, it probably means double-spacing.
7. List of Symbols:
    1. SEAS adds indices to symbols in the list, which totally doesn't make sense. I removed them in
       this class.

### Fonts

Times New Roman is the designated font type by GW. However, we prefer Palatino over Times New Roman.
Moreover, Palatino doesn't seem to be open-source nor free. So I have no choice and use URW P052 or
TeX Gyre Pagella, which are "claimed" to be open-source equivalents of Palatino.

## License

BSD-3 license.
