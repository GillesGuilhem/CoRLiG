<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xsl"
    version="2.0">
    
    <!-- feuille de transformation pour sortie HTML permettant la relecture des règles créées -->
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of
                        select="TEI/teiHeader/fileDesc/titleStmt/title"/>
                </title>
                <meta http-equiv="Content-Type" content="application/xhtml+xml;charset=utf-8"/>
                
                <meta name="DC.title"
                    content="{normalize-space(TEI/teiHeader/fileDesc/titleStmt/title)}"/>
                <meta name="DC.creator"
                    content="{normalize-space(TEI/teiHeader/fileDesc/titleStmt/author)}"/>
                <meta name="DC.creator"
                    content="{normalize-space(TEI/teiHeader/fileDesc/titleStmt/principal)}"/>
                
                
                <link rel="stylesheet" type="text/css" href="./style/style_rel.css"/>
                
            </head>
            
            <body>
                
                <div>
                    <!-- titre de niveau 1 -->
                    <h1>
                        <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/title"/>
                        <xsl:text> de </xsl:text> 
                        <xsl:value-of
                        select="TEI/teiHeader/fileDesc/titleStmt/author"
                    /></h1>
                    <!-- dans cette div va apparaître le texte -->
                    <xsl:apply-templates select="TEI/text"/>
                </div>
                
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="front">
        <div>
            <!-- le privilège -->
            <h2>
                <xsl:apply-templates select="descendant::head"/>
            </h2>
            <p class="front">
                <xsl:apply-templates select="div[@type='privilege']/p"/>
            </p>
        </div>
        
    </xsl:template>
    
    <xsl:template match="body/div">
        <div>
            <!-- les titres de chaque type  -->
            <xsl:for-each select="child::head">
                <h2>
                    <xsl:apply-templates/>
                </h2>
            </xsl:for-each>
            <xsl:apply-templates select="child::div | child::lg"/>
        </div>
    </xsl:template>
    
 
    
    <xsl:template match="div[@n]">
        <div>
            <!-- les titres de chaque morceau -->
            <xsl:for-each select="child::head">
                <h3>
                    <xsl:apply-templates/>
                </h3>
            </xsl:for-each>
            <xsl:apply-templates select="sp"/>
            <xsl:apply-templates select="lg"/>
        </div>
    </xsl:template>
    
    <xsl:template match="sp">
        <!-- on définit cette règle pour les cas où les lg sont dans les sp [pas pour les psaumes] -->
        <p>
            <xsl:apply-templates select="lg"/>
        </p>
        
    </xsl:template>
    
    <xsl:template match="lg">
        <p class="lg">
            <xsl:apply-templates/>
        </p>
       
    </xsl:template>

    
    
    <xsl:template match="l">
      
        <xsl:for-each select=".">
            <span class="numLigne">
                <!-- on récupère les types des div [type psaume] -->
                <xsl:value-of select="../../@type"/>
                <xsl:text> </xsl:text>
                <!-- on récupère le numéro des div -->
                <xsl:value-of select="../../@n"/>
               <!-- s'il y a plus d'une strophe --> 
                <xsl:if test="../@n">
                    <xsl:text>, st. </xsl:text>
                    <!-- on récupère le numéro des lg -->
                   <xsl:value-of select="../@n"/>
                </xsl:if>
                
                    <xsl:text>, v. </xsl:text>
                <!-- on récupère le numéro du vers -->
                <xsl:value-of select="@n"/>
                <xsl:text>.</xsl:text>
            </span>
            <span class="metLigne">
                <xsl:text>   [</xsl:text>
                <!-- on récupère la valeur du mètre, calculé automatiquement à partir des éléments seg -->
                <xsl:value-of select="@met"/>
                <xsl:text>]   </xsl:text>
                <!-- on sort les résultats pour le contrôle : si pas de métrique -->
                <xsl:if test="@met=''">
                 <xsl:text> [problème : pas de métrique]</xsl:text>
                </xsl:if>
            </span>
        </xsl:for-each>
        
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    
    <xsl:template match="w">
        <xsl:for-each select=".">
            <xsl:choose>
                <!-- s'il y a un problème car aucun seg n'est accentué dans le mot -->
                <xsl:when test=".[child::seg] and .[not(child::seg[@type='tonique'])]">
                    <span class="paston"> 
                        <xsl:apply-templates/>
                    </span>  
                </xsl:when>
                <xsl:otherwise>
                    <span class="mot">
                        <xsl:apply-templates/>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
            
            
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="seg">
     
       <xsl:choose>
           <xsl:when test="@type='tonique'">
               <!-- on fait apparaître les seg qui sont tonique en gras et en rouge -->
               <span class="bold">
                   <xsl:value-of select="."/>
               </span> 
           </xsl:when>
           <xsl:otherwise>
               <!-- les autres seg apparaissent juste en bordeaux -->
               <span class="rouge">
                   <xsl:value-of select="."/>
               </span> 
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>
    
    <xsl:template match="syn">
        <!-- les synalèphes se concrétisent par ce tiret -->
        <xsl:for-each select=".">
            <xsl:text>_</xsl:text>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="syll">
        <!-- les syll se manifestent par ce tiret là -->
        <xsl:for-each select=".">
            <span class="syll"><xsl:text>-</xsl:text></span>
        </xsl:for-each>
    </xsl:template>
    

    
    
</xsl:stylesheet>