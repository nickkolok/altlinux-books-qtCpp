<?xml version='1.0' encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

<!-- Figures and captions -->
<xsl:param name="figure.caution">noticepenguin</xsl:param>
<xsl:param name="figure.important">noticepenguin</xsl:param>
<xsl:param name="figure.note">noticepenguin</xsl:param>
<xsl:param name="figure.tip">noticepenguin</xsl:param>
<xsl:param name="figure.warning">noticepenguin</xsl:param>
<xsl:param name="figure.new_concept">new_concept</xsl:param>
<xsl:param name="figure.explore">explore</xsl:param>
<xsl:param name="figure.big_program">big_prg</xsl:param>
<xsl:param name="mediaobject.caption.style">\upshape\mdseries</xsl:param>
<!--
<xsl:param name="imagedata.default.scale=maxwidth="></xsl:param>
-->

<!-- Localization -->
<xsl:param name="latex.encoding">utf8</xsl:param>
<xsl:param name="latex.babel.use">1</xsl:param>
<xsl:param name="latex.babel.languagex">english,russian</xsl:param>

<!-- Layout -->
<xsl:param name="latex.hyperparam">draft</xsl:param>
<xsl:param name="term.breakline">1</xsl:param>
<xsl:param name="doc.toc.show">0</xsl:param>
<xsl:param name="literal.lines.showall">0</xsl:param>
</xsl:stylesheet>
