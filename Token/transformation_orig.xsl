<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    version="2.0">
    
    <xsl:output 
        method="xhtml" 
        indent="yes" 
        omit-xml-declaration="no" 
        encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of
                        select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"
                    />
                </title>
                <meta http-equiv="Content-Type" content="application/xhtml+xml;charset=utf-8"/>
                
                <meta name="DC.title"                   content="{normalize-space(tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title)}"/>
                <meta name="DC.creator"                    content="{normalize-space(tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author)}"/>
                <meta name="DC.creator"                   content="{normalize-space(tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:principal)}"/>
                
                <!-- rajouter : DC.contributor, DC.date, DC.rights. Les métadonnées !!!!-->
                
                <link rel="stylesheet" type="text/css" href="style.css"/>
                
            </head>
            
            <body>
                
                <div>
                    <!-- titre de niveau 1 -->
                    <h1>Poésies de <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/></h1>
                    <!-- dans cette div va apparaître le texte -->  
                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body"/>
                </div>
                
            </body>       
        </html>
        
    </xsl:template>
    
    <xsl:template match="tei:body/tei:div">
        <div>
            <!-- les titres de chaque type de poésie -->
            <xsl:for-each select="child::tei:head">
                <h2>
                    <xsl:apply-templates/>
                </h2>
            </xsl:for-each>
            <xsl:apply-templates select="tei:div[@n]"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:div[@n]">
        <div>
            <!-- les titres de chaque poésie -->
            <xsl:for-each select="child::tei:head">
                <h3>
                    <xsl:apply-templates/>
                </h3>
            </xsl:for-each>
            <xsl:apply-templates select="tei:sp"/>
            <xsl:apply-templates select="tei:lg"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:sp">
        <!-- on définit cette règle pour les cas où les lg sont dans les sp -->
        <p>
            <xsl:apply-templates select="tei:lg"/>
        </p>
        
    </xsl:template>
    
    <xsl:template match="tei:lg">
        <p class="lg">
            <xsl:apply-templates/>   
        </p>
    </xsl:template>
    
    
    <xsl:template match="tei:l">
        <!-- pour chaque vers : on définit un numéro de ligne -->
        <xsl:variable name="numLigne">
            <xsl:number count="tei:l" level="any" from="tei:div[@n]" format="01"/>
        </xsl:variable>
        <!-- on ne fait apparaître le numéro que toutes les 5 lignes -->
        <xsl:if test="$numLigne mod 5 = 0">              
            <span class="numLigne">
                <xsl:value-of select="$numLigne"/>
                <xsl:text> </xsl:text>
            </span>
        </xsl:if>
        <xsl:choose>
            <!-- pour les vers ajouté : on les met en italique et commentaire -->
            <xsl:when test="child::tei:add[@hand]">
                <span class="ajout">   
                    <xsl:apply-templates/>
                </span>
                <span class="comm">
                    <xsl:text>[Vers ajouté à la main] </xsl:text>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="l">
                    <xsl:apply-templates/>
                </span>  
            </xsl:otherwise>
        </xsl:choose>
        <br/>         
    </xsl:template>
    
    
    <xsl:template match="tei:choice[not(child::tei:reg[@resp='editeur'])]">
        <!-- on fait apparaître dans le texte la version originale non régularisée non corrigée, en bulle grâce à l'attribut title la version régularisée et corrigée -->
       
        <span title="{tei:reg | tei:corr}">
            <xsl:apply-templates select="tei:orig | tei:sic"/>
        </span> 
    </xsl:template>
    
    
    
    <xsl:template match="tei:fw"> 
        <!-- on fait aparaître entre crochets les mentions de bas de page, postionnées de manière spécifique grâce à la classe bdp -->
        <span class="bdp">
            <xsl:apply-templates/>
        </span>  
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <!-- on fait apparaître entre crohets les mentions de changement de page, positionnées de manière spécifique grâce à la classe hdp -->
        <p class="hdp">
            <xsl-text>[</xsl-text>
            <xsl:value-of select="@n"/>
            <xsl:text>]</xsl:text>
        </p>
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <!-- on met en valeur les lettres en gras dans l'édition imprimée -->
        <span class="lettrine">
            <xsl:apply-templates/>
        </span>      
    </xsl:template>
    
    <xsl:template match="tei:space[@type='indent']">
        <!-- on fait apparaître les indentations -->
        <span class="indent">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
</xsl:stylesheet>