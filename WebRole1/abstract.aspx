<%@ Page Title="概略 | 食品の放射能検査データ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="abstract.aspx.cs" Inherits="WebRole1._abstract" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type='application/javascript'>
    // Send the POST when the page is loaded,
    // which will replace this whole page with the retrieved chart.
    function loadGraph() {
        var frm = document.getElementById('post_form');
        if (frm) {
            frm.submit();
        }
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
<H3 class="subtitle">食品中の放射能検査の結果概況
<div id="social">
    <a href="http://twitter.com/share?text=食品中の放射性物質検査の結果概況 #yasaikensa" class="twitter-share-button" data-url="http://yasaikensa.cloudapp.net/abstract.aspx" data-count="horizontal" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    </div>
</H3>
</p>
<div id="updates">
<ul>
    <li><img src="images/new.png" />対象期間が選択できるようになりました。(2011.5.30)</li>
</ul>
</div>
<p>
対象期間: 
    <asp:RadioButtonList ID="publishDayFilter" runat="server" RepeatLayout=Flow 
        RepeatDirection=Horizontal AutoPostBack="True" 
        onselectedindexchanged="publishDayFilter_SelectedIndexChanged">
        <asp:ListItem Text="全て" Value="ALL" />
        <asp:ListItem Text="3週間以内" Selected="True" Value="3W" />
    </asp:RadioButtonList>
</p>

    <div id="time-series-chart">
        <asp:Image ID="bqByDayImage" runat="server" />
        <div class="chart-caption">
        グラフは震災発生日からの経過日数毎の放射性ヨウ素、放射性セシウムの検出量(Bq/kg)の最大値、最小値、中央値(=(最大値+最小値)/2)を表しています。
        </div>
    </div>

<table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;border-top:1px solid black;">
<tr style="color:White;background-color:#1C5E55;font-weight:bold;">
    <td>産地</td>
    <td>食品群</td>
    <td>検査件数</td>
    <td>規制値超過件数</td>
    <td>超過品目</td>
</tr>
<% int rowcounter = 1; 
   foreach (var pref in list.Select(x => x.産地都道府県).Distinct())
   {
       var catlist = (from x in list
                     where x.産地都道府県 == pref
                     group x by x.食品カテゴリ into xcat
                     join c in categoryList on xcat.Key equals c.Name into clist
                     from x2 in clist
                     orderby x2.No
                     select xcat.Key).ToList();
       %>
<tr <% if(++rowcounter%2==0){ %> style="background-color:#E3EAEB;" <% }else{ %> style="background-color:White;"<%} %>>
    <td rowspan="<% = catlist.Count() + 1 %>"><a href="search.aspx?pref=<% =  HttpUtility.UrlEncode(pref)%>"><% = pref %></a></td>
    <td><a href="search.aspx?pref=<% =  HttpUtility.UrlEncode(pref)%>&amp;category=<% =  HttpUtility.UrlEncode(catlist[0]) %>"><% = catlist[0]%></a></td>
    <td><% = list.Where(x => x.産地都道府県 == pref && x.食品カテゴリ == catlist[0]).Count()%></td>
    <td><% = list.Where(x => x.産地都道府県 == pref && x.食品カテゴリ == catlist[0] && x.Is暫定規制値Over).Count()%></td>
    <td style="text-align:left;">
    <%  int counter = 0;
        foreach (var item in list.Where(x => x.産地都道府県 == pref && x.食品カテゴリ == catlist[0] && x.Is暫定規制値Over).GroupBy(x => x.品目).OrderByDescending(x=>x.Count()))
        {
            counter++;
            %>
            <a href="search.aspx?pref=<% =  HttpUtility.UrlEncode(pref)%>&amp;product=<% =  HttpUtility.UrlEncode(item.Key) %>&amp;category=<% =  HttpUtility.UrlEncode(catlist[0]) %>">
            <% = String.Format("{0}({1})</a>、 ", item.Key, item.Count())%>
            <% if (counter % 5 == 0)
               { %><br /><%} %>
    <%} %>
    &nbsp;
    </td>
</tr>
<% foreach (var cat in catlist.Skip(1))
   { %>
<tr <% if(rowcounter%2==0){ %> style="background-color:#E3EAEB;" <% }else{ %> style="background-color:White;"<%} %>>
    <td><a href="search.aspx?pref=<% =  HttpUtility.UrlEncode(pref)%>&amp;category=<% =  HttpUtility.UrlEncode(cat) %>"><% = cat%></a></td>
    <td><% = list.Where(x => x.産地都道府県 == pref && x.食品カテゴリ == cat).Count()%></td>
    <td><% = list.Where(x => x.産地都道府県 == pref && x.食品カテゴリ == cat && x.Is暫定規制値Over).Count()%></td>
    <td style="text-align:left;">
    <%  counter = 0;
        foreach (var item in list.Where(x => x.産地都道府県 == pref && x.食品カテゴリ == cat && x.Is暫定規制値Over).GroupBy(x => x.品目).OrderByDescending(x => x.Count()))
        {
            counter++;
            %>
            <a href="search.aspx?pref=<% =  HttpUtility.UrlEncode(pref)%>&amp;product=<% =  HttpUtility.UrlEncode(item.Key) %>&amp;category=<% =  HttpUtility.UrlEncode(cat) %>">
            <% = String.Format("{0}({1})</a>、 ", item.Key, item.Count())%>
            <% if (counter % 5 == 0)
               { %><br /><%} %>
    <% } %>
    &nbsp;
    </td>
</tr>
<% } %>
<tr <% if(rowcounter%2==0){ %> style="background-color:#E3EAEB;" <% }else{ %> style="background-color:White;"<%} %>>
    <td>小計</td>
    <td><% = list.Where(x => x.産地都道府県 == pref).Count()%></td>
    <td><% = list.Where(x => x.産地都道府県 == pref && x.Is暫定規制値Over).Count()%></td>
    <td>&nbsp;</td>
</tr>       
<% } %>
<tr style="color:black;background-color:lightgray;">
    <td colspan="2">総計</td>
    <td><% = list.Count() %></td>
    <td><% = list.Where(x=>x.Is暫定規制値Over).Count() %></td>
    <td>&nbsp;</td>
</tr>
</table>
</asp:Content>
