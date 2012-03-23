<%@ Page Title="品目別 | 食品の放射能検査データ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BrowseByProduct.aspx.cs" Inherits="WebRole1.BrowseByProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="subtitle">検査結果のある食品カテゴリ
    <div id="social">
    <a href="http://twitter.com/share?text=品目別食品の放射能検査データ #yasaikensa" class="twitter-share-button" data-url="http://yasaikensa.cloudapp.net/BrowseByProduct.aspx" data-count="horizontal" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    </div>
    </h3>
    <div>
    <ul>
        <% foreach (var item in categoryList) { %>
               <li><a href="category.aspx?q=<% = HttpUtility.UrlEncode(item.Key) %>"><% = item.Key %></a> [<% = item.Value %>] </li>
        <% } %>
    </ul>
    ※括弧内の数値はデータ件数です。
    </div>
</asp:Content>
