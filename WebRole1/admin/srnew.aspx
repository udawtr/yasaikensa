<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="srnew.aspx.cs" Inherits="WebRole1.admin.srnew" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div style="margin:10px 0;">
<a href="default.aspx">管理メニュー</a>&nbsp;&gt&nbsp;<a href="SRList.aspx">出荷制限</a>&nbsp;&gt;&nbsp;新規作成
</div>

<table border=1>
<tbody>
<tr><th colspan="2">コード</th><td><asp:TextBox ID="Code" runat="server"></asp:TextBox></td></tr>
<tr><th colspan="2">表題</th><td><asp:TextBox ID="Caption" runat="server" /></td></tr>
<tr><th colspan="2">都道府県</th><td><asp:TextBox ID="PrefName" runat="server" /></td></tr>
<tr><th rowspan="2">市町村</th><th>モード</th><td>
    <asp:RadioButtonList ID="CityFilterMode" runat="server" AutoPostBack="True" 
        RepeatDirection="Horizontal" RepeatLayout="Flow">
        <asp:ListItem Value="0">全て</asp:ListItem>
        <asp:ListItem Value="1">指定市区町村のみ</asp:ListItem>
        <asp:ListItem Value="2">指定市区町村を除く</asp:ListItem>
</asp:RadioButtonList></td></tr>
<tr><th>一覧</th><td><asp:TextBox ID="Cities" runat="server" Rows="4" 
        TextMode="MultiLine" Width="412px" /></td></tr>
<tr><th rowspan="2">商品</th><th>モード</th><td>
    <asp:RadioButtonList ID="ProductFilterMode" runat="server" AutoPostBack="True" 
        RepeatDirection="Horizontal" RepeatLayout="Flow">
        <asp:ListItem Value="0">全て</asp:ListItem>
        <asp:ListItem Value="10">品目</asp:ListItem>
        <asp:ListItem Value="11">品目(先頭一致)</asp:ListItem>
        <asp:ListItem Value="20">野菜品名</asp:ListItem>
        <asp:ListItem Value="30">野菜分類</asp:ListItem>
        <asp:ListItem Value="40">EDI分類</asp:ListItem>
    </asp:RadioButtonList></td></tr>
<tr><th>一覧</th><td><asp:TextBox ID="Products" runat="server" /></td></tr>
<tr><th colspan="2">制限開始</th><td><asp:TextBox ID="BeginDate" runat="server" /></td></tr>
<tr><th colspan="2">制限解除</th><td><asp:TextBox ID="EndDate" runat="server" /></td></tr>
<tr><th colspan="2">コメント</th><td><asp:TextBox ID="Comment" runat="server" /></td></tr>
</tbody>
</table>
<asp:Button ID="Create" runat="server" onclick="Create_Click" Text="作成" />

</asp:Content>
