<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:user="http://www.wmhelp.com/">

<msxsl:script language="JScript" implements-prefix="user">
  <![CDATA[

  function avg(nodes)
  {
    s = 0;
    for (n = nodes.nextNode(); n; n = nodes.nextNode())
      s += parseFloat(n.nodeTypedValue);
    return s/nodes.length;
  }

  function getDate() {
   var d, s = "Today's date is: ";           //Declare variables.
   d = new Date();                           //Create Date object.
   s += (d.getMonth() + 1) + "/";            //Get month
   s += d.getDate() + "/";                   //Get day
   s += d.getYear();                         //Get year.
   return(s);                                //Return date.
  }
  ]]>
</msxsl:script>

  <xsl:output method="html"/>
  <xsl:param name="low_sales" select="21000"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select="//summary/heading"/>
        </title>
      </head>
      <body>
        <xsl:variable name="ancillary" select="document('ancillary.xml')"/>
        <div style="position:absolute;font-size:96;font-family:Times New Roman;color:#F0F0F0;z-index:-1">
          <xsl:value-of select="$ancillary//watermark"/>
        </div>
        <h1>
          <xsl:value-of select="//summary/heading"/>
        </h1>
        <h2>
          <xsl:value-of select="//summary/subhead"/>
        <br/>
          <xsl:value-of select="user:getDate()"/>
        </h2>
        <p>
          <xsl:value-of select="//summary/description"/>
        </p>
        <table>
<!-- create table heading row, filling in the
             quarter numbers from left to right -->
          <tr>
            <th>Region\Quarter</th>
            <xsl:for-each select="//data/region[1]/quarter">
              <th>Q
                <xsl:value-of select="@number"/>
              </th>
            </xsl:for-each>
            <th>Total</th>
          </tr>
          <!-- create a table body row for each quarter, for each region,
                  filling cells with the number of books sold -->
          <xsl:for-each select="//data/region">
            <tr>
              <th style="text-align:left">
                <xsl:value-of select="name"/>
              </th>
              <xsl:for-each select="quarter">
                <td>
                  <xsl:attribute name="style">
                    <xsl:choose>
                      <xsl:when test="number(@books_sold &lt;= $low_sales)">
               color:red;</xsl:when>
                      <xsl:otherwise>color:green;</xsl:otherwise>
                    </xsl:choose>text-align:right;
                  </xsl:attribute>
                  <xsl:value-of select="format-number(@books_sold,'###,###')"/>
                </td>
              </xsl:for-each>
              <td style="text-align:right;font-weight:bold;">
                <xsl:value-of select="format-number(sum(quarter/@books_sold),'###,###')"/>
                (Avg value: <xsl:value-of select="format-number(user:avg(quarter/@books_sold), '###,###')"/>)
              </td>
            </tr>
          </xsl:for-each>
        </table>
        <div style="font-size:9">
          <xsl:value-of select="$ancillary//copyright"/>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>