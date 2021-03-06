<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="tei"
    xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:output method="xml" indent="yes" omit-xml-declaration="no" encoding="UTF-8"/>


    <xsl:template match="/">
        <xsl:element name="TEI">

            <xsl:element name="teiHeader">
                <xsl:apply-templates select="tei:TEI/tei:teiHeader"/>
            </xsl:element>

            <xsl:element name="text">
                <xsl:element name="front">
                    <xsl:apply-templates select="tei:TEI/tei:text/tei:front"/>
                </xsl:element>

                <xsl:element name="body">

                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body"/>

                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:TEI/tei:teiHeader">
        <xsl:element name="fileDesc">
            <xsl:element name="titleStmt">
                <xsl:element name="title">
                    <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:title"/>
                </xsl:element>
                <xsl:element name="author">
                    <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:author"/>
                </xsl:element>
                <xsl:element name="principal">
                    <xsl:value-of select="tei:fileDesc/tei:titleStmt/tei:principal"/>
                </xsl:element>

            </xsl:element>
            <xsl:element name="publicationStmt">

                <xsl:apply-templates select="tei:fileDesc/tei:publicationStmt"/>

            </xsl:element>
            <xsl:element name="sourceDesc">

                <xsl:apply-templates select="tei:fileDesc/tei:sourceDesc"/>

            </xsl:element>
        </xsl:element>
        <xsl:element name="profileDesc">
            <xsl:element name="creation">

                <xsl:apply-templates select="tei:profileDesc/tei:creation"/>

            </xsl:element>
        </xsl:element>

        <xsl:apply-templates select="tei:TEI/tei:text"/>

    </xsl:template>

    <xsl:template match="tei:titlePage">
        <xsl:element name="titlePage">
            <xsl:element name="docTitle">
                <xsl:element name="titlePart">
                    <xsl:value-of select="tei:docTitle/tei:titlePart"/>
                </xsl:element>
            </xsl:element>

            <xsl:element name="docAuthor">
                <xsl:value-of select="tei:docAuthor"/>
            </xsl:element>

            <xsl:element name="docImprint">
                <xsl:value-of select="tei:docImprint"/>
            </xsl:element>

            <xsl:element name="imprimatur">
                <xsl:value-of select="tei:imprimatur"/>
            </xsl:element>

            <xsl:element name="docDate">
                <xsl:value-of select="tei:docDate"/>
            </xsl:element>
        </xsl:element>

    </xsl:template>

    <xsl:template match="tei:div">
        <xsl:element name="div">
            <xsl:if test="@n">
                <xsl:attribute name="n">
                    <xsl:value-of select="@n"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@type">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="tei:lg | tei:div | tei:head | tei:p | tei:w"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:head">
        <xsl:element name="head">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:p">
        <xsl:element name="p">
            <xsl:for-each select="tei:w">
                <xsl:element name="w">
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:sp">
        <xsl:element name="sp">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:speaker">
        <xsl:element name="speaker">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:lg">
        <xsl:element name="lg">
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>

    </xsl:template>
    
    <xsl:template match="tei:l">
        <xsl:element name="l">
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            
           
    

    <xsl:for-each select="tei:w">
        <!-- r??gle pour les mots -->

        <xsl:variable name="posw">
            <xsl:value-of select="position()"/>
        </xsl:variable>
        <xsl:variable name="lastw">
            <xsl:value-of select="last()"/>
        </xsl:variable>
        
        <xsl:element name="w">
        
            <xsl:attribute name="n">
                <xsl:value-of select="@n"/>
            </xsl:attribute>
          
          <!-- r??gles pour les accents toniques  -->
          <xsl:choose>
              <xsl:when test="sum(count(child::tei:c[@type='voy' or @type='u' or @type='trema'])) = 1">
                  <xsl:attribute name="type">
                      <xsl:text>oxyton</xsl:text>
                 </xsl:attribute>  
              </xsl:when>
              <xsl:when test="sum(count(child::tei:c[@type='voy' or @type='u' or @type='trema'])) = 0"/>
              <xsl:when test="sum(count(child::tei:c)) = 3 and .[child::tei:c[position()=1][following::tei:c[1][@type='voy' or @type='u' or @type='cons']][following::tei:c[2][@type='voy' or @type='u' or @type='cons']]]">
                  <xsl:attribute name="type">
                      <xsl:text>oxyton</xsl:text>
                  </xsl:attribute>     
              </xsl:when>
              <xsl:when test=".[child::tei:c[position()=last()][contains(., '??') or contains(., '??') or contains(., '??') or contains(., '??') or contains(., '??')]]">
                  <xsl:attribute name="type">
                     <xsl:text>oxyton</xsl:text>
                  </xsl:attribute>  
              </xsl:when>
              <xsl:otherwise>
                  <xsl:if test=".[child::tei:c[position()=last()][@type='cons' and not(contains(., 'n') or contains(., 's'))]]">
                      <xsl:attribute name="type">
                         <xsl:text>oxyton</xsl:text>
                      </xsl:attribute>   
                  </xsl:if>    
                  <xsl:if test=".[child::tei:c[position()=last()][@type='voy' or @type='u']]">
                      <xsl:attribute name="type">
                          <xsl:text>paroxyton</xsl:text>
                      </xsl:attribute>
                  </xsl:if>  
                  <xsl:if test=".[child::tei:c[position()=last()][contains(., 'n') or contains(., 's')]]">
                      <xsl:attribute name="type">
                          <xsl:text>paroxyton</xsl:text>
                      </xsl:attribute>
                  </xsl:if>
              </xsl:otherwise>
          </xsl:choose>
           
          

       
        
            <!-- on entre dans une boucle pour agir sur chacun des caract??res -->
            <xsl:for-each select="child::tei:c">
                <!-- les variables suivantes vous nous permettre de d??terminer les premiers et derniers caract??res des mots -->
               
                    
                <xsl:variable name="pos">
                    <xsl:value-of select="position()"/>
                </xsl:variable>
                <xsl:variable name="last">
                    <xsl:value-of select="last()"/>
                </xsl:variable>
            
                <xsl:choose>

                    <!-- r??gle pour trema : seul, dans une balise seg -->
                    <xsl:when test="@type = 'trema'">
                        <xsl:element name="syll"/>
                        <xsl:element name="seg">
                           
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:when>

                    <!-- r??gle pour les nombres -->
                    <xsl:when test="@type = 'num'">
                        <xsl:value-of select="."/>
                    </xsl:when>

                    <!-- r??gles pour les consonnes -->
                    <xsl:when test="@type = 'cons'">
                        <xsl:choose>
                            <!-- r??gle pour les "v" devant b, s, qui ont une valeur sonor de "u" -->
                            <xsl:when test=". = 'V' or . = 'v'">
                                <xsl:choose>
                                    <xsl:when
                                        test=".[preceding::tei:c[1][contains(., 'A')]] and .[following::tei:c[1][contains(., 'M')]]"/>
                                    <xsl:when test=".[following::tei:c[1][@type = 'cons']]">
                                        <xsl:element name="seg">
                                            <xsl:value-of select="."/>
                                        </xsl:element>
                                        <xsl:value-of select="following::tei:c[1]"/>
                                    </xsl:when>
                                    <xsl:when test=".[preceding::tei:c[1][contains(., 'A')]]"/> 

                                    <xsl:otherwise>
                                        <xsl:choose>
                                            
                                            <xsl:when test=".[parent::tei:w/tei:c[@type='voy' or @type='u' or @type='trema'][2]] and .[$pos != 1]">
                                                
                                                <xsl:choose>
                                                    <xsl:when test=".[$pos = $last]">
                                                        <xsl:value-of select="."/>  
                                                    </xsl:when>                 
                                                    <xsl:when test=".[preceding::tei:c[1][@type='voy' or @type='u']] and .[following::tei:c[1][@type='voy' or @type='u']]">  
                                                        
                                                        <xsl:element name="syll"/> 
                                                        <xsl:value-of select="."/>  
                                                        
                                                        
                                                    </xsl:when>
                                                    <xsl:when test=".[preceding::tei:c[1][@type='voy' or @type='u']] and .[following::tei:c[1][@type='cons']]">
                                                        <xsl:choose>
                                                            <xsl:when test=".[$pos = $last]">
                                                                <xsl:value-of select="."/>
                                                            </xsl:when>
                                                            
                                                            <xsl:otherwise>
                                                                <xsl:choose>
                                                                    <xsl:when test=".[following::tei:c[1]='l'] or .[following::tei:c[1]='r']">
                                                                        <xsl:element name="syll"/> 
                                                                        <xsl:value-of select="."/>  
                                                                    </xsl:when>
                                                                    <xsl:when test=".[$pos = $last -1]">
                                                                        <xsl:value-of select="."/>
                                                                    </xsl:when>
                                                                    <xsl:when test=".='p' and .[following::tei:c[1]='h']">
                                                                        <xsl:element name="syll"/>
                                                                        <xsl:value-of select="."/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="."/>
                                                                        <xsl:element name="syll"/>   
                                                                    </xsl:otherwise>
                                                               </xsl:choose>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="."/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                            </xsl:otherwise>          
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            
                            
                            <!-- faire la r??gle inverse pour les consonnes qui suivent "v" ?? valeur de "u" -->
                            <xsl:when test=". != 'v'">
                               <xsl:choose>
                                   <xsl:when test=".[preceding::tei:c[1][contains(., 'v')]]"/>
                                   <!-- on ne veut faire appara??tre les syll qu'au sein des mots qui ont au moins 2 voyelles (b sinon, une syllabe : la s??paration de mots, sans ??l??ment de liaison, indique la valeur d'une syllabe-->
                                   <xsl:otherwise>
                                       <xsl:choose>
                                          
                                       <xsl:when test=".[parent::tei:w/tei:c[@type='voy' or @type='u' or @type='trema'][2]] and .[$pos != 1]">

                                       <xsl:choose>
                                           <xsl:when test=".[$pos = $last]">
                                               <xsl:value-of select="."/>  
                                           </xsl:when>                 
                            <xsl:when test=".[preceding::tei:c[1][@type='voy' or @type='u']] and .[following::tei:c[1][@type='voy' or @type='u']]">  

                                       <xsl:element name="syll"/> 
                                        <xsl:value-of select="."/>  

                              
                                </xsl:when>
                            <xsl:when test=".[preceding::tei:c[1][@type='voy' or @type='u']] and .[following::tei:c[1][@type='cons']]">
                                <xsl:choose>
                                    <xsl:when test=".[$pos = $last]">
                                        <xsl:value-of select="."/>
                                  </xsl:when>
                               
          <xsl:otherwise>
              <xsl:choose>
                  <xsl:when test=".[following::tei:c[1]='l'] or .[following::tei:c[1]='r']">
                                        <xsl:element name="syll"/> 
                                       <xsl:value-of select="."/>  
                                   </xsl:when>
                                    <xsl:when test=".[$pos = $last -1]">
                                        <xsl:value-of select="."/>
                                   </xsl:when>
                                  <xsl:when test="(.='p' or .='l' or .= 'c') and .[following::tei:c[1]='h']">
                                      <xsl:element name="syll"/>
                                     <xsl:value-of select="."/>
                                  </xsl:when>
                  <xsl:when test=".[following::tei:c[1]='-'] and .[following::tei:c[2][@type='cons']]">
                      <xsl:value-of select="."/>
                      <xsl:element name="syll"/>
                  </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                      <xsl:element name="syll"/>   
                                    </xsl:otherwise>
              </xsl:choose>
          </xsl:otherwise>
                               </xsl:choose>
                            </xsl:when>
                                           <xsl:otherwise>
                                               <xsl:value-of select="."/>
                                           </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                                           <xsl:otherwise>
                                               <xsl:value-of select="."/>
                                           </xsl:otherwise>          
                                       </xsl:choose>
                                   </xsl:otherwise>
                               </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                                </xsl:choose>
                           </xsl:when>

                    <!-- la suite de r??gles pour les voyelles
                    <xsl:if test=".[$pos = $last] and .[following::tei:c[1][@type='voy' or @type='u']]">
                        <xsl:element name="el"/>
                        </xsl:if>
                    -->
                    <xsl:when test="@type = 'voy'"> 
                    
                        <xsl:choose>
                            <!-- pour les premi??res lettres, pour ne pas qu'elles disparaissent en se concatenant -->
                            <xsl:when
                                test=".[$pos = 1] and .[preceding::tei:c[1][@type = 'voy' or @type = 'u']] and (.[following::tei:c[1][@type = 'cons' or @type = 'trema']] or .[following::tei:c[1][$pos = 1][@type = 'voy' or @type = 'u']])">
                            <xsl:choose>
                                <!-- d??but de mot en au  -->
                                <xsl:when test=".[following::tei:c[1][@type = 'u']]">
                                   <xsl:element name="seg">
                                        <xsl:value-of select="concat(., following::tei:c[1])"/>
                                   </xsl:element>       
                               </xsl:when>
                               <xsl:otherwise>
                                   <xsl:element name="seg">
                                        <xsl:value-of select="."/>
                                    </xsl:element>   
                                </xsl:otherwise>
                            </xsl:choose>
                                
               
                           </xsl:when>
                            <!-- pour les derni??res lettres, pour ne pas qu'elles se concat??nent avec les premi??res -->
                            <xsl:when
                                test=".[$pos = $last] and .[preceding::tei:c[1][@type = 'cons' or @type = 'trema']] and .[following::tei:c[1][@type = 'voy' or @type = 'u']]">
                                <!--   <xsl:choose>
                         <xsl:when test=".[parent::tei:w[$posw= $lastw]]">
                             <xsl:element name="seg">
                                <xsl:value-of select="."/>
                            </xsl:element>   
                         </xsl:when>
                                    <xsl:otherwise>
                                     <xsl:if test=".[preceding::tei:c[2][contains(., 'q') or contains(., 'Q')]]">
                                                <xsl:element name="seg">
                                                    <xsl:value-of select="."/>
                                                </xsl:element>
                                                <xsl:element name="syn"/>    
                                            </xsl:if>
                                       -->
                                           
                                        
                                        <xsl:element name="seg">
                                            <xsl:value-of select="."/>
                                        </xsl:element>
                               
                            </xsl:when>
                            <!-- Si ni premi??re ni derni??re lettre sans autres voyelles ?? c??t?? -->
                            <xsl:otherwise>
                                <xsl:choose>
                                    <!-- le cas de qui, que -->
                                    <xsl:when
                                        test=".[preceding::tei:c[1][@type = 'u']] and .[preceding::tei:c[2][contains(., 'q') or contains(., 'Q')]]">
                                        <xsl:value-of select="preceding::tei:c[1]"/>
                                        <xsl:element name="seg">
                                            <xsl:value-of select="."/>
                                        </xsl:element>
                                    </xsl:when>
                                    <!-- lorsqu'une voyelle est pr??c??d??e d'une autre, elle n'appara??t pas (les vraies r??gles sont d??finies ?? partir de la voyelle qui pr??c??de) -->
                                    <xsl:when
                                        test=".[preceding::tei:c[1][@type = 'voy' or @type = 'u']]"/>
                                    <xsl:when
                                        test=".[preceding::tei:c[1][contains(., 'u')]] and .[preceding::tei:c[2][contains(., 'a') or contains(., 'e')]]"/>
