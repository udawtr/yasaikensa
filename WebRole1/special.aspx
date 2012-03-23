<%@ Page Title="出荷制限のあった地域と品目の放射能検査結果のグラフ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="special.aspx.cs" Inherits="WebRole1.special" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<H3 class="subtitle">出荷制限のあった地域と品目の放射能検査結果のグラフ
<div id="social">
    <a href="http://twitter.com/share?text=出荷制限のあった地域と品目の放射能検査結果のグラフ #yasaikensa" class="twitter-share-button" data-url="http://yasaikensa.cloudapp.net/special.aspx" data-count="horizontal" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
</div>
</H3>
<p>
出荷制限のあった地域と品目ごとに放射能検査結果をグラフにプロットしました。グラフは随時最新のデータに基づいて自動生成されています。
</p>

<a name="home"></a>
<ul>
<% foreach (var pref in this.RestrictList.GroupBy(x=>x.PrefName)) { %>
    <li><% = pref.Key %></li>
    <ul>
        <% foreach(var item in pref.ToList() ){ %>
        <li><a href="#<% = item.Code %>"><% = item.Caption %></a></li>
        <% } %>
    </ul>
<% } %>
</ul>

<% foreach(var item in RestrictList ){ %>
<div>
    <a name="<% = item.Code %>"></a><h2><% = item.Caption %></h2>
    <img src="SpecialChartImage.ashx?q=<% = item.Code %>" />
    <br />
    <% if (!String.IsNullOrEmpty(item.Comment)) { %>
    <% = item.Comment%><br />
    <% } %>
    <A HREF="javascript:history.back()">戻る</A>
</div>
<% } %>



</asp:Content>