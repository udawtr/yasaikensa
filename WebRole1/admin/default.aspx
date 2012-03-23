<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebRole1.admin._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div style="margin:10px 0;">
管理メニュー
</div>

<div style="margin:10px 0;">
<ul>
    <li><a href="upload.aspx">検査データアップロード</a></li>
    <li><a href="SRList.aspx">出荷制限</a></li>
</ul>
</div>

</asp:Content>
