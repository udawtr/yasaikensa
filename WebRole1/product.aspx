<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" EnableViewState="false" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="WebRole1.product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><a href="BrowseByProduct.aspx">食品カテゴリ別</a> &gt; 
<a href="Category.aspx?q=<% = categoryName %>"><% = categoryName %></a> 
&gt; <% = Request["product"] %></h2>
    <div>
    <p>
    <% = String.Format("{0}({1})の放射能検査データは<span style=\"font-size:18px;font-weight:bold;\">{2}</span>件あります。このうち暫定規制値を超えた放射性物質が検出されたものは<span style=\"font-size:18px;font-weight:bold;\">{3}</span>件です。", productName, categoryName, list.Count, list.Count(x => x.Is暫定規制値Over))%>
    <a href="http://twitter.com/share" data-count="none" data-url="<% = Request.Url.AbsoluteUri %>" data-text="<% = String.Format("{0}({1})の検査データは{2}件。暫定規制値を超えたものは{3}件。", productName, categoryName, list.Count, list.Count(x => x.Is暫定規制値Over))%> #yasaikensa" class="twitter-share-button" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    <br />
    検査された産地は<% = String.Join(",",list.GroupBy(x => x.産地都道府県).OrderByDescending(x => x.Count()).Select(x=>String.Format("{0}({1})", x.Key,x.Count())).ToList()) %>です。<br />
    1週間以内に採取された<% = productName %>の検査データは<span style="font-size:18px;font-weight:bold;"><% = list.Count(x=>x.採取日D.HasValue && x.採取日D.Value >= DateTime.Now.AddDays(-7.0)) %></span>件です。
    </p>
<% if (categoryName == "野菜類" && EDIData != null) { %>
    <p>
        <% = EDIData.別称 %>
    </p>
<%} %>  
    <asp:Image ID="bqByDayImage" runat="server" />
    <asp:Image ID="prefImage" runat="server" />

    <table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;">
    <tr style="color:White;background-color:#1C5E55;font-weight:bold;">
        <td rowspan="2" scope="col">No</td>
        <td rowspan="2" scope="col">実施主体</td>
        <td colspan="2" scope="col">産地</td>
        <td rowspan="2" scope="col">採取区分</td>
        <td rowspan="2" scope="col">品目</td>
        <td rowspan="2" scope="col">検査機関</td>
        <td rowspan="2" scope="col">採取日<br />(購入日)</td>
        <td rowspan="2" scope="col">結果<br />判明日</td>
        <td rowspan="2" scope="col">厚生省<br />公表日</td>
        <td colspan="3" scope="col">結果(Bq/kg)</td>
        <td rowspan="2">詳細</td>
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
        <td><a href="pref.aspx?q=<% =  HttpUtility.UrlEncode(item.産地都道府県) %>"><% = item.産地都道府県%></a></td>        
        <td><a href="city.aspx?city=<% =  HttpUtility.UrlEncode(item.産地市町村) %>&amp;pref=<% =  HttpUtility.UrlEncode(item.産地都道府県) %>"><% = item.産地市町村%></a></td>        
        <td><% = item.農場採取流通品%></td>        
        <td><% = item.品目%></td>        
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
    </tr>   
    <% } %>
    </table>
    </div>
<p>
不検出：ND、暫定規制値以上：黄色
</p>
</asp:Content>