<!-- les r??gles par rapport ?? PSAVME -->
                                    <xsl:when
                                        test=". = 'A' and following::tei:c[1][contains(., 'V')]">
                                        <xsl:element name="seg">
                                            <xsl:value-of
                                                select="concat(., following::tei:c[1][contains(., 'V')])"
                                            />
                                        </xsl:element>
                                    </xsl:when>

                                    <!-- quand deux voyelles se succ??dent : une succesion de choix et de r??gles -->
                                    <xsl:when
                                        test=".[following::tei:c[1][contains(., 'i') or contains(., 'a') or contains(., 'o') or contains(., 'e') or contains(., 'u') or contains(., 'y') or contains(., '??') or contains(., '??') or contains(., '??') or contains(., '??') or contains(., 'I') or contains(., 'Y')]]">
                                        <xsl:choose>
                                            <!-- deux voyelles mais pas de diphtongue -->
                                            <xsl:when
                                                test=". = 'o' and following::tei:c[1][contains(., 'a') or contains(., 'u')]">
                                                <xsl:element name="seg">
                                                  <xsl:value-of select="."/>
                                                </xsl:element>
                                                <xsl:element name="syll"/>
                                                <xsl:element name="seg">
                                                  <xsl:value-of select="following::tei:c[1]"/>
                                                </xsl:element>
                                            </xsl:when>
                                            <!-- cas particulier : oya -->
                                            <xsl:when test=".='o' and .[following::tei:c[1][contains(., 'y')]] and .[following::tei:c[2][contains(., 'a')]]">
                                                <xsl:element name="seg">
                                                    <xsl:value-of select="."/>                                                </xsl:element>
                                                <xsl:element name="syll"/>
                                                <xsl:element name="seg">
                                                    <xsl:value-of select="concat (following::tei:c[1], following::tei:c[2])"/>
                                                </xsl:element>
                                            </xsl:when>
                                            <!-- cas particuliers : aou -->
                                            <xsl:when
                                                test=".[following::tei:c[1][contains(., 'o')]] and .[following::tei:c[2][contains(., 'u')]]">
                                                <xsl:element name="seg">
                                                  <xsl:value-of select="."/>
                                                </xsl:element>
                                                <xsl:element name="syll"/>
                                                <xsl:element name="seg">
                                                  <xsl:value-of select="following::tei:c[1]"/>
                                                </xsl:element>
                                                <xsl:element name="syll"/>
                                                <xsl:element name="seg">
                                                  <xsl:value-of select="following::tei:c[2]"/>
                                                </xsl:element>
                                            </xsl:when>
                                            <!--
                                                cas basique de trois voyelles qui se suivent : on concat??ne -->
                                            <xsl:when
                                               test=".[following::tei:c[1][@type='voy']] and .[preceding::tei:c[1][@type = 'cons' or @type = 'trema']] and .[following::tei:c[2][@type = 'voy']]">
                                                <xsl:choose>
                                                    <!-- on fait attention ?? que ??a ne d??borde pas sur le mot d'apr??s -->
                                                    <xsl:when test=".[$pos = $last - 1]">
                                                    <xsl:element name="seg">
                                                        <xsl:value-of select="concat(., following::tei:c[1])"/>    
                                                    </xsl:element>
                                                   </xsl:when>
                                               <xsl:otherwise>
                                                   <xsl:element name="seg">
                                                       <xsl:value-of
                                                           select="concat(., following::tei:c[1], following::tei:c[2])"/>
                                                   </xsl:element>    
                                               </xsl:otherwise>
                                              
                                                </xsl:choose>
                                            </xsl:when>

                                            <!-- le cas avec un u au milieu (u ?? valeur consonnantique) -->
                                            <xsl:when
                                                test=".[following::tei:c[1][contains(., 'u')]] and .[following::tei:c[2][contains(., 'i') or contains(., 'a') or contains(., 'o') or contains(., 'e') or contains(., 'u') or contains(., 'y') or contains(., '??') or contains(., '??') or contains(., '??') or contains(., '??')]]">
                                                <xsl:choose>
                                                  <!-- quand c'est en fin de mot : on n'en tient pas compte : on fait une basique concat??nation -->
                                                  <xsl:when test=".[$pos = $last - 1]">
                                                  <xsl:element name="seg">
                                                  <xsl:value-of
                                                  select="concat(., following::tei:c[1])"/>
                                                  </xsl:element>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:element name="seg">
                                                  <xsl:value-of select="."/>
                                                  </xsl:element>
                                                   <xsl:element name="syll"/>
                                                  <xsl:value-of select="following::tei:c[1]"/>
                                                  <xsl:element name="seg">
                                                  <xsl:value-of select="following::tei:c[2]"/>
                                                  </xsl:element>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:when>

                                            <!-- triphtongue sp?? type iey -->
                                            <xsl:when
                                                test=".[following::tei:c[1][contains(., 'e')]] and .[following::tei:c[2][contains(., 'i') or contains(., 'y')]]">

                                                <xsl:element name="seg">
                                                  <xsl:value-of
                                                  select="concat(., following::tei:c[1], following::tei:c[2])"
                                                  />
                                                </xsl:element>
                                            </xsl:when>

                                            <!-- dans les autres cas, on concat??ne -->
                                            <xsl:otherwise>
                                                <xsl:element name="seg">
                                                  <xsl:value-of
                                                  select="concat(., following::tei:c[1])"/>
                                                </xsl:element>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>

                                    <!-- si juste voyelle, juste seg -->
                                    <xsl:otherwise>
                                        <xsl:element name="seg">
                                            <xsl:value-of select="."/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>

                    <!-- pour "u" -->
                    <xsl:when test="@type = 'u'">
                        <xsl:choose>
                            <!-- d??finition des r??gles sur derni??re et premi??re lettre -->
                            <xsl:when
                                test=".[$pos = 1] and .[preceding::tei:c[1][@type = 'voy' or @type = 'u']] and .[following::tei:c[1][@type = 'cons' or @type = 'trema']]">
                                <xsl:element name="seg">
                                    <xsl:value-of select="."/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when
                                test=".[$pos = $last] and .[preceding::tei:c[1][@type = 'cons' or @type = 'trema']] and .[following::tei:c[@type = 'voy' or @type = 'u']]">
                                <xsl:element name="seg">
                                    <xsl:value-of select="."/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <!-- le "u" dispara??t quand on est dans un cas comme qui, que (puisque les r??gles sont d??finies ci-dessus). Mais lorsque seulement "q" et "u", il faut qu'il apparaissent. -->
                                <xsl:choose>
                                    <xsl:when
                                        test=".[preceding::tei:c[1][contains(., 'Q') or contains(., 'q')]]">
                                        <xsl:choose>
                                            <xsl:when test=".[following::tei:c[1][@type = 'voy']]"/>
                                            <xsl:otherwise>
                                                <xsl:value-of select="."/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <!-- quand est pr??c??d?? d'une voyelle, dispara??t : r??gles sur la voyelle -->
                                    <xsl:when
                                        test=".[preceding::tei:c[1][contains(., 'i') or contains(., 'e') or contains(., 'a') or contains(., '??') or contains(., '??') or contains(., '??') or contains(., 'o') or contains(., 'O') or contains(., 'A')]]"/>

                                    <!-- quand pr??c??de une voyelle, les r??gles sont ici. Voyelles avec lesquelles il y a une diphtongue. -->
                                    <xsl:when
                                        test=".[following::tei:c[1][contains(., 'i') or contains(., 'e') or contains(., 'a') or contains(., '??') or contains(., '??') or contains(., '??') or contains(., 'y') or contains(., '??') or contains(., 'a') or contains(., 'o') or contains(., '??')]]">
                                        <xsl:element name="seg">
                                            <xsl:value-of select="concat(., following::tei:c[1])"/>
                                       </xsl:element>
                                    </xsl:when>
                                   <!-- Sinon, u tout seul -->
                                    <xsl:otherwise>
                                       <xsl:element name="seg">
                                            <xsl:value-of select="."/>
                                        </xsl:element>
                                  </xsl:otherwise>
                                </xsl:choose>
                           </xsl:otherwise>
                       </xsl:choose>
                    </xsl:when>
                </xsl:choose>
                
            </xsl:for-each>
        </xsl:element>
        <!-- En cours : tentaives pour sortir syn duw : ne fonctionne pas 
       
        <xsl:variable name="posc">
        <xsl:value-of select=".[child::tei:c[position()]]"/>
        </xsl:variable>

        <xsl:variable name="val">
            <xsl:value-of select="child::tei:c[@type='voy'][$posc= last()]"/>
        </xsl:variable>
        <xsl:variable name="valun">
            <xsl:value-of select="child::tei:c[@type='voy'][$posc =1]"/>
        </xsl:variable>
        <xsl:if test=".[ends-with(., $val)] and .[following::tei:w[1][starts-with(., $valun)]]">
          <xsl:element name="syn"/>  
        </xsl:if>
        
          <xsl:if test=".[child::tei[c][position() = last()][@type = 'voy' or @type = 'u']] and .[following::tei:w[1]/tei:c[1][@type = 'voy' or @type = 'u']]">
            <xsl:choose>
                <xsl:when test="$posw = $lastw"/>
                <xsl:otherwise>
                    <xsl:element name="syn"/> 
                </xsl:otherwise> 
            </xsl:choose>
            
            </xsl:if>
       -->
        <xsl:if test=".[$posw != $lastw] and .[child::tei:c[position()=last()][@type='voy' or @type='u']] and .[following::tei:w[1]/tei:c[1][@type='voy' or @type='u']]">
            <xsl:element name="syn"/>
        </xsl:if>
    
    </xsl:for-each>
         
       </xsl:element>
        
        <!-- probl??me pour les pc -->
   </xsl:template>
    <xsl:template match="tei:pc">
        <xsl:for-each select=".">
            <xsl:element name="pc">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>





</xsl:stylesheet>
