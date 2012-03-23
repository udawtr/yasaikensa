<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="normalize_datetime.aspx.cs" Inherits="WebRole1.admin.normalize_datetime" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<div style="margin:10px 0;">
<a href="default.aspx">管理メニュー</a>&nbsp;&gt&nbsp;日付の正規化
</div>

    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        style="height: 21px" Text="実行" />
    </form>
</asp:Content>