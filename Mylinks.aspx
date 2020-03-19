<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    void Page_Load(object sender, EventArgs e)
    {
        System.Xml.XmlTextReader xtr = new System.Xml.XmlTextReader(Request.PhysicalApplicationPath + "../xml/links.xml");
        StringBuilder htmlSB = new StringBuilder();
    
        while (xtr.Read())
        {
            if (xtr.IsStartElement("category"))
            {
                htmlSB.Append
            
            }
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="linkslist" runat="server">
    
    </div>
    </form>
</body>
</html>