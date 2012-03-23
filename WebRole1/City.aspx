<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="City.aspx.cs" Inherits="WebRole1.City" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h2><a href="Browse.aspx">地域別</a> &gt; <a href="Pref.aspx?q=<% = Request["pref"] %>"><% = Request["pref"] %></a> &gt; <% = Request["city"] %></h2>

<div id="updates">
<ul>
<li><img src="images/new.png" />グラフ表示を追加しました。(2011.5.30)</li>
</ul>
</div>
    <div>
    <p>
    <% = String.Format("{0}({1})の検査データは<span style=\"font-size:18px;font-weight:bold;\">{2}</span>件あります。このうち暫定規制値を超えた放射性物質が検出されたものは<span style=\"font-size:18px;font-weight:bold;\">{3}</span>件です。", cityName, prefName, list.Count, list.Count(x => x.Is暫定規制値Over))%>
    <a href="http://twitter.com/share" data-count="none" data-url="<% = Request.Url.AbsoluteUri %>" data-text=<% = String.Format("{0}({1})の放射能検査データは{2}件。暫定規制値を超えたのは{3}件。", cityName, prefName, list.Count, list.Count(x => x.Is暫定規制値Over))%> #yasaikensa" class="twitter-share-button" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    </p>
    <div id="time-series-chart">
    <img src="SearchChartImage.ashx?width=800&pref=<% = prefName %>&city=<% =cityName %>" />
        <div class="chart-caption">
        グラフは震災発生日からの経過日数毎の放射性ヨウ素、放射性セシウムの検出量(Bq/kg)の最大値、最小値、中央値(=(最大値+最小値)/2)を表しています。
        </div>
    </div>

    <table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;">
    <tr style="color:White;background-color:#1C5E55;font-weight:bold;">
        <td rowspan="2" scope="col">No</td>
        <td rowspan="2" scope="col">実施主体</td>
        <td colspan="2" scope="col">産地</td>
        <td rowspan="2" scope="col">採取区分</td>
        <td rowspan="2" scope="col">食品分類</td>
        <td rowspan="2" scope="col">品目</td>
        <td rowspan="2" scope="col">検査機関</td>
        <td rowspan="2" scope="col">採取日<br />(購入日)</td>
        <td rowspan="2" scope="col">結果<br />判明日</td>
        <td rowspan="2" scope="col">厚生省<br />公表日</td>
        <td colspan="3" scope="col">結果(Bq/kg)</td>
        <td rowspan="2"></td>
    </tr>
    <tr style="color:White;background-color:#1C5E55;font-weight:bold;">
        <td scope="col">都道府県</td>
        <td scope="col">市町村</td>
        <td scope="col">ヨウ素-131</td>
        <td scope="col">セシウム-134</td>
        <td scope="col">セシウム-137</td>
    </tr>
    <% int counter = 0;  foreach (var item in list)
       { %>
    <tr <% if(counter++%2==0){ %> style="background-color:#E3EAEB;" <% }else{ %> style="background-color:White;"<%} %>>
        <td><% = item.No%></td>        
        <td><% = item.実施主体%></td>        
        <td><% = item.産地都道府県%></td>        
        <td><% = item.産地市町村%></td>        
        <td><% = item.農場採取流通品%></td>        
        <td><a href="category.aspx?category=<% =  HttpUtility.UrlEncode(item.食品カテゴリ) %>"><% = item.食品カテゴリ%></a></td>        
        <td><a href="product.aspx?product=<% =  HttpUtility.UrlEncode(item.品目) %>&amp;category=<% =  HttpUtility.UrlEncode(item.食品カテゴリ) %>"><% = item.品目%></a></td>        
        <td><% = item.検査機関%></td>        
        <td><% = item.採取日%></td>        
        <td><% = item.結果判明日%></td>        
        <td><% = item.厚生省発表日%></td>        
        <td <% if(item.Isヨウ素Over){ %>style="background-color:orange;"<%} %> ><% = item.結果ヨウ素131%></td>
        <% if (item.結果セシウム != "-")
           { %>
        <td colspan="2" <% if(item.IsセシウムOver){ %>style="background-color:orange;"<%} %> ><%= item.結果セシウム%></td>
         <%}
           else
           { %>     
        <td <% if(item.IsセシウムOver){ %>style="background-color:orange;"<%} %> ><% = item.結果セシウム134%></td>        
        <td <% if(item.IsセシウムOver){ %>style="background-color:orange;"<%} %> ><% = item.結果セシウム137%></td>        
        <%} %>
        <td><a href="detail.aspx?no=<% = item.No %>">詳細</a></td>           </tr>   
    <% } %>
    </table>
    </div>
<p>
不検出：ND、暫定規制値以上：黄色
</p>
</asp:Content>
