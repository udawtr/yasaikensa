<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="sredit.aspx.cs" Inherits="WebRole1.admin.sredit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/base/jquery-ui.css" type="text/css" media="all" />
			<link rel="stylesheet" href="http://static.jquery.com/ui/css/demo-docs-theme/ui.theme.css" type="text/css" media="all" />
            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js" />
<script>
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div style="margin:10px 0;">
<a href="default.aspx">管理メニュー</a>&nbsp;&gt&nbsp;<a href="SRList.aspx">出荷制限</a>&nbsp;&gt;&nbsp;編集
</div>

<table border=1>
<tbody>
<tr><th colspan="2">コード</th><td><asp:TextBox ID="Code" runat="server" Enabled="false"></asp:TextBox></td></tr>
<tr><th colspan="2">表題</th><td><asp:TextBox ID="Caption" runat="server" 
        Columns="80" /></td></tr>
<tr><th colspan="2">都道府県</th><td>
    <asp:DropDownList ID="PrefName" runat="server" AutoPostBack="True" 
        onselectedindexchanged="PrefName_SelectedIndexChanged">
    </asp:DropDownList>
    </td></tr>
<tr><th rowspan="2">市町村</th><th>モード</th><td>
    <asp:RadioButtonList ID="CityFilterMode" runat="server" AutoPostBack="True" 
        RepeatDirection="Horizontal" RepeatLayout="Flow" 
        onselectedindexchanged="CityFilterMode_SelectedIndexChanged">
        <asp:ListItem Value="0">全て</asp:ListItem>
        <asp:ListItem Value="1">指定市区町村のみ</asp:ListItem>
        <asp:ListItem Value="2">指定市区町村を除く</asp:ListItem>
</asp:RadioButtonList></td></tr>
<tr><th>一覧</th><td>複数指定の場合は、カンマ(,)で区切ります。<br /><asp:TextBox ID="Cities" runat="server" Rows="4" 
        TextMode="MultiLine" Width="412px" />
    <br />
    <asp:Label ID="PrefNameTips" runat="server" Visible="False"></asp:Label>
    </td></tr>
<tr><th rowspan="2">商品</th><th>モード</th><td>
    <asp:RadioButtonList ID="ProductFilterMode" runat="server" AutoPostBack="True" 
        RepeatDirection="Horizontal" RepeatLayout="Flow" 
        onselectedindexchanged="ProductFilterMode_SelectedIndexChanged">
        <asp:ListItem Value="0">全て</asp:ListItem>
        <asp:ListItem Value="10">品目</asp:ListItem>
        <asp:ListItem Value="11">品目(先頭一致)</asp:ListItem>
        <asp:ListItem Value="20">野菜品名</asp:ListItem>
        <asp:ListItem Value="30">野菜分類</asp:ListItem>
        <asp:ListItem Value="40">EDI分類</asp:ListItem>
    </asp:RadioButtonList></td></tr>
<tr><th>一覧</th><td>複数指定の場合は、カンマ(,)で区切ります。<br /><asp:TextBox ID="Products" 
        runat="server" Columns="80" /></td></tr>
<tr><th colspan="2">制限開始</th><td><asp:TextBox ID="BeginDate" runat="server" /></td></tr>
<tr><th colspan="2">制限解除</th><td><asp:TextBox ID="EndDate" runat="server" /></td></tr>
<tr><th colspan="2">コメント</th><td><asp:TextBox ID="Comment" runat="server" /></td></tr>
</tbody>
</table>
<script>
    $(document).ready(function () {
        $('#MainContent_BeginDate').datepicker();
    });
</script>
<asp:Button ID="Update" runat="server" Text="更新" onclick="Update_Click" />
<asp:Button ID="Insert" runat="server" Text="保存" onclick="Insert_Click" />
</asp:Content>
